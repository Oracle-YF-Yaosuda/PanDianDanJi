//
//  XL_ZhuJiMaViewController.m
//  PanDianDanJi
//
//  Created by newmac on 16/9/14.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import "XL_ZhuJiMaViewController.h"
#import "XL_FMDB.h"
#import "XL_Header.h"

@interface XL_ZhuJiMaViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    XL_FMDB * XL;
    FMDatabase *db;
    NSArray*arr;
}

@end

@implementation XL_ZhuJiMaViewController

-(void)viewWillAppear:(BOOL)animated{
    
    _mytf.text=@"";
    [_mytf becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigation];
    [self textdelegate];
    [self tabledelegate];
    [self shujuku];
}
-(void)shujuku{
    XL = [XL_FMDB tool];
    [XL_FMDB allocWithZone:NULL];
    db = [XL getDBWithDBName:@"pandian.sqlite"];
    //    //新建同步表，里边是同步数据信息
    //    [XL DataBase:db createTable:TongBuBiaoMing keyTypes:TongBuShiTiLei];
    //新建下载表，里边是本次盘点数据
    [XL DataBase:db createTable:XiaZaiBiaoMing keyTypes:XiaZaiShiTiLei];
    //    //新建上传表，里边是需要上传的盘点数据
    //    [XL DataBase:db createTable:ShangChuanBiaoMing keyTypes:ShangChuanShiTiLei];
    
    
    
}
#pragma mark ------textfield
-(void)textdelegate{
    _mytf.delegate=self;
    _mytf.keyboardType=UIKeyboardTypeDefault;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    textField.layer.borderColor=[[UIColor greenColor] CGColor];
    textField.layer.borderWidth=1.0;
    NSString *sou= [textField.text stringByAppendingString:string];
    [self sousuo:sou];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.layer.borderColor=[[UIColor greenColor] CGColor];
    textField.layer.borderWidth=1.0;
}

#pragma mark ------tableview
-(void)tabledelegate{
    //    _table.backgroundColor=[UIColor redColor];
    _table.delegate=self;
    _table.dataSource=self;
    _table.hidden=YES;
    //去除多余分割线
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str=@"cell";
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell==nil) {
        
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    
    UILabel*lll=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 33)];
    lll.textColor=[UIColor grayColor];
    lll.font=[UIFont boldSystemFontOfSize:17];
    UIView *viewaa=[[UIView alloc] initWithFrame:CGRectMake(0,43 , self.view.frame.size.width, 1)];
    viewaa.backgroundColor=[UIColor greenColor];
    UILabel * text=[[UILabel alloc] initWithFrame:CGRectMake(100, 10, CGRectGetWidth(self.view.frame)-100,33)];
    text.textColor=[UIColor grayColor];
    text.font=[UIFont boldSystemFontOfSize:17];
    
    if (indexPath.row==0) {
        lll.text=@"药品名称:";
        text.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"productName"]];
    }else if (indexPath.row==1){
        lll.text=@"药品编号:";
        text.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"productCode"]];
    }else if (indexPath.row==2){
        lll.text=@"批      号:";
        text.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"prodBatchNo"]];
    }else if (indexPath.row==3){
        lll.text=@"生产厂家:";
        text.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"manufacturer"]];
    }else if (indexPath.row==4){
        lll.text=@"药品规格:";
        text.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"specification"]];
        [cell addSubview:viewaa];
    }
    
    
    
    
    
    [cell addSubview:text];
    [cell addSubview:lll];
    //点击不变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
}
#pragma mark ------方法
-(void)sousuo:(NSString *)str{
    if ([str isEqualToString:@""]) {
        _table.hidden=YES;
    }else{
        arr=[XL  DataBase:db selectKeyTypes:XiaZaiShiTiLei fromTable:XiaZaiBiaoMing whereKey:@"approvalNumber" containStr:[NSString stringWithFormat:@"%@",str]];
        [_table reloadData];
        _table.hidden=NO;
    }
}
-(void)navigation{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self  action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
