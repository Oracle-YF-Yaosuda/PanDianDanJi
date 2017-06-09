//
//  XLquanbuselflei.m
//  com.BeiGe.PanYouApp
//
//  Created by 小狼 on 2017/4/6.
//  Copyright © 2017年 BinXiaolang. All rights reserved.
//

#import "XLquanbushitilei.h"

@implementation XLquanbushitilei
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        self.approvalNumber=[dict objectForKey:@"approvalNumber"];
        self.barCode       =[dict objectForKey:@"barCode"];
        self.costPrice     =[dict objectForKey:@"costPrice"];
        self.id            =[dict objectForKey:@"id"];
        self.isNewRecord   =[dict objectForKey:@"isNewRecord"];
        self.manufacturer  =[dict objectForKey:@"manufacturer"];
        self.prodBatchNo   =[dict objectForKey:@"prodBatchNo"];
        self.productCode   =[dict objectForKey:@"productCode"];
        self.productName   =[dict objectForKey:@"productName"];
        self.pycode        =[dict objectForKey:@"pycode"];
        self.salePrice     =[dict objectForKey:@"salePrice"];
        self.specification =[dict objectForKey:@"specification"];
        self.vipPrice      =[dict objectForKey:@"vipPrice"];
    }
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict{
    
    // 为何使用self，谁调用self方法 self就会指向谁！！
    return [[self alloc] initWithDict:dict];
}
-(NSDictionary*)ModelToDic:(XLquanbushitilei *)dd{
    NSDictionary*mm=[NSDictionary dictionary];
    NSArray*keys=[NSArray arrayWithObjects:@"approvalNumber",@"barCode",@"costPrice",@"id",@"isNewRecord",@"manufacturer",@"prodBatchNo",@"productCode",@"productName",@"pycode",@"salePrice",@"specification",@"vipPrice", nil];
    if(nil==dd.approvalNumber){
      dd.approvalNumber =@"";
    }
    if(nil==dd.barCode){
        dd.barCode =@"";
    }
    if(nil==dd.costPrice){
        dd.costPrice =@"";
    }
    if(nil==dd.id){
        dd.id =@"";
    }
    if(nil==dd.isNewRecord){
        dd.isNewRecord =@"";
    }
    if(nil==dd.manufacturer){
        dd.manufacturer =@"";
    }
    if(nil==dd.prodBatchNo){
        dd.prodBatchNo =@"";
    }
    if(nil==dd.productCode){
        dd.productCode =@"";
    }
    if(nil==dd.productName){
        dd.productName =@"";
    }
    if(nil==dd.pycode){
        dd.pycode =@"";
    }
    if(nil==dd.salePrice){
        dd.salePrice =@"";
    }
    if(nil==dd.specification){
        dd.specification =@"";
    }
    if(nil==dd.vipPrice){
        dd.vipPrice =@"";
    }
  
    
    NSArray*objects=[NSArray arrayWithObjects:dd.approvalNumber,dd.barCode,dd.costPrice,dd.id,dd.isNewRecord,dd.manufacturer,dd.prodBatchNo,dd.productCode,dd.productName,dd.pycode,dd.salePrice,dd.specification,dd.vipPrice, nil];
    mm=[NSDictionary dictionaryWithObjects:objects forKeys:keys];
    return mm;
}
+(NSDictionary*)ModeltoDic:(XLquanbushitilei *)dd{
    return [[self alloc] ModelToDic:dd];
}
@end
