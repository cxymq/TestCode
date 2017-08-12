//
//  XcapManager.h
//  SmartHome
//
//  Created by git on 17/2/27.
//  Copyright © 2017年 octatech.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface XcapManager : NSObject

@property (nonatomic, strong) NSURLSession *session;

singleton_interface(XcapManager)

//获取所有好友Layout或者单个xml
- (void)xcapGetContractsBuddyWithUserId:(NSString *)userId isAll:(BOOL)isAll buddyId:(NSString *)buddyId success:(void (^) (NSURLSessionDataTask *dataTask,id responseObj))success failure:(void (^) (NSURLSessionDataTask *dataTask,NSError *error))failure;
//上传用户的Layout或者单个xml
- (void)xcapPutContractsBuddyWithUserId:(NSString *)userId buddyStr:(NSString *)buddyStr isAll:(BOOL)isAll buddyId:(NSString *)buddyId success:(void(^)(NSURLSessionUploadTask *uploadTask,id responseObj))success failure:(void(^)(NSURLSessionUploadTask *uploadTask,NSError *error))failure;
//删除所有Layout或者单个xml
- (void)xcapDeleteContractsBuddyWithUserId:(NSString *)userId isAll:(BOOL)isAll buddyId:(NSString *)buddyId success:(void(^)(NSURLSessionDataTask *dataTask,id responseObj))success failure:(void(^)(NSURLSessionDataTask *dataTask,NSError *error))failure;
@end
