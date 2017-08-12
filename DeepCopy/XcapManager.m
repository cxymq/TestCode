//
//  XcapManager.m
//  SmartHome
//
//  Created by git on 17/2/27.
//  Copyright © 2017年 octatech.com. All rights reserved.
//

#import "XcapManager.h"

#define SIP_SERVER @"118.144.86.70:5527"
#define ACCESS_PATH @"xcap-root/resource-lists/users/"

@implementation XcapManager

-(NSURLSession *)session {
    if (!_session) {
        _session = [NSURLSession sharedSession];
    }
    return _session;
}

singleton_implementation(XcapManager)

- (NSString *)accessPathWithUserId:(NSString *)userId isAll:(BOOL)isAll buddyId:(NSString *)buddyId{
    NSString *str = [NSString stringWithFormat:@"http://%@/%@%@/",SIP_SERVER,ACCESS_PATH,userId];
    if (isAll) {
        
        if (buddyId) {
            str = [str stringByAppendingFormat:@"buddy/~~/body/buddy[@id=%%22%@%%22]",buddyId];
        }else {
            str = [str stringByAppendingString:@"buddy/"];
        }
    }else {
        str = [str stringByAppendingString:@"info/"];
        if (buddyId) {
            str = [str stringByAppendingFormat:@"buddy/~~/info/doors[@id=%%22%@%%22]",buddyId];
        }
    }
    
    return str;
}

- (void)xcapGetContractsBuddyWithUserId:(NSString *)userId isAll:(BOOL)isAll buddyId:(NSString *)buddyId success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSString *str = [self accessPathWithUserId:userId isAll:isAll buddyId:buddyId];
    NSURL *url = [NSURL URLWithString:str];
    NSLog(@"getInfoStr:%@", str);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10.0f;
    request.HTTPMethod = @"GET";
    
    __block NSURLSessionDataTask *task = nil;
    task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
        NSLog(@"GETresp.statusCode:%ld", resp.statusCode);
        if (error) {
            if (failure) {
                failure(task,error);
            }
        }else {
            if (success) {
                success(task,data);
            }
        }
    }];
    [task resume];
}

- (void)xcapPutContractsBuddyWithUserId:(NSString *)userId buddyStr:(NSString *)buddyStr isAll:(BOOL)isAll buddyId:(NSString *)buddyId success:(void (^)(NSURLSessionUploadTask *, id))success failure:(void (^)(NSURLSessionUploadTask *, NSError *))failure{
    NSString *str = [self accessPathWithUserId:userId isAll:isAll buddyId:buddyId];
    NSLog(@"PutStr:%@", str);
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10.0f;
    request.HTTPMethod = @"PUT";
    NSData *data = [buddyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    __block NSURLSessionUploadTask *uploadTask = nil;
    uploadTask = [self.session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
        NSLog(@"Putresp.statusCode:%ld", resp.statusCode);
        if (error) {
            if (failure) {
                failure(uploadTask,error);
            }
        }else {
            if (success) {
                success(uploadTask,data);
            }
        }
    }];
    [uploadTask resume];
}

- (void)xcapDeleteContractsBuddyWithUserId:(NSString *)userId isAll:(BOOL)isAll buddyId:(NSString *)buddyId success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSString *str = [self accessPathWithUserId:userId isAll:isAll buddyId:buddyId];
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10.0f;
    request.HTTPMethod = @"delete";
    
    __block NSURLSessionDataTask *task = nil;
    task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
        NSLog(@"%ld", resp.statusCode);
        if (error) {
            if (failure) {
                failure(task,error);
            }
        }else {
            if (success) {
                success(task,data);
            }
        }
    }];
    [task resume];
}

@end
