//
//  HMPAFNetWorkManager.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "HMPAFNetWorkManager.h"
@implementation HMPAFNetWorkManager
+(void)GET:(NSString *)requestUrl params:(NSDictionary *)params
   success:(HMPResponseSuccess)success fail:(HMPResponseFail)fail{
    AFHTTPSessionManager *manager = [HMPAFNetWorkManager managerWithBaseURL:nil sessionConfiguration:NO];
    // manager.requestSerializer.timeoutInterval = 30;
    
    [manager GET:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [NSJSONSerialization  JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(void)GET:(NSString *)requestUrl baseURL:(NSString *)baseUrl params:(NSDictionary *)params
   success:(HMPResponseSuccess)success fail:(HMPResponseFail)fail{
    
    AFHTTPSessionManager *manager = [HMPAFNetWorkManager managerWithBaseURL:baseUrl sessionConfiguration:NO];
    [manager GET:requestUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [HMPAFNetWorkManager responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
    
}

+(void)POST:(NSString *)requestUrl body:(NSDictionary *)params
    success:(HMPResponseSuccess)success fail:(HMPResponseFail)fail{
    
    AFHTTPSessionManager *manager = [HMPAFNetWorkManager managerWithBaseURL:nil sessionConfiguration:NO];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    NSLog(@"%@", requestUrl);
    [manager POST:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [HMPAFNetWorkManager responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(void)POST:(NSString *)requestUrl params:(NSDictionary *)params
    success:(HMPResponseSuccess)success fail:(HMPResponseFail)fail{
    
    AFHTTPSessionManager *manager = [HMPAFNetWorkManager managerWithBaseURL:nil sessionConfiguration:NO];
    NSLog(@"%@", requestUrl);
    [manager POST:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [HMPAFNetWorkManager responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(void)POST:(NSString *)requestUrl baseURL:(NSString *)baseUrl params:(NSDictionary *)params
    success:(HMPResponseSuccess)success fail:(HMPResponseFail)fail{
    
    AFHTTPSessionManager *manager = [HMPAFNetWorkManager managerWithBaseURL:baseUrl sessionConfiguration:NO];
    [manager POST:requestUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [HMPAFNetWorkManager responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(void)uploadWithURL:(NSString *)requestUrl params:(NSDictionary *)params fileData:(NSData *)filedata name:(NSString *)name fileName:(NSString *)filename mimeType:(NSString *) mimeType progress:(HMPProgress)progress success:(HMPResponseSuccess)success fail:(HMPResponseFail)fail{
    
    AFHTTPSessionManager *manager = [HMPAFNetWorkManager managerWithBaseURL:nil sessionConfiguration:NO];
    
    [manager POST:requestUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [HMPAFNetWorkManager responseConfiguration:responseObject];
        success(task,dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(void)uploadWithURL:(NSString *)requestUrl
             baseURL:(NSString *)baseurl
              params:(NSDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(HMPProgress)progress
             success:(HMPResponseSuccess)success
                fail:(HMPResponseFail)fail{
    
    AFHTTPSessionManager *manager = [HMPAFNetWorkManager managerWithBaseURL:baseurl sessionConfiguration:YES];
    [manager POST:requestUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [HMPAFNetWorkManager responseConfiguration:responseObject];
        
        success(task,dic);
        
        
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                 savePathURL:(NSURL *)fileURL
                                    progress:(HMPProgress )progress
                                     success:(void (^)(NSURLResponse *, NSURL *))success
                                        fail:(void (^)(NSError *))fail{
    AFHTTPSessionManager *manager = [self managerWithBaseURL:nil sessionConfiguration:YES];
    
    NSURL *urlpath = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlpath];
    
    NSURLSessionDownloadTask *downloadtask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [fileURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            fail(error);
        }else{
            
            success(response,filePath);
        }
    }];
    
    [downloadtask resume];
    
    return downloadtask;
}

#pragma mark - Private

+(AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL  sessionConfiguration:(BOOL)isconfiguration{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager =nil;
    
    NSURL *url = [NSURL URLWithString:baseURL];
    
    if (isconfiguration) {
        
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    }else{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return manager;
}

+(id)responseConfiguration:(id)responseObject{
    
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    return dic;
}
@end
