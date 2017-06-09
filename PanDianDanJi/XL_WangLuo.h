//
//  XL_WangLuo.h
//  PanDianDanJi
//
//  Created by 小狼 on 16/9/7.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,Post_or_Get) {
    /**
     *  get请求
     */
    Get = 0,
    /**
     *  post请求
     */
    Post
};

@interface XL_WangLuo : NSObject
/*
 * 单机版的登录
 */
+(void)WaiwangQingqiuwithBizMethod:(NSString*)BizMetho Rucan:(NSDictionary*)BizParamSt type:(Post_or_Get)type success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;
/*
 * 单机版除了登录接口
 */
+(void)JuYuwangQingqiuwithBizMethod:(NSString*)BizMetho Rucan:(NSDictionary*)BizParamSt type:(Post_or_Get)type success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

/*
 * 上传文件
 */
+(void)ShangChuanWenJianwithBizMethod:(NSString*)BizMetho Wenjian:(NSString*)Ming key:(NSString*)key Rucan:(NSDictionary*)BizParamSt type:(Post_or_Get)type success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure;

+(void)youyigesigejiu:(UIViewController*)vv :(int)i;
@end
