//
//  MGJRequestManager.h
//  MGJFoundation
//
//  Created by limboy on 12/10/14.
//  Copyright (c) 2014 juangua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

extern NSInteger const MGJResponseCancelError;

/**
 *  将 error 和 result 统一在一个 object 中存放，处理起来会比较方便
 */
@interface MGJResponse : NSObject
@property (nonatomic) NSError *error;
@property (nonatomic) id result;
@end



@interface MGJRequestManagerConfiguration : NSObject <NSCopying>
/**
 *  如果 <= 0，表示不启用缓存。单位为秒，表示对于一个请求的结果缓存多长时间
 */
@property (nonatomic, assign) NSInteger resultCacheDuration;

/**
 *  如 http://api.mogujie.com
 */
@property (nonatomic, copy) NSString *baseURL;

/**
 *  默认使用 AFHTTPRequestSerializer
 */
@property (nonatomic) AFHTTPRequestSerializer *requestSerializer;

/**
 *  默认使用 AFHTTPResponseSerializer
 */
@property (nonatomic) AFHTTPResponseSerializer *responseSerializer;

/**
 * 可以对返回的数据做一些预处理
 * 设置 *shouldStopProcessing 为 YES 不会触发 CompletionHandler，可以用在 refreshToken
 */
@property (nonatomic, copy) void (^responseHandler)(AFHTTPRequestOperation *operation, id userInfo, MGJResponse *response, BOOL *shouldStopProcessing);

/**
 *  发送数据之前可以做一些预处理，如果觉得可以取消此次发送，设置 *shouldStopProcessing 为 YES 即可
 */
@property (nonatomic, copy) void (^requestHandler)(AFHTTPRequestOperation *operation, id userInfo, BOOL *shouldStopProcessing);

/**
 *  此次请求可以附带的信息，会传给 preRequestHandler 和 postRequestHandler
 */
@property (nonatomic) id userInfo;

/**
 *  每次请求都要带上的一些参数
 */
@property (nonatomic) NSDictionary *builtinParameters;

@property (nonatomic,strong) NSDictionary *builtinHeaders;

@end


typedef void (^MGJRequestManagerConfigurationHandler)(MGJRequestManagerConfiguration *configuration);

typedef void (^MGJRequestManagerCompletionHandler)(NSError *error, id result, BOOL isFromCache, AFHTTPRequestOperation *operation);

typedef void (^MGJRequestManagerParametersHandler)(NSMutableDictionary *requestParameters, NSMutableDictionary *builtinParameters);

@interface MGJRequestManager : NSObject

+ (instancetype)sharedInstance;

/**
 *  当前的网络状态
 */
@property (nonatomic) AFNetworkReachabilityStatus networkStatus;

/**
 *  拿到 sharedInstance 后，可以设置这个 property，当 configuration 中的某几项有变动，
 *  并且要对全局做更改时，可以再次设置这个 property
 */
@property(nonatomic) MGJRequestManagerConfiguration *configuration;

/**
 *  正在发送的请求们，里面是一些 AFHTTPRequestOperation
 */
@property (nonatomic, readonly) NSArray *runningRequests;

/**
 *  可以对请求的参数做处理，比如去掉一些特殊字符、加密、计算哈希值等
 */
@property (nonatomic, copy) MGJRequestManagerParametersHandler parametersHandler;

/**
 *  将 Operation 放到某个 Chain 里，一次执行一个
 *
 *  @param chainName
 */
- (void)addOperation:(AFHTTPRequestOperation *)operation toChain:(NSString *)chain;

/**
 *  获取某个 Chain 里所有的 Operations
 *
 *  @param chainName
 */
- (NSArray *)operationsInChain:(NSString *)chain;

/**
 *  移除某个 Chain 里的某个 Operation
 *
 *  @param operation
 *  @param chain     
 */
- (void)removeOperation:(AFHTTPRequestOperation *)operation inChain:(NSString *)chain;

/**
 *  移除某个 Chain 里的所有 Operations
 *
 *  @param chain
 */
- (void)removeOperationsInChain:(NSString *)chain;

/**
 *  并行执行一些列Operation
 *
 *  @param operations      待执行的operations
 *  @param progressBlock
 *  @param completionBlock
 */
- (void)batchOfRequestOperations:(NSArray *)operations
                        progressBlock:(void (^)(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations))progressBlock
                      completionBlock:(void (^)())completionBlock;

/**
 *  开始执行 Operation，这个 Operation 可以是之前设置 startImmediately 为 NO 的
 *
 *  @param operation 
 */
- (AFHTTPRequestOperation *)startOperation:(AFHTTPRequestOperation *)operation;

/**
 *  取消所有正在发送的请求
 */
- (void)cancelAllRequest;

/**
 *  取消某个/些正在发送的请求
 *
 *  @param method                可以是 GET/POST/DELETE/PUT
 *  @param url                   要取消的 url
 */
- (void)cancelHTTPOperationsWithMethod:(NSString *)method url:(NSString *)url;

/**
 *  这个方法厉害了！正常的话，一个 Operation 如果已经完成，那么 completionBlock 就会被设为空
 *  使用 `[operation copy]` 虽然可以拿到一个初始状态的 operation，但是之前设置的
 *  completionBlock 是不会被触发的。使用这个方法可以让之前的 completionBlock 依旧被触发
 *
 *  @param operation 已经处于完成状态的 Operation
 *
 *  @return 一个新的 Operation
 */
- (AFHTTPRequestOperation *)reAssembleOperation:(AFHTTPRequestOperation *)operation;


- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
               startImmediately:(BOOL)startImmediately
           configurationHandler:(MGJRequestManagerConfigurationHandler)configurationHandler
              completionHandler:(MGJRequestManagerCompletionHandler)completionHandler;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                startImmediately:(BOOL)startImmediately
            configurationHandler:(MGJRequestManagerConfigurationHandler)configurationHandler
               completionHandler:(MGJRequestManagerCompletionHandler)completionHandler;

/**
 *  上传文件
 */
- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                startImmediately:(BOOL)startImmediately
       constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
            configurationHandler:(MGJRequestManagerConfigurationHandler)configurationHandler
               completionHandler:(MGJRequestManagerCompletionHandler)completionHandler;

- (AFHTTPRequestOperation *)PUT:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
               startImmediately:(BOOL)startImmediately
           configurationHandler:(MGJRequestManagerConfigurationHandler)configurationHandler
              completionHandler:(MGJRequestManagerCompletionHandler)completionHandler;

- (AFHTTPRequestOperation *)DELETE:(NSString *)URLString
                        parameters:(NSDictionary *)parameters
                  startImmediately:(BOOL)startImmediately
              configurationHandler:(MGJRequestManagerConfigurationHandler)configurationHandler
                 completionHandler:(MGJRequestManagerCompletionHandler)completionHandler;

- (AFHTTPRequestOperation *)HTTPRequestOperationWithMethod:(NSString *)method
                                                 URLString:(NSString *)URLString
                                                parameters:(NSDictionary *)parameters
                                          startImmediately:(BOOL)startImmediately
                                 constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                                      configurationHandler:(MGJRequestManagerConfigurationHandler)configurationHandler
                                         completionHandler:(MGJRequestManagerCompletionHandler)completionHandler;

@end
