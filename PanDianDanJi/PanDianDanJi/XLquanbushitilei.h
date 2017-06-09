//
//  XLquanbushitilei.h
//  com.BeiGe.PanYouApp
//
//  Created by 小狼 on 2017/4/6.
//  Copyright © 2017年 BinXiaolang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLquanbushitilei : NSObject

@property (nonatomic , strong) NSString*approvalNumber;
@property (nonatomic , strong) NSString*barCode;
@property (nonatomic , strong) NSString*costPrice;
@property (nonatomic , strong) NSString*id;
@property (nonatomic , strong) NSString*isNewRecord;
@property (nonatomic , strong) NSString*manufacturer;
@property (nonatomic , strong) NSString*prodBatchNo;
@property (nonatomic , strong) NSString*productCode;
@property (nonatomic , strong) NSString*productName;
@property (nonatomic , strong) NSString*pycode;
@property (nonatomic , strong) NSString*salePrice;
@property (nonatomic , strong) NSString*specification;
@property (nonatomic , strong) NSString*vipPrice;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)initWithDict:(NSDictionary *)dict;
-(NSDictionary*)ModelToDic:(XLquanbushitilei *)dd;
+(NSDictionary*)ModeltoDic:(XLquanbushitilei *)dd;
@end
