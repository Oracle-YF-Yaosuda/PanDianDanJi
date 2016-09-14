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
#define apath    @"/api/rest/1.0"

#define WaiWang [NSString stringWithFormat:@"%@%@%@%@",Scheme,JuyuwangIP,AppName,apath]

#define JuYuWang [NSString stringWithFormat:@"%@%@%@%@",Scheme,JuyuwangIP,AppName,apath]

#define Appkey   @"d800528f235e4142b78a8c26c4d537d9"

#define TongBuShiTiLei [NSDictionary dictionaryWithObjectsAndKeys:@"text",@"approvalNumber",@"text",@"barCode",@"text",@"costPrice",@"text",@"id",@"text",@"isNewRecord",@"text",@"manufacturer",@"text",@"prodBatchNo",@"text",@"productCode",@"text",@"productName",@"text",@"pycode",@"text",@"salePrice",@"text",@"specification",@"text",@"vipPrice", nil]

#define TongBuBiaoMing @"tongbu"

#define XiaZaiShiTiLei [NSDictionary dictionaryWithObjectsAndKeys:@"text",@"approvalNumber",@"text",@"barCode",@"text",@"checkId",@"text",@"checkNum",@"text",@"costPrice",@"text",@"id",@"text",@"manufacturer",@"text",@"oldpos",@"text",@"prodBatchNo",@"text",@"productCode",@"text",@"productName",@"text",@"purchaseBatchNo",@"text",@"pycode",@"text",@"salePrice",@"text",@"specification",@"text",@"status",@"text",@"stockNum",@"text",@"vipPrice", nil]


#define XiaZaiBiaoMing @"xiazai"

#define ShangChuanShiTiLei [NSDictionary dictionaryWithObjectsAndKeys:@"text",@"productCode",@"text",@"checkNum",@"text",@"prodBatchNo",@"text",@"status",@"text",@"checkTime",@"text",@"productName",@"text",@"manufacturer",@"text",@"specification",@"text",@"barCode",@"text",@"approvalNumber",@"text",@"pycode",@"text",@"checkId", nil]

#define ShangChuanBiaoMing @"shangchuan"