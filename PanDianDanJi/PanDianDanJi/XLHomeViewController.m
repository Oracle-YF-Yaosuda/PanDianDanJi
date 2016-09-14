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
@interface XLHomeViewController ()

@end

@implementation XLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc] initWithTitle:@"盘点助手" style:UIBarButtonItemStyleDone target:nil action:nil];
    //[left setEnabled:NO];
    [self.navigationItem setLeftBarButtonItem:left];
 
    
//    UIButton  *right = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 30, 30)];
//    [right setImage:[UIImage imageNamed:@"cehua_12.png"] forState:UIControlStateNormal];
//   // right.adjustsImageWhenHighlighted = NO;
//    [right addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightben = [[UIBarButtonItem alloc]initWithCustomView:right];
//    self.navigationItem.rightBarButtonItem =rightben;
  
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cehua_12.png"] style:UIBarButtonItemStyleDone target:self action:@selector(set:)];
    
    [self.navigationItem setRightBarButtonItem:right];

    
    XL_FMDB  *XL = [XL_FMDB tool];
    [XL_FMDB allocWithZone:NULL];
    FMDatabase *db = [XL getDBWithDBName:@"pandian.sqlite"];
    
    
    
    //新建表
    //[XL DataBase:db createTable:@"Pandian1" keyTypes:[NSDictionary dictionaryWithObjectsAndKeys:@"integer primary key autoincrement",@"id ",@"text",@"name",@"text",@"birthday",@"text",@"price", nil]];
   // [XL DataBase:db createTable:@"Pandian" keyTypes:[NSDictionary dictionaryWithObjectsAndKeys:@"text",@"name",@"text",@"birthday",@"text",@"price", nil]];
    //向表中插入数据
//     [XL DataBase:db insertKeyValues:[NSDictionary dictionaryWithObjectsAndKeys:@"张三",@"name",@"2222",@"birthday",@"111",@"price", nil] intoTable:@"Pandian1"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//同步全部库存
- (IBAction)KuCun_Button:(id)sender {
    NSLog(@"2");
    [self tongbushuju];
    
}

//下载数据
- (IBAction)ShuJu_Button:(id)sender {
     NSLog(@"3");
    NSString *fangshi=@"/sys/download";
    
    NSDictionary*rucan=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"checkId",@"",@"status", nil];
    //自己写的网络请求    请求外网地址
    [XL_WangLuo JuYuwangQingqiuwithBizMethod:fangshi Rucan:rucan type:Post success:^(id responseObject) {
        //[WarningBox warningBoxHide:YES andView:self.view];
        @try {
            NSLog(@"%@",responseObject);
            if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
                
            }
        } @catch (NSException *exception) {
            //[WarningBox warningBoxModeText:@"请仔细检查您的网络" andView:self.view];
        }
    } failure:^(NSError *error) {
        //        [WarningBox warningBoxHide:YES andView:self.view];
        //        [WarningBox warningBoxModeText:@"网络请求失败" andView:self.view];
        NSLog(@"%@",error);
    }];
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
        //[WarningBox warningBoxHide:YES andView:self.view];
        @try {
            NSLog(@"\n\n\n%@\n\n\n",responseObject);
            if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
                
            }
        } @catch (NSException *exception) {
            //  [WarningBox warningBoxModeText:@"请仔细检查您的网络" andView:self.view];
        }
    } failure:^(NSError *error) {
        //[WarningBox warningBoxHide:YES andView:self.view];
        //[WarningBox warningBoxModeText:@"网络请求失败" andView:self.view];
        NSLog(@"%@",error);
    }];

     NSLog(@"1");
}
//盘点药品
- (IBAction)PanDian_Button:(id)sender {
     NSLog(@"4");
}

//跳转设置
-(void)set:(UIButton*)sender{
     XLSettingViewController *shezhi=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"set"];
    [self.navigationController pushViewController:shezhi animated:YES];
}
-(void)tongbushuju{
    NSString *fangshi=@"/sys/products";
    
    NSDictionary*rucan=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"loginName", nil];
    //自己写的网络请求    请求外网地址
    [XL_WangLuo JuYuwangQingqiuwithBizMethod:fangshi Rucan:rucan type:Post success:^(id responseObject) {
        //[WarningBox warningBoxHide:YES andView:self.view];
        @try {
            NSLog(@"%@",responseObject);
            if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
                
            }
        } @catch (NSException *exception) {
            //[WarningBox warningBoxModeText:@"请仔细检查您的网络" andView:self.view];
        }
    } failure:^(NSError *error) {
        //        [WarningBox warningBoxHide:YES andView:self.view];
        //        [WarningBox warningBoxModeText:@"网络请求失败" andView:self.view];
        NSLog(@"%@",error);
    }];
    

}

@end
