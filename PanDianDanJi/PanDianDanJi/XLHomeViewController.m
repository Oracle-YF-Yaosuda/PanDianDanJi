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
    [self NavigationDeShezhi];
    [self shujuku];
}
-(void)shujuku{
    XL = [XL_FMDB tool];
    [XL_FMDB allocWithZone:NULL];
    db = [XL getDBWithDBName:@"pandian.sqlite"];
    //新建同步表，里边是同步数据信息
    [XL DataBase:db createTable:TongBuBiaoMing keyTypes:TongBuShiTiLei];
    //新建下载表，里边是本次盘点数据
    [XL DataBase:db createTable:XiaZaiBiaoMing keyTypes:XiaZaiShiTiLei];
    //新建上传表，里边是需要上传的盘点数据
    [XL DataBase:db createTable:ShangChuanBiaoMing keyTypes:ShangChuanShiTiLei];
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
    
    NSArray  *arr= [XL DataBase:db selectKeyTypes:ShangChuanShiTiLei fromTable:ShangChuanBiaoMing];
    if (arr.count!=0){
        UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"同步提示" message:@"同步全部库存将会清空本次盘点未提交的数据，确定要同步全部库存吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"zhuangtai"];
            [self tongbushuju];
            [self xiazaishuju:@"全部库存" :@"9"];
            
        }];
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:^{
        }];
        
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"zhuangtai"];
        [self tongbushuju];
        [self xiazaishuju:@"全部库存" :@"9"];
    }
    
    
}

//同步异常数据
- (IBAction)ShuJu_Button:(id)sender {
    
    NSArray *arr = [XL DataBase:db selectKeyTypes:ShangChuanShiTiLei fromTable:ShangChuanBiaoMing];
    if (arr.count!=0){
        UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"同步提示" message:@"同步异常数据将会清空本次盘点未提交的数据，确定要同步异常数据吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"zhuangtai"];
            [self xiazaishuju:@"异常数据" :@"8"];
        }];
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"zhuangtai"];
        [self xiazaishuju:@"异常数据" :@"8"];
    }
    
    
    
    
    
}
//提交盘点结果
- (IBAction)TiJian_Button:(id)sender {
    
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要提交盘点结果吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shangchuanshujujiexi];
    }];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:^{
    }];
}
-(void)shangchuanshujujiexi{
    NSArray *list1 = [XL DataBase:db selectKeyTypes:ShangChuanShiTiLei fromTable:ShangChuanBiaoMing];
NSLog(@"上传表里的数据%@",list1);
    NSMutableArray*list = [[NSMutableArray alloc] init];
    for (NSDictionary*dd in list1) {
        if (![[dd objectForKey:@"checkNum"] isEqualToString:@"0"]) {
            NSString * tiaoma=[dd objectForKey:@"barCode"];
            NSArray * fenge =[tiaoma componentsSeparatedByString:@","];
            NSString* xintiaoma;
            if ( NULL== fenge) {
                xintiaoma = tiaoma;
            }else{
                xintiaoma=(NSString*)fenge[0];
                for (int i=1; i<fenge.count-1; i++) {
                    xintiaoma=[xintiaoma stringByAppendingFormat:@",%@", fenge[i]];
                }
            }
            //新条码 插入到dd里
            [dd setValue:xintiaoma forKey:@"barCode"];
            [list addObject:dd];
        }
    }
    if (list.count==0) {
        [WarningBox warningBoxModeText:@"请先盘点数据!" andView:self.view];
    }else{
        [WarningBox warningBoxModeIndeterminate:@"正在提交盘点结果...." andView:self.view];
        NSDictionary*rucan=[NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"Mac"],@"mac",[[NSUserDefaults standardUserDefaults] objectForKey:@"UserID"],@"checker",[[NSUserDefaults standardUserDefaults]objectForKey:@"zhuangtai"],@"state",list,@"list",nil];
        NSLog(@"上传的数据-------\n\n%lu",(unsigned long)list.count);
        NSLog(@"上传的数据-------\n\n%@",rucan);
        [self shangchuan:rucan];
    }
    
}
//盘点药品
- (IBAction)PanDian_Button:(id)sender {
    /*需要加判断*/
    XL_PanDianViewController *pandian=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pandian"];
    [self.navigationController pushViewController:pandian animated:YES];
    
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
        
        @try {
            if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
                NSArray *list=[[responseObject objectForKey:@"data"] objectForKey:@"list"];
                NSLog(@"同步数据-*-*-*-\n\n\n%lu",(unsigned long)list.count);
                NSLog(@"同步数据-*-*-*-\n\n\n%@",list);
                //清空数据
                [XL clearDatabase:db from:TongBuBiaoMing];
                for (int i=0; i<list.count; i++) {
                    
                    NSString *barcode =[list[i]objectForKey:@"barCode"];
                    if (NULL==barcode){
                        barcode = @"";
                    }
                    NSString  *code = [NSString stringWithFormat:@"%@,%@",barcode,[list[i]objectForKey:@"productCode"]];
                    NSMutableDictionary * dd=[NSMutableDictionary dictionaryWithDictionary:list[i]];
                    [dd setObject:[NSString stringWithFormat:@"%@", code ] forKey:@"barCode"];
                    [XL DataBase:db insertKeyValues:dd intoTable:TongBuBiaoMing];
                    
                }
            }else
                [WarningBox warningBoxModeText:@"同步库存失败，请与管理员联系！" andView:self.view];
        } @catch (NSException *exception) {
            [WarningBox warningBoxModeText:@"请仔细检查您的网络" andView:self.view];
        }
    } failure:^(NSError *error) {
        [WarningBox warningBoxModeText:@"网络请求失败" andView:self.view];
    }];
    
}
-(void)xiazaishuju:(NSString *)str :(NSString *)ss{
    [WarningBox warningBoxModeIndeterminate:[NSString stringWithFormat:@"正在同步%@",str] andView:self.view];
    NSString *fangshi=@"/sys/download";
    NSDictionary*rucan=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"checkId",ss,@"status", nil];
    //自己写的网络请求    请求外网地址
    [XL_WangLuo JuYuwangQingqiuwithBizMethod:fangshi Rucan:rucan type:Post success:^(id responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
        @try {
            
            if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
                [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@同步成功!",str] andView:self.view];
                NSMutableArray *list=[[responseObject objectForKey:@"data"] objectForKey:@"list"];
                NSLog(@"\n\n下载数据*******\n\n%lu",(unsigned long)list.count);
                NSLog(@"\n\n下载数据*******\n\n%@",list);
                [[NSUserDefaults standardUserDefaults] setObject:[list[0] objectForKey:@"checkId"] forKey:@"checkId"];
                [XL clearDatabase:db from:ShangChuanBiaoMing];
                [XL clearDatabase:db from:XiaZaiBiaoMing];
                for (int i=0; i<list.count; i++) {
                    //向下载表中插入数据
                    NSString *barcode =[list[i]objectForKey:@"barCode"];
                    if (NULL==barcode){
                        barcode = @"";
                    }
                    NSString  *code = [NSString stringWithFormat:@"%@,%@",barcode,[list[i]objectForKey:@"productCode"]];
                    NSMutableDictionary * dd=[NSMutableDictionary dictionaryWithDictionary:list[i]];
                    [dd setObject:[NSString stringWithFormat:@"%@", code ] forKey:@"barCode"];
                    [XL DataBase:db insertKeyValues:dd intoTable:XiaZaiBiaoMing];
                }
            }
        } @catch (NSException *exception) {
            [WarningBox warningBoxModeText:@"请仔细检查您的网络" andView:self.view];
        }
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络请求失败" andView:self.view];
    }];
}
-(void)shangchuan:(NSDictionary*)rucan{
    NSString *fangshi=@"/sys/upload";
    [XL_WangLuo JuYuwangQingqiuwithBizMethod:fangshi Rucan:rucan type:Post success:^(id responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqual:@"0000"]) {
            NSString *ss = [NSString stringWithFormat:@"已盘点%lu条数据，成功提交%lu条数据请等待后台处理",[[rucan objectForKey:@"list"]count],[[rucan objectForKey:@"list"]count]];
            [WarningBox warningBoxModeText:ss andView:self.view];
        }else
            [WarningBox warningBoxModeText:@"提交盘点结果失败!" andView:self.view];
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络请求失败" andView:self.view];
    }];
    
}
@end
