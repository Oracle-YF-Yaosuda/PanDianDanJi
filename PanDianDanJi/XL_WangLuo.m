//
//  XL_WangLuo.m
//  PanDianDanJi
//
//  Created by 小狼 on 16/9/7.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import "XL_WangLuo.h"
#import "XL_Header.h"
#import "SBJsonWriter.h"
#import "AFNetworking.h"
#import "XLLogin_ViewController.h"
@implementation XL_WangLuo
/*
 * 登陆专用
 * 这个接口是单机版的登录；
 */
+(void)WaiwangQingqiuwithBizMethod:(NSString*)BizMetho Rucan:(NSDictionary*)BizParamSt type:(Post_or_Get)type success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure{
    NSString *Waiwang;
    
        Waiwang=WaiWang;
    
    
    NSString *BizMethod=BizMetho;
    
    NSString *Url=[NSString stringWithFormat:@"%@%@",Waiwang,BizMethod];
    
    NSString *UserID=@"";
    NSString *vaildToken=@"1";//传空或非空
    NSString *accessToken=@"";//登陆不用传
    SBJsonWriter *writer=[[SBJsonWriter alloc] init];
    NSDictionary*BizParamStr=BizParamSt;
    NSString *Rucan=[writer stringWithObject:BizParamStr];
    NSDictionary *ChuanCan=[NSDictionary dictionaryWithObjectsAndKeys:Appkey,@"appkey",UserID,@"userid",vaildToken,@"vaildToken",accessToken,@"accessToken",Rucan,@"params", nil];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    switch (type) {
        case Get:{
            [manager GET:Url parameters:ChuanCan progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            
        }
            
            break;
        case Post:{
            [manager POST:Url parameters:ChuanCan progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            
        }
            
            break;
    }
    
}
/*
 *单机版的接口
 *除了登录
 */
+(void)JuYuwangQingqiuwithBizMethod:(NSString*)BizMetho Rucan:(NSDictionary*)BizParamSt type:(Post_or_Get)type success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure{
    NSUserDefaults * shuju=[NSUserDefaults standardUserDefaults];//非登录接口用
    NSString *JuYuwang;//登录接口不用
    
        JuYuwang=JuYuWang;
    
    NSString *BizMethod=BizMetho;
    
    NSString *Url=[NSString stringWithFormat:@"%@%@",JuYuwang,BizMethod];
    NSString *UserID=[shuju objectForKey:@"UserID"];//登陆不用传
    NSString *vaildToken=@"";//传空或非空
    NSString *accessToken=[shuju objectForKey:@"accessToken"];//登陆不用传
    SBJsonWriter *writer=[[SBJsonWriter alloc] init];
    
    NSDictionary*BizParamStr=BizParamSt;
    
    NSString *Rucan=[writer stringWithObject:BizParamStr];
    NSDictionary *ChuanCan=[NSDictionary dictionaryWithObjectsAndKeys:Appkey,@"appkey",vaildToken,@"vaildToken",UserID,@"userid",accessToken,@"accessToken",Rucan,@"params", nil];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    
    switch (type) {
        case Get:{
            [manager GET:Url parameters:ChuanCan progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
                
            }];
            
        }
            
            break;
        case Post:{
            [manager POST:Url parameters:ChuanCan progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
                
            }];
            
        }
            
            break;
    }
}
//上传文件   外网提交接口,
+(void)ShangChuanWenJianwithBizMethod:(NSString*)BizMetho Wenjian:(NSString*)Ming key:(NSString*)key Rucan:(NSDictionary*)BizParamSt type:(Post_or_Get)type success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure{
    NSUserDefaults * shuju=[NSUserDefaults standardUserDefaults];//非登录接口用
    NSString *JuYuwang;//登录接口不用
    
        JuYuwang=JuYuWang;
    
//    NSFileManager *fmm;
//    fmm=[NSFileManager defaultManager];
//    NSString*wenjianPath=[NSString stringWithFormat:@"%@/wenjian.txt",NSTemporaryDirectory()];
//    NSData*fileData;
//    fileData=[fmm contentsAtPath:wenjianPath];
//    if (fileData) {
//        [fmm removeItemAtPath:wenjianPath error:nil];
//    }
    NSString *BizMethod=BizMetho;
    
    NSString *Url=[NSString stringWithFormat:@"%@%@",JuYuwang,BizMethod];
    NSString *UserID=[shuju objectForKey:@"UserID"];//登陆不用传
    NSString *vaildToken=@"";//传空或非空
    NSString *accessToken=[shuju objectForKey:@"accessToken"];//登陆不用传
    SBJsonWriter *writer=[[SBJsonWriter alloc] init];
    
    NSDictionary*BizParamStr=BizParamSt;
    
    NSString *Rucan=[writer stringWithObject:BizParamStr];
    
//    BOOL res = [Rucan writeToFile:wenjianPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    if (res) {
//        NSLog(@"成功");
//    }
    
    NSDictionary *ChuanCan=[NSDictionary dictionaryWithObjectsAndKeys:Appkey,@"appkey",vaildToken,@"vaildToken",UserID,@"userid",accessToken,@"accessToken",Rucan,@"params", nil];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    [manager POST:Url parameters:ChuanCan constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

+(void)youyigesigejiu:(UIViewController*)vv :(int)i{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"您的账号已在其他手机登录，请重新登录..." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
       
            //具体实现逻辑代码
            XLLogin_ViewController*view=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];
            [view setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [vv presentViewController:view animated:YES completion:nil];
        
    }];
    [alert addAction:cancel];
    //显示提示框
    [vv presentViewController:alert animated:YES completion:nil];
}
@end
