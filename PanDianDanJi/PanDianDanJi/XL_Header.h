//
//  XL_Header.h
//  PanDianDanJi
//
//  Created by 小狼 on 16/9/7.
//  Copyright © 2016年 BinXiaolang. All rights reserved.


#define Host    @"125.211.221.232"
#define Port    @":9000"
#define JuyuwangIP [[NSUserDefaults standardUserDefaults] objectForKey:@"JuYuWang"]

#define Scheme  @"http://"
#define AppName @"/stockmgr"
#define path    @"/api/rest/1.0"

#define WaiWang [NSString stringWithFormat:@"%@%@%@%@%@",Scheme,Host,Port,AppName,path]

#define JuYuWang [NSString stringWithFormat:@"%@%@%@%@",Scheme,JuyuwangIP,AppName,path]

#define Appkey   @"d800528f235e4142b78a8c26c4d537d9"