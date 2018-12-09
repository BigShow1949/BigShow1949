//
//  YFNoteDataManager.m
//  BigShow1949
//
//  Created by big show on 2018/10/16.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFNoteDataManager.h"
#import "YFNoteModel.h"

@interface YFNoteDataManager()
@property (nonatomic, strong) NSMutableArray<NSString *> *noteUUIDs;
@property (nonatomic, strong) NSMutableArray<YFNoteModel *> *notes;

@end


@implementation YFNoteDataManager

#pragma mark - Public
- (NSArray<YFNoteModel *> *)noteList {
    return [self.notes copy];
}

+ (instancetype)sharedInsatnce {
    static YFNoteDataManager *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[YFNoteDataManager alloc] init];
    });
    return shared;
}

- (void)fetchAllNotesWithCompletion:(void(^)(NSArray *notes))completion {
    NSAssert([NSThread isMainThread], @"main thread only, otherwise use lock to make thread safety.");
    NSArray *noteList = self.noteList;
    if (!noteList) {
        self.noteUUIDs = [NSMutableArray array];
        self.notes = [NSMutableArray array];
        NSArray<NSString *> *uuids = [self noteListUUIDArray];
        NSMutableArray *notes = [NSMutableArray array];
        for (NSString *uuid in uuids) {
            YFNoteModel *note = [self localStoredNoteWithUUID:uuid];
            if (note) {
                [notes addObject:note];
            }
        }
        [self.noteUUIDs addObjectsFromArray:uuids];
        [self.notes addObjectsFromArray:notes];
        noteList = notes;
    }
    if (completion) {
        completion(noteList);
    }
}

- (void)storeNote:(YFNoteModel *)note {}
- (void)deleteNote:(YFNoteModel *)noteToDelete {}

#pragma mark - Private
- (YFNoteModel *)localStoredNoteWithUUID:(NSString *)uuid {
    NSParameterAssert(uuid);
    NSAssert([NSThread isMainThread], @"main thread only, otherwise use lock to make thread safety.");
    YFNoteModel *note = [NSKeyedUnarchiver unarchiveObjectWithFile:[YFNoteDataManager _o_pathForLocalStoredNoteWithUUID:uuid]];
    return note;
}

- (NSArray<NSString *> *)noteListUUIDArray {
    NSAssert([NSThread isMainThread], @"main thread only, otherwise use lock to make thread safety.");
    NSArray * noteListUUIDs = [NSKeyedUnarchiver unarchiveObjectWithFile:[YFNoteDataManager _o_pathForNoteListUUIDsFile]];
    if (!noteListUUIDs) {
        return @[];
    }
    return noteListUUIDs;
}

+ (NSString *)_o_pathForLocalStoredNoteWithUUID:(NSString *)uuid {
    NSParameterAssert(uuid);
    return [[self _o_pathForLocalStoreNote] stringByAppendingPathComponent:uuid];
}

+ (NSString *)_o_pathForNoteListUUIDsFile {
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [document stringByAppendingPathComponent:@"noteUUIDs"];
}

+ (NSString *)_o_pathForLocalStoreNote {
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [document stringByAppendingPathComponent:@"Notes"];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        NSAssert(error == nil, nil);
    });
    return path;
}
@end
