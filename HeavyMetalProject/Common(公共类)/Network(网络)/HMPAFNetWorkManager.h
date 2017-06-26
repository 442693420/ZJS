//
//  HMPAFNetWorkManager.h
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
/**
 *  宏定义请求成功的block
 *
 *  @param responseObject 请求成功返回的数据
 */
typedef void (^HMPResponseSuccess)(NSURLSessionDataTask * task,id responseObject);

/**
 *  宏定义请求失败的block
 *
 *  @param error 报错信息
 */
typedef void (^HMPResponseFail)(NSURLSessionDataTask * task, NSError * error);

/**
 *  上传或者下载的进度
 *
 *  @param progress 进度
 */
typedef void (^HMPProgress)(NSProgress *progress);

@interface HMPAFNetWorkManager : NSObject
/**
 *  普通get方法请求网络数据
 *
 *  @param requestUrl     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+(void)GET:(NSString *)requestUrl
    params:(NSDictionary *)params success:(HMPResponseSuccess)success
      fail:(HMPResponseFail)fail;
/**
 *  含有baseURL的get方法
 *
 *  @param requestUrl     请求网址路径
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+(void)GET:(NSString *)requestUrl baseURL:(NSString *)baseUrl
    params:(NSDictionary *)params success:(HMPResponseSuccess)success fail:(HMPResponseFail)fail;

/**
 *  普通post方法请求网络数据
 *
 *  @param requestUrl     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+(void)POST:(NSString *)requestUrl
     params:(NSDictionary *)params
    success:(HMPResponseSuccess)success
       fail:(HMPResponseFail)fail;

/**
 *  含有baseURL的post方法
 *
 *  @param requestUrl     请求网址路径
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+(void)POST:(NSString *)requestUrl
    baseURL:(NSString *)baseUrl
     params:(NSDictionary *)params
    success:(HMPResponseSuccess)success
       fail:(HMPResponseFail)fail;

/**
 *  普通路径上传文件
 *
 *  @param requestUrl      请求网址路径
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param fail     失败回调
 */
+(void)uploadWithURL:(NSString *)requestUrl
              params:(NSDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(HMPProgress)progress
             success:(HMPResponseSuccess)success
                fail:(HMPResponseFail)fail;
/**
 *  含有跟路径的上传文件
 *
 *  @param requestUrl      请求网址路径
 *  @param baseurl  请求网址根路径
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param fail     失败回调
 */
+(void)uploadWithURL:(NSString *)requestUrl
             baseURL:(NSString *)baseurl
              params:(NSDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(HMPProgress)progress
             success:(HMPResponseSuccess)success
                fail:(HMPResponseFail)fail;


+(void)POST:(NSString *)requestUrl body:(NSDictionary *)params success:(HMPResponseSuccess)success fail:(HMPResponseFail)fail;

/**
 *  下载文件
 *
 *  @param requestUrl      请求网络路径
 *  @param fileURL  保存文件url
 *  @param progress 下载进度
 *  @param success  成功回调
 *  @param fail     失败回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，重新开启下载调用resume方法
 */
+(NSURLSessionDownloadTask *)downloadWithURL:(NSString *)requestUrl
                                 savePathURL:(NSURL *)fileURL
                                    progress:(HMPProgress )progress
                                     success:(void (^)(NSURLResponse *, NSURL *))success
                                        fail:(void (^)(NSError *))fail;

+(id)responseConfiguration:(id)responseObject;
@end
