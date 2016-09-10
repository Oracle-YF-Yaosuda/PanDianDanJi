//
//  XL_WangLuo.h
//  PanDianDanJi
//
//  Created by 小狼 on 16/9/7.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import <Foundation/Foundation.h>

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

+(void)WaiwangQingqiuwithBizMethod:(NSString*)BizMetho Rucan:(NSDictionary*)BizParamSt type:(Post_or_Get)type success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;
+(void)JuYuwangQingqiuwithBizMethod:(NSString*)BizMetho Rucan:(NSDictionary*)BizParamSt type:(Post_or_Get)type success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;
@end
