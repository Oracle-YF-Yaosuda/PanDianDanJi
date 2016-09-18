//
//  XLHomeViewController.m
//  PanDianDanJi
//
//  Created by 小狼 on 16/9/8.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import "XLHomeViewController.h"
#import "WarningBox.h"
#import "XLSettingViewController.h"
#import "XL_Header.h"
#import "XL_WangLuo.h"
#import "XL_FMDB.h"
#import "XL_PanDianViewController.h"

@interface XLHomeViewController (){
    XL_FMDB  *XL;//数据库调用者
    FMDatabase *db;//数据库
}


@end

@implementation XLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self NavigationDeShezhi];
    [self shujuku];
    
    

    
    
    //     [XL DataBase:db insertKeyValues:[NSDictionary dictionaryWithObjectsAndKeys:@"london",@"name",@"791432148895",@"birthday",@"156842",@"price", nil] intoTable:@"Pandian1"];
    //    [XL DataBase:db insertKeyValues:[NSDictionary dictionaryWithObjectsAndKeys:@"张三",@"name",@"2222",@"birthday",@"111",@"price", nil] intoTable:@"Pandian1"];
    //    [XL DataBase:db insertKeyValues:[NSDictionary dictionaryWithObjectsAndKeys:@"london",@"name",@"791432148895",@"birthday",@"156842",@"price", nil] intoTable:@"Pandian1"];
    //    [XL DataBase:db insertKeyValues:[NSDictionary dictionaryWithObjectsAndKeys:@"李四",@"name",@"2222",@"birthday",@"111",@"price", nil] intoTable:@"Pandian1"];
    //    [XL DataBase:db insertKeyValues:[NSDictionary dictionaryWithObjectsAndKeys:@"lisi",@"name",@"791432148895",@"birthday",@"156842",@"price", nil] intoTable:@"Pandian1"];
    
    
    
    //更新字段下所有值@"张三",@"name"（将name下所有值变成张三）
    //[XL DataBase:db updateTable:@"Pandian" setKeyValues:[NSDictionary dictionaryWithObjectsAndKeys:@"张三",@"name", nil]];
    
    //更新表中数据（修改的信息中不能有查找的条件）
    //[XL DataBase:db updateTable:@"Pandian" setKeyValues:[NSDictionary dictionaryWithObjectsAndKeys:@"122",@"price",@"42323",@"birthday", nil] whereCondition:[NSDictionary dictionaryWithObjectsAndKeys:@"李四",@"name", nil]];
    
    //查找表中所有数据
    //NSArray *arr =[XL DataBase:db selectKeyTypes:[NSDictionary dictionaryWithObjectsAndKeys:@"text",@"name",@"text",@"birthday",@"text",@"price", nil] fromTable:@"Pandian"];
    
    //条件查询数据库中的数据
    //NSArray *arr =  [XL DataBase:db selectKeyTypes:[NSDictionary dictionaryWithObjectsAndKeys:@"text",@"name",@"text",@"birthday",@"text",@"price", nil]  fromTable:@"Pandian" whereCondition:[NSDictionary dictionaryWithObjectsAndKeys:@"张三",@"name", nil]];
    
    //模糊查询 某字段以指定字符串开头的数据
    //    NSArray*arr = [XL DataBase:db selectKeyTypes:[NSDictionary dictionaryWithObjectsAndKeys:@"text",@"name",@"text",@"birthday",@"text",@"price", nil] fromTable:@"Pandian" whereKey:@"name" beginWithStr:@"李"];
    //    NSLog(@"result %@",arr);
    
    //模糊查询 某字段以指定字符串结尾的数据
    //    NSArray *arr2 = [XL DataBase:db selectKeyTypes:[NSDictionary dictionaryWithObjectsAndKeys:@"text",@"name",@"text",@"birthday",@"text",@"price", nil] fromTable:@"Pandian" whereKey:@"name" endWithStr:@"i"];
    //    NSLog(@"结尾%@",arr2);
    
    //模糊查询 某字段包含指定字符串的数据
    //    NSArray *arr1 = [XL  DataBase:db selectKeyTypes:[NSDictionary dictionaryWithObjectsAndKeys:@"text",@"name",@"text",@"birthday",@"text",@"price", nil] fromTable:@"Pandian" whereKey:@"name" containStr:@"so"];
    //    NSLog(@"包含%@",arr1);
    
    // 删除表中某条数据
    // [XL DataBase:db deleteKeyTypes:[NSDictionary dictionaryWithObjectsAndKeys:@"text",@"name",@"text",@"birthday",@"text",@"price", nil] fromTable:@"Pandian" whereCondition:[NSDictionary dictionaryWithObjectsAndKeys:@"gjojsodjgkjgirjhi",@"name", nil]];
    
    //[XL DataBase:db deleteKeyTypes:[NSDictionary dictionaryWithObjectsAndKeys:@"text",@"name",@"text",@"birthday",@"text",@"price", nil] fromTable:@"Pandian1" whereCondition:[NSDictionary dictionaryWithObjectsAndKeys:@"4",@"id", nil]];
    
    
}
-(void)shujuku{
    XL = [XL_FMDB tool];
    [XL_FMDB allocWithZone:NULL];
    db = [XL getDBWithDBName:@"pandian.sqlite"];
    //新建同步表，里边是同步数据信息
    [XL DataBase:db createTable:TongBuBiaoMing keyTypes:TongBuShiTiLei];
    //新建下载表，里边是本次盘点数据
    [XL DataBase:db createTable:XiaZaiBiaoMing keyTypes:XiaZaiShiTiLei];
    
    
}
-(void)NavigationDeShezhi{
    [self.navigationController setNavigationBarHidden:NO];
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc] initWithTitle:@"盘点助手" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem setLeftBarButtonItem:left];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cehua_12.png"] style:UIBarButtonItemStyleDone target:self action:@selector(set:)];
    
    [self.navigationItem setRightBarButtonItem:right];
}

//同步全部库存
- (IBAction)KuCun_Button:(id)sender {
    
    [self tongbushuju];
    [self xiazaishuju:@"全部库存" :@"0"];
}

//下载数据
- (IBAction)ShuJu_Button:(id)sender {
    [self xiazaishuju:@"异常数据" :@"1"];
}
//提交盘点结果
- (IBAction)TiJian_Button:(id)sender {
    NSString *fangshi=@"/sys/upload";
    
    NSNumber *aa=[NSNumber numberWithInt:20];
    
    NSDictionary *list_ci =[NSDictionary dictionaryWithObjectsAndKeys:@"1010",@"checkId",@"100100",@"productCode",@"201605",@"prodBatchNo",aa,@"checkNum",@"0",@"status",@"2016-09-13 08:00:34",@"checkTime",@"药品名称01",@"productName",@"哈药六厂",@"manufacturer",@"100片/盒",@"specification",@"200010101",@"barCode",@"国药准字001",@"approvalNumber",@"ypmc01",@"pycode", nil];
    
    
    NSArray *list=[NSArray arrayWithObjects:list_ci , nil];
    
    NSDictionary*rucan=[NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"Mac"],@"mac",[[NSUserDefaults standardUserDefaults] objectForKey:@"UserID"],@"checker",@"0",@"state",list,@"list",nil];
    NSLog(@"%@",rucan);
    //自己写的网络请求    请求外网地址
    [XL_WangLuo JuYuwangQingqiuwithBizMethod:fangshi Rucan:rucan type:Post success:^(id responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
        @try {
            NSLog(@"\n\n\n%@\n\n\n",responseObject);
            if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
                
            }
        } @catch (NSException *exception) {
            [WarningBox warningBoxModeText:@"请仔细检查您的网络" andView:self.view];
        }
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络请求失败" andView:self.view];
        NSLog(@"%@",error);
    }];
    
    NSLog(@"1");
}
//盘点药品
- (IBAction)PanDian_Button:(id)sender {

}

//跳转设置
-(void)set:(UIButton*)sender{
    XLSettingViewController *shezhi=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"set"];
    [self.navigationController pushViewController:shezhi animated:YES];
}
-(void)tongbushuju{
    NSString *fangshi=@"/sys/products";
    
    
    //自己写的网络请求    请求外网地址
    [XL_WangLuo JuYuwangQingqiuwithBizMethod:fangshi Rucan:nil type:Post success:^(id responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
        @try {
            if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
                [WarningBox warningBoxModeText:@"同步全部库存成功!" andView:self.view];
                NSArray *list=[[responseObject objectForKey:@"data"] objectForKey:@"list"];
                NSLog(@"%@",list);
                
                //清空数据
                [XL clearDatabase:db from:TongBuBiaoMing];
                
                for (int i=0; i<list.count; i++) {
                    //向同步表中插入数据
                    [XL DataBase:db insertKeyValues:list[i] intoTable:TongBuBiaoMing];
                }
                
                
                
                
            }
        } @catch (NSException *exception) {
            [WarningBox warningBoxModeText:@"请仔细检查您的网络" andView:self.view];
        }
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络请求失败" andView:self.view];
        NSLog(@"%@",error);
    }];
    
    
}
-(void)xiazaishuju:(NSString *)str :(NSString *)ss{
    [WarningBox warningBoxModeIndeterminate:[NSString stringWithFormat:@"正在同步%@",str] andView:self.view];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",ss] forKey:@"state"];
    NSString *fangshi=@"/sys/download";
    
    NSDictionary*rucan=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"checkId",@"",@"status", nil];
    //自己写的网络请求    请求外网地址
    [XL_WangLuo JuYuwangQingqiuwithBizMethod:fangshi Rucan:rucan type:Post success:^(id responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
        @try {
            NSLog(@"\n\nxiazai____\n\n%@",responseObject);
            if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
                [WarningBox warningBoxModeText:@"同步异常数据成功!" andView:self.view];
                NSArray *list=[[responseObject objectForKey:@"data"] objectForKey:@"list"];
                
                [XL clearDatabase:db from:XiaZaiBiaoMing];
                for (int i=0; i<list.count; i++) {
                    //向下载表中插入数据
                    [XL DataBase:db insertKeyValues:list[i] intoTable:XiaZaiBiaoMing];
                }
            }
        } @catch (NSException *exception) {
            [WarningBox warningBoxModeText:@"请仔细检查您的网络" andView:self.view];
        }
    } failure:^(NSError *error) {
        //        [WarningBox warningBoxHide:YES andView:self.view];
        //        [WarningBox warningBoxModeText:@"网络请求失败" andView:self.view];
        NSLog(@"%@",error);
    }];
    
}
@end
