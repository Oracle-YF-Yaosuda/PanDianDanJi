//
//  XL_FMDB.h
//  PanDianDanJi
//
//  Created by newmac on 16/9/12.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface XL_FMDB : NSObject

+(XL_FMDB *)tool;
/**
 *  创建数据库
 *  @param dbName 数据库名称(带后缀.sqlite)
 */

-(FMDatabase *)getDBWithDBName:(NSString *)dbName;
/**
 *  给指定数据库建表
 *  @param db        指定数据库对象
 *  @param tableName 表的名称
 *  @param keyTypes   所含字段以及对应字段类型 字典
 */

-(void)DataBase:(FMDatabase *)db createTable:(NSString *)tableName keyTypes:(NSDictionary *)keyTypes;
/**
 *  给指定数据库的表添加值
 *  @param db        数据库名称
 *  @param keyValues 字段及对应的值
 *  @param tableName 表名
 */

-(void)DataBase:(FMDatabase *)db insertKeyValues:(NSDictionary *)keyValues intoTable:(NSString *)tableName;
/**
 *  给指定数据库的表更新值
 *  @param db        数据库名称
 *  @param keyValues 要更新字段及对应的值
 *  @param tableName 表名
 */

-(void)DataBase:(FMDatabase *)db updateTable:(NSString *)tableName setKeyValues:(NSDictionary *)keyValues;
/**
 *  单个条件更新
 *  @param db        数据库名称
 *  @param tableName 表名称
 *  @param keyValues 要更新的字段及对应值
 *  @param condition 条件
 */

-(void)DataBase:(FMDatabase *)db updateTable:(NSString *)tableName setKeyValues:(NSDictionary *)keyValues whereCondition:(NSDictionary *)condition;
/**
 *  AND两个条件更新
 *  @param db        数据库名称
 *  @param keyValues 查询字段以及对应字段类型 字典
 *  @param tableName 表名称
 *  @param conditions 条件
 */
-(void)DataBase:(FMDatabase *)db updateTable:(NSString *)tableName setKeyValues:(NSDictionary *)keyValues whereConditions:(NSDictionary *)conditions;
/**
 *  查询数据库表中的所有值
 *  @param db        数据库名称
 *  @param keyTypes 查询字段以及对应字段类型 字典
 *  @param tableName 表名称
 *  @return 查询得到数据
 */

-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName;
/**
 *  单个条件"="查询数据库中的数据
 *  @param db        数据库名称
 *  @param keyTypes 查询字段以及对应字段类型 字典
 *  @param tableName 表名称
 *  @param condition 条件
 *  @return 查询得到数据
 */

-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereCondition:(NSDictionary *)condition;
/**
 *  单个条件""查询数据库中的数据
 *  @param db        数据库名称
 *  @param keyTypes 查询字段以及对应字段类型 字典
 *  @param tableName 表名称
 *  @param condition 条件
 *  @return 查询得到数据
 */
-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName where___Condition:(NSDictionary *)condition;
-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName where_Condition:(NSDictionary *)condition;
/**
 *  模糊查询 某字段以指定字符串开头的数据
 *  @param db        数据库名称
 *  @param keyTypes 查询字段以及对应字段类型 字典
 *  @param tableName 表名称
 *  @param key       条件字段
 *  @param str       开头字符串
 *  @return 查询所得数据
 */

-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key beginWithStr:(NSString *)str;
/**
 *  模糊查询 某字段包含指定字符串的数据
 *  @param db        数据库名称
 *  @param keyTypes 查询字段以及对应字段类型 字典
 *  @param tableName 表名称
 *  @param key       条件字段
 *  @param str       所包含的字符串
 *  @return 查询所得数据
 */

-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key containStr:(NSString *)str;
/**
 *  模糊查询 某字段以指定字符串结尾的数据
 *  @param db        数据库名称
 *  @param keyTypes 查询字段以及对应字段类型 字典
 *  @param tableName 表名称
 *  @param key       条件字段
 *  @param str       结尾字符串
 *  @return 查询所得数据
 */

-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key endWithStr:(NSString *)str;
/**
 *  清理指定数据库中的数据  （只删除数据不删除数据库）
 *  @param db 指定数据库
 */

-(void)clearDatabase:(FMDatabase *)db from:(NSString *)tableName;

/*
 *  删除数据某数据
 *  @param db        数据库名称
 *  @param keysTypes 查询字段以及对应字段类型 字典
 *  @param tableName 表名称
 *  @param condition 条件
 *  @return 查询得到数据 限制数据条数10
 */

-(NSArray *)DataBase:(FMDatabase *)db deleteKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereCondition:(NSDictionary *)condition;


/**
 *  OR三个条件查询数据库中的数据 限制数据条数10
 *  @param db        数据库名称
 *  @param keyTypes 查询字段以及对应字段类型 字典
 *  @param tableName 表名称
 *  @param conditions 条件
 *  @return 查询得到数据 限制数据条数10
 */

-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereConditionz:(NSDictionary *)conditions;

/**
 *  AND两个条件查询数据库中的数据
 *  @param db        数据库名称
 *  @param keyTypes 查询字段以及对应字段类型 字典
 *  @param tableName 表名称
 *  @param conditions 条件
 *  @return 查询得到数据 限制数据条数10
 */

-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereConditions:(NSDictionary *)conditions;
/**
 *  OR两个条件查询数据库中的数据
 *  @param db        数据库名称
 *  @param keyTypes 查询字段以及对应字段类型 字典
 *  @param tableName 表名称
 *  @param conditionss 条件
 *  @return 查询得到数据
 */


-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereConditionzss:(NSDictionary *)conditionss;

@end
