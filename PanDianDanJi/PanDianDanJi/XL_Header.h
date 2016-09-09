//
//  XL_Header.h
//  PanDianDanJi
//
//  Created by 小狼 on 16/9/7.
//  Copyright © 2016年 BinXiaolang. All rights reserved.


#define Host    @"192.163.1.1"
#define Port    @":8080"
#define JuyuwangIP [[NSUserDefaults standardUserDefaults] objectForKey:@"JuYuWang"]

#define Scheme  @"http://"
#define AppName @"/pandianshushou"
#define path    @"/api/rest/1.0"

#define WaiWang [NSString stringWithFormat:@"%@%@%@%@%@",Scheme,Host,Port,AppName,path]

#define JuYuWang [NSString stringWithFormat:@"%@%@%@%@",Scheme,JuyuwangIP,AppName,path]

#define Appkey   @""