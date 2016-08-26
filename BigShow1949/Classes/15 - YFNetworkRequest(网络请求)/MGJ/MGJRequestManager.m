//
//  MGJRequestManager.m
//  MGJFoundation
//
//  Created by limboy on 12/10/14.
//  Copyright (c) 2014 juangua. All rights reserved.
//

#import "MGJRequestManager.h"

static NSString * const MGJRequestManagerCacheDirectory = @"requestCacheDirectory";
static NSString * const MGJFileProcessingQueue = @"MGJFileProcessingQueue";

NSInteger const MGJResponseCancelError = -1;

@implementation MGJResponse @end




#pragma mark - MGJResponseCache

@interface MGJResponseCache : NSObject

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key;

- (id <NSCoding>)objectForKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;

- (void)trimToDate:(NSDate *)date;

- (void)removeAllObjects;

@end

@implementation MGJResponseCache {
    NSCache *_memoryCache;
    NSFileManager *_fileManager;
    NSString *_cachePath;
    dispatch_queue_t _queue;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _memoryCache = [[NSCache alloc] init];
        _queue = dispatch_queue_create([MGJFileProcessingQueue UTF8String], DISPATCH_QUEUE_CONCURRENT);
        [self createCachesDirectory];
    }
    return self;
}

- (void)createCachesDirectory
{
    _fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    _cachePath = [cachePath stringByAppendingPathComponent:MGJRequestManagerCacheDirectory];
    BOOL isDirectory;
    if (![_fileManager fileExistsAtPath:_cachePath isDirectory:&isDirectory]) {
        __autoreleasing NSError *error = nil;
        BOOL created = [_fileManager createDirectoryAtPath:_cachePath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!created) {
            NSLog(@"<MGJRequestManager> - create cache directory failed with error:%@", error);
        }
    }
}

- (NSString *)encodedString:(NSString *)string
{
    if (![string length])
        return @"";
    
    CFStringRef static const charsToEscape = CFSTR(".:/");
    CFStringRef escapedString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (__bridge CFStringRef)string,
                                                                        NULL,
                                                                        charsToEscape,
                                                                        kCFStringEncodingUTF8);
    return (__bridge_transfer NSString *)escapedString;
}

- (NSString *)decodedString:(NSString *)string
{
    if (![string length])
        return @"";
    
    CFStringRef unescapedString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef)string,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    return (__bridge_transfer NSString *)unescapedString;
}


- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key
{
    NSString *encodedKey = [self encodedString:key];
    [_memoryCache setObject:object forKey:key];
    dispatch_async(_queue, ^{
        NSString *filePath = [_cachePath stringByAppendingPathComponent:encodedKey];
        BOOL written = [NSKeyedArchiver archiveRootObject:object toFile:filePath];
        if (!written) {
            NSLog(@"<MGJRequestManager> - set object to file failed");
        }
    });
}

- (id <NSCoding>)objectForKey:(NSString *)key
{
    NSString *encodedKey = [self encodedString:key];
    id<NSCoding> object = [_memoryCache objectForKey:encodedKey];
    if (!object) {
        NSString *filePath = [_cachePath stringByAppendingPathComponent:encodedKey];
        if ([_fileManager fileExistsAtPath:filePath]) {
            object = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        }
    }
    return object;
}

- (void)removeAllObjects
{
    [_memoryCache removeAllObjects];
    __autoreleasing NSError *error;
    BOOL removed = [_fileManager removeItemAtPath:_cachePath error:&error];
    if (!removed) {
        NSLog(@"<MGJRequestManager> - remove cache directory failed with error:%@", error);
    }
}

- (void)trimToDate:(NSDate *)date
{
    __autoreleasing NSError *error = nil;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[NSURL URLWithString:_cachePath]
                                                   includingPropertiesForKeys:@[NSURLContentModificationDateKey]
                                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                        error:&error];
    if (error) {
        NSLog(@"<MGJRequestManager> - get files error:%@", error);
    }

    dispatch_async(_queue, ^{
        for (NSURL *fileURL in files) {
            NSDictionary *dictionary = [fileURL resourceValuesForKeys:@[NSURLContentModificationDateKey] error:nil];
            NSDate *modificationDate = [dictionary objectForKey:NSURLContentModificationDateKey];
            if (modificationDate.timeIntervalSince1970 - date.timeIntervalSince1970 < 0) {
                [_fileManager removeItemAtPath:fileURL.absoluteString error:nil];
            }
        }
    });
}

- (void)removeObjectForKey:(NSString *)key
{
    NSString *encodedKey = [self encodedString:key];
    [_memoryCache removeObjectForKey:encodedKey];
    NSString *filePath = [_cachePath stringByAppendingPathComponent:encodedKey];
    if ([_fileManager fileExistsAtPath:filePath]) {
        __autoreleasing NSError *error = nil;
        BOOL removed = [_fileManager removeItemAtPath:filePath error:&error];
        if (!removed) {
            NSLog(@"<MGJRequestManager> - remove item failed with error:%@", error);
        }
    }
}

@end




#pragma mark - MGJRequestManagerConfiguration

@implementation MGJRequestManagerConfiguration

- (AFHTTPRequestSerializer *)requestSerializer
{
    return _requestSerializer ? : [AFHTTPRequestSerializer serializer];
}

- (AFHTTPResponseSerializer *)responseSerializer
{
    return _responseSerializer ? : [AFJSONResponseSerializer serializer];
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    MGJRequestManagerConfiguration *configuration = [[MGJRequestManagerConfiguration alloc] init];
    configuration.baseURL = [self.baseURL copy];
    configuration.resultCacheDuration = self.resultCacheDuration;
    configuration.builtinParameters = [self.builtinParameters copy];
    configuration.userInfo = [self.userInfo copy];
    configuration.builtinHeaders = [self.builtinParameters copy];
    return configuration;
}

@end




#pragma mark - MGJRequestManager

@interface MGJRequestManager ()
@property (nonatomic) AFHTTPRequestOperationManager *requestManager;
@property (nonatomic) NSMutableDictionary *chainedOperations;
/**
 *  避免引用 Operation 和 Block
 */
@property (nonatomic) NSMapTable *completionBlocks;
/**
 *  避免引用 Operation
 */
@property (nonatomic) NSMapTable *operationMethodParameters;
@property (nonatomic) MGJResponseCache *cache;
@property (nonatomic) NSMutableArray *batchGroups;
@end

@implementation MGJRequestManager

@synthesize configuration = _configuration;

+ (instancetype)sharedInstance
{
    static MGJRequestManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    return instance;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.networkStatus = AFNetworkReachabilityStatusUnknown;
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
        
        self.cache = [[MGJResponseCache alloc] init];
        self.chainedOperations = [[NSMutableDictionary alloc] init];
        self.completionBlocks = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory valueOptions:NSMapTableCopyIn];
        self.operationMethodParameters = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory valueOptions:NSMapTableStrongMemory];
        self.batchGroups = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)reachabilityChanged:(NSNotification *)notification
{
    self.networkStatus = [notification.userInfo[AFNetworkingReachabilityNotificationStatusItem] integerValue];
}

#pragma mark - Public

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
               startImmediately:(BOOL)startImmediately
           configurationHandler:(MGJRequestManagerConfigurationHandler)configurationHandler
              completionHandler:(MGJRequestManagerCompletionHandler)completionHandler
{
    return [self HTTPRequestOperationWithMethod:@"GET" URLString:URLString parameters:parameters startImmediately:startImmediately constructingBodyWithBlock:nil configurationHandler:configurationHandler completionHandler:completionHandler];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                startImmediately:(BOOL)startImmediately
            configurationHandler:(MGJRequestManagerConfigurationHandler)configurationHandler
               completionHandler:(MGJRequestManagerCompletionHandler)completionHandler
{
    return [self HTTPRequestOperationWithMethod:@"POST" URLString:URLString parameters:parameters startImmediately:startImmediately constructingBodyWithBlock:nil configurationHandler:configurationHandler completionHandler:completionHandler];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                startImmediately:(BOOL)startImmediately
       constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
            configurationHandler:(MGJRequestManagerConfigurationHandler)configurationHandler
               completionHandler:(MGJRequestManagerCompletionHandler)completionHandler
{
    return [self HTTPRequestOperationWithMethod:@"POST" URLString:URLString parameters:parameters startImmediately:startImmediately constructingBodyWithBlock:block configurationHandler:configurationHandler completionHandler:completionHandler];
}

- (AFHTTPRequestOperation *)PUT:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
               startImmediately:(BOOL)startImmediately
           configurationHandler:(MGJRequestManagerConfigurationHandler)configurationHandler
              completionHandler:(MGJRequestManagerCompletionHandler)completionHandler
{
    return [self HTTPRequestOperationWithMethod:@"PUT" URLString:URLString parameters:parameters startImmediately:startImmediately constructingBodyWithBlock:nil configurationHandler:configurationHandler completionHandler:completionHandler];
}

- (AFHTTPRequestOperation *)DELETE:(NSString *)URLString
                        parameters:(NSDictionary *)parameters
                  startImmediately:(BOOL)startImmediately
              configurationHandler:(MGJRequestManagerConfigurationHandler)configurationHandler
                 completionHandler:(MGJRequestManagerCompletionHandler)completionHandler
{
    return [self HTTPRequestOperationWithMethod:@"DELETE" URLString:URLString parameters:parameters startImmediately:startImmediately constructingBodyWithBlock:nil configurationHandler:configurationHandler completionHandler:completionHandler];
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithMethod:(NSString *)method
                                                 URLString:(NSString *)URLString
                                                parameters:(NSDictionary *)parameters
                                          startImmediately:(BOOL)startImmediately
                                 constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                                      configurationHandler:(MGJRequestManagerConfigurationHandler)configurationHandler
                                         completionHandler:(MGJRequestManagerCompletionHandler)completionHandler
{
    // 拿到 configuration 的副本，然后让调用方自定义该 configuration
    MGJRequestManagerConfiguration *configuration = [self.configuration copy];
    if (configurationHandler) {
        configurationHandler(configuration);
    }
    self.requestManager.requestSerializer = configuration.requestSerializer;
    self.requestManager.responseSerializer = configuration.responseSerializer;
    
    // 如果定义过 parametersHandler，可以对 builtin parameters 和 request parameters 进行调整
    // 比如需要根据这两个值计算 token
    if (self.parametersHandler) {
        NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
        NSMutableDictionary *mutableBultinParameters = [NSMutableDictionary dictionaryWithDictionary:configuration.builtinParameters];
        self.parametersHandler(mutableParameters, mutableBultinParameters);
        parameters = [mutableParameters copy];
        configuration.builtinParameters = [mutableBultinParameters copy];
    }
    
    NSString *combinedURL = [URLString stringByAppendingString:[self serializeParams:configuration.builtinParameters]];
    NSMutableURLRequest *request;
    
    if (block) {
        // 如果是上传的情况，特殊处理，把 block 塞进去
        request = [self.requestManager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:combinedURL relativeToURL:[NSURL URLWithString:configuration.baseURL]] absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
    } else {
        request = [self.requestManager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:combinedURL relativeToURL:[NSURL URLWithString:configuration.baseURL]] absoluteString] parameters:parameters error:nil];
    }
    
    if (configuration.builtinHeaders.count > 0) {
        for (NSString *key in configuration.builtinHeaders) {
            [request setValue:configuration.builtinHeaders[key] forHTTPHeaderField:key];
        }
    }
    
    // 根据 configuration 和 request 生成一个 operation
    AFHTTPRequestOperation *operation = [self createOperationWithConfiguration:configuration request:request];
    
    // 如果不是马上执行的话，先把参数记录下来，方便之后回放
    if (!startImmediately) {
        NSMutableDictionary *methodParameters = [NSMutableDictionary dictionaryWithDictionary:@{
                                           @"method": method,
                                           @"URLString": URLString,
                                           }];
        if (parameters) {
            methodParameters[@"parameters"] = parameters;
        }
        if (block) {
            methodParameters[@"constructingBodyWithBlock"] = block;
        }
        if (configurationHandler) {
            methodParameters[@"configurationHandler"] = configurationHandler;
        }
        if (completionHandler) {
            methodParameters[@"completionHandler"] = completionHandler;
        }
        
        [self.operationMethodParameters setObject:methodParameters forKey:operation];
        return operation;
    }
    
    
    __weak typeof(self) weakSelf = self;
    
    void (^checkIfShouldDoChainOperation)(AFHTTPRequestOperation *) = ^(AFHTTPRequestOperation *operation){
        __strong typeof(self) strongSelf = weakSelf;
        // TODO 不用每次都去找一下 ChainedOperations
        AFHTTPRequestOperation *nextOperation = [strongSelf findNextOperationInChainedOperationsBy:operation];
        if (nextOperation) {
            NSDictionary *methodParameters = [strongSelf.operationMethodParameters objectForKey:nextOperation];
            if (methodParameters) {
                [strongSelf HTTPRequestOperationWithMethod:methodParameters[@"method"]
                                               URLString:methodParameters[@"URLString"]
                                              parameters:methodParameters[@"parameters"]
                                        startImmediately:YES
                               constructingBodyWithBlock:methodParameters[@"constructingBodyWithBlock"]
                                    configurationHandler:methodParameters[@"configurationHandler"]
                                       completionHandler:methodParameters[@"completionHandler"]];
                [strongSelf.operationMethodParameters removeObjectForKey:nextOperation];
            } else {
                [strongSelf.requestManager.operationQueue addOperation:nextOperation];
            }
        }
    };
    
    // 对 request 做一层处理
    BOOL (^shouldStopProcessingRequest)(AFHTTPRequestOperation *, id userInfo, MGJRequestManagerConfiguration *) =  ^BOOL (AFHTTPRequestOperation *operation, id userInfo, MGJRequestManagerConfiguration *configuration) {
        BOOL shouldStopProcessing = NO;
        
        // 先调用默认的处理
        if (weakSelf.configuration.requestHandler) {
            weakSelf.configuration.requestHandler(operation, userInfo, &shouldStopProcessing);
        }
        
        // 如果客户端有定义过 requestHandler
        if (configuration.requestHandler) {
            configuration.requestHandler(operation, userInfo, &shouldStopProcessing);
        }
        return shouldStopProcessing;
    };
    
    // 对 response 做一层处理
    MGJResponse *(^handleResponse)(AFHTTPRequestOperation *, id,BOOL) = ^ MGJResponse *(AFHTTPRequestOperation *theOperation, id responseObject,BOOL isFromCache) {
        MGJResponse *response = [[MGJResponse alloc] init];
        // a bit trick :)
        response.error = [responseObject isKindOfClass:[NSError class]] ? responseObject : nil;
        response.result = response.error ? nil : responseObject;
        
        BOOL shouldStopProcessing = NO;
        
        // 先调用默认的处理
        if (weakSelf.configuration.responseHandler) {
            weakSelf.configuration.responseHandler(operation, configuration.userInfo, response, &shouldStopProcessing);
        }
        
        // 如果客户端有定义过 responseHandler
        if (configuration.responseHandler) {
            configuration.responseHandler(operation, configuration.userInfo, response, &shouldStopProcessing);
        }
        
        // shouldStopProcessing 的话, completionHandler 是不会被触发的
        if (shouldStopProcessing) {
            [weakSelf.completionBlocks removeObjectForKey:theOperation];
            return response;
        }
        
        completionHandler(response.error, response.result, isFromCache, theOperation);
        [weakSelf.completionBlocks removeObjectForKey:theOperation];
        
        checkIfShouldDoChainOperation(theOperation);
        return response;
    };
    
    // 如果设置为使用缓存，那么先去缓存里看一下
    if (configuration.resultCacheDuration > 0 && [method isEqualToString:@"GET"]) {
        NSString *urlKey = [URLString stringByAppendingString:[self serializeParams:parameters]];
        id result = [self.cache objectForKey:urlKey];
        if (result) {
            
            if (!shouldStopProcessingRequest(operation, configuration.userInfo, configuration)) {
                handleResponse(operation, result, YES);
            } else {
                NSError *error = [NSError errorWithDomain:@"取消请求" code:MGJResponseCancelError userInfo:nil];
                handleResponse(operation, error, NO);
            }
            return operation;
        }
    }
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *theOperation, id responseObject){
        MGJResponse *response = handleResponse(theOperation, responseObject,NO);
        
        // 如果使用缓存，就把结果放到缓存中方便下次使用
        if (configuration.resultCacheDuration > 0 && [method isEqualToString:@"GET"] && !response.error) {
            // 不使用 builtinParameters, 因为 builtin parameters 可能有时间这样的变量
            NSString *urlKey = [URLString stringByAppendingString:[self serializeParams:parameters]];
            [weakSelf.cache setObject:response.result forKey:urlKey];
        }
    } failure:^(AFHTTPRequestOperation *theOperation, NSError *error){
        handleResponse(theOperation, error,NO);
    }];
    
    if (!shouldStopProcessingRequest(operation, configuration.userInfo, configuration)) {
        [self.requestManager.operationQueue addOperation:operation];
    } else {
        NSError *error = [NSError errorWithDomain:@"取消请求" code:MGJResponseCancelError userInfo:nil];
        handleResponse(operation, error,NO);
    }
    
    [self.completionBlocks setObject:operation.completionBlock forKey:operation];
    
    return operation;
}

- (AFHTTPRequestOperation *)startOperation:(AFHTTPRequestOperation *)operation
{
    NSDictionary *methodParameters = [self.operationMethodParameters objectForKey:operation];
    AFHTTPRequestOperation *newOperation = operation;
    if (methodParameters) {
        newOperation = [self HTTPRequestOperationWithMethod:methodParameters[@"method"]
                                                                          URLString:methodParameters[@"URLString"]
                                                                         parameters:methodParameters[@"parameters"]
                                                                   startImmediately:YES
                                                          constructingBodyWithBlock:methodParameters[@"constructingBodyWithBlock"]
                                                               configurationHandler:methodParameters[@"configurationHandler"]
                                                                  completionHandler:methodParameters[@"completionHandler"]];
        [self.operationMethodParameters removeObjectForKey:operation];
    } else {
        [self.requestManager.operationQueue addOperation:operation];
    }
    return newOperation;
}

- (NSArray *)runningRequests
{
    return self.requestManager.operationQueue.operations;
}

- (void)cancelAllRequest
{
    [self.requestManager.operationQueue cancelAllOperations];
}

- (void)cancelHTTPOperationsWithMethod:(NSString *)method url:(NSString *)url
{
    NSError *error;
    
    NSString *pathToBeMatched = [[[self.requestManager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:url] absoluteString] parameters:nil error:&error] URL] path];
    
    for (NSOperation *operation in [self.requestManager.operationQueue operations]) {
        if (![operation isKindOfClass:[AFHTTPRequestOperation class]]) {
            continue;
        }
        BOOL hasMatchingMethod = !method || [method  isEqualToString:[[(AFHTTPRequestOperation *)operation request] HTTPMethod]];
        BOOL hasMatchingPath = [[[[(AFHTTPRequestOperation *)operation request] URL] path] isEqual:pathToBeMatched];
        
        if (hasMatchingMethod && hasMatchingPath) {
            [operation cancel];
        }
    }
}

- (void)addOperation:(AFHTTPRequestOperation *)operation toChain:(NSString *)chain
{
    NSString *chainName = chain ? : @"";
    if (!self.chainedOperations[chainName]) {
        self.chainedOperations[chainName] = [[NSMutableArray alloc] init];
    }
    
    // 只启动第一个，其余的在第一个执行完后会依次执行
    if (!((NSMutableArray *)self.chainedOperations[chainName]).count) {
        operation = [self startOperation:operation];
    }
    
    [self.chainedOperations[chainName] addObject:operation];
}

- (NSArray *)operationsInChain:(NSString *)chain
{
    return self.chainedOperations[chain];
}

- (void)removeOperation:(AFHTTPRequestOperation *)operation inChain:(NSString *)chain
{
    NSString *chainName = chain ? : @"";
    if (self.chainedOperations[chainName]) {
        NSMutableArray *chainedOperations = self.chainedOperations[chainName];
        [chainedOperations removeObject:operation];
    }
}

- (void)removeOperationsInChain:(NSString *)chain
{
    NSString *chainName = chain ? : @"";
    NSMutableArray *chainedOperations = self.chainedOperations[chainName];
    chainedOperations ? [chainedOperations removeAllObjects] : @"do nothing";
}

- (void)batchOfRequestOperations:(NSArray *)operations
                   progressBlock:(void (^)(NSUInteger, NSUInteger))progressBlock
                 completionBlock:(void (^)())completionBlock
{
    __block dispatch_group_t group = dispatch_group_create();
    [self.batchGroups addObject:group];
    __block NSInteger finishedOperationsCount = 0;
    NSInteger totalOperationsCount = operations.count;
    
    [operations enumerateObjectsUsingBlock:^(AFHTTPRequestOperation *operation, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *operationMethodParameters = [NSMutableDictionary dictionaryWithDictionary:[self.operationMethodParameters objectForKey:operation]];
        if (operationMethodParameters) {
            dispatch_group_enter(group);
            MGJRequestManagerCompletionHandler originCompletionHandler = [(MGJRequestManagerCompletionHandler) operationMethodParameters[@"completionHandler"] copy];
            
            MGJRequestManagerCompletionHandler newCompletionHandler = ^(NSError *error, id result, BOOL isFromCache, AFHTTPRequestOperation *theOperation) {
                if (!isFromCache) {
                    if (progressBlock) {
                        progressBlock(++finishedOperationsCount, totalOperationsCount);
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (originCompletionHandler) {
                        originCompletionHandler(error, result, isFromCache, theOperation);
                    }
                    dispatch_group_leave(group);
                });
            };
            operationMethodParameters[@"completionHandler"] = newCompletionHandler;
            
            [self.operationMethodParameters setObject:operationMethodParameters forKey:operation];
            [self startOperation:operation];
            
        }
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.batchGroups removeObject:group];
        if (completionBlock) {
            completionBlock();
        }
    });
}

- (AFHTTPRequestOperation *)reAssembleOperation:(AFHTTPRequestOperation *)operation
{
    AFHTTPRequestOperation *newOperation = [operation copy];
    newOperation.completionBlock = [self.completionBlocks objectForKey:operation];
    // 及时移除，避免循环引用
    [self.completionBlocks removeObjectForKey:operation];
    return newOperation;
}

#pragma mark - Utils

/**
 *  从 Chained Operations 中找到该 Operation 对应的下一个 Operation
 *  注意：会从 Chain 中移除该 Operation!
 */
- (AFHTTPRequestOperation *)findNextOperationInChainedOperationsBy:(AFHTTPRequestOperation *)operation
{
    //TODO 这个实现有优化空间
    __block AFHTTPRequestOperation *theOperation;
    __weak typeof(self) weakSelf = self;
    
    [self.chainedOperations enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSMutableArray *chainedOperations, BOOL *stop) {
        [chainedOperations enumerateObjectsUsingBlock:^(AFHTTPRequestOperation *requestOperation, NSUInteger idx, BOOL *stop) {
            if (requestOperation == operation) {
                if (idx < chainedOperations.count - 1) {
                    theOperation = chainedOperations[idx + 1];
                    *stop = YES;
                }
                [chainedOperations removeObject:requestOperation];
                // 同时移除对要返回的 operation 的引用
                [chainedOperations removeObject:theOperation];
            }
        }];
        if (chainedOperations) {
            *stop = YES;
        }
        if (!chainedOperations.count) {
            [weakSelf.chainedOperations removeObjectForKey:key];
        }
    }];
    
    return theOperation;
}

- (AFHTTPRequestOperationManager *)requestManager
{
    if (!_requestManager) {
        _requestManager = [AFHTTPRequestOperationManager manager] ;
    }
    return _requestManager;
}

- (MGJRequestManagerConfiguration *)configuration
{
    if (!_configuration) {
        _configuration = [[MGJRequestManagerConfiguration alloc] init];
    }
    return _configuration;
}

- (void)setConfiguration:(MGJRequestManagerConfiguration *)configuration
{
    if (_configuration != configuration) {
        _configuration = configuration;
        if (_configuration.resultCacheDuration > 0) {
            double pastTimeInterval = [[NSDate date] timeIntervalSince1970] - _configuration.resultCacheDuration;
            NSDate *pastDate = [NSDate dateWithTimeIntervalSince1970:pastTimeInterval];
            [self.cache trimToDate:pastDate];
        }
    }
}

- (AFHTTPRequestOperation *)createOperationWithConfiguration:(MGJRequestManagerConfiguration *)configuration request:(NSURLRequest *)request
{
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = self.requestManager.responseSerializer;
    operation.shouldUseCredentialStorage = self.requestManager.shouldUseCredentialStorage;
    operation.credential = self.requestManager.credential;
    operation.securityPolicy = self.requestManager.securityPolicy;
    operation.completionQueue = self.requestManager.completionQueue;
    operation.completionGroup = self.requestManager.completionGroup;
    return operation;
}

-(NSString *)serializeParams:(NSDictionary *)params {
    NSMutableArray *parts = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id<NSObject> obj, BOOL *stop) {
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSString *encodedValue = [obj.description stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject: part];
    }];
    NSString *queryString = [parts componentsJoinedByString: @"&"];
    return queryString ? [NSString stringWithFormat:@"?%@", queryString] : @"";
}
@end
