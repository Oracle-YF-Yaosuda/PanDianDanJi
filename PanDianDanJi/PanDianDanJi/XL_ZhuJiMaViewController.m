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
#import "TextFlowView.h"
#import "Color+Hex.h"
#import "XL_PanDianViewController.h"

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
    textField.layer.borderColor=[[UIColor colorWithHexString:@"34C083"] CGColor];
    textField.layer.borderWidth=1.0;
    NSString *sou= [textField.text stringByAppendingString:string];
    [self sousuo:sou];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.layer.borderColor=[[UIColor colorWithHexString:@"34C083"] CGColor];
    textField.layer.cornerRadius=5;
    textField.layer.borderWidth=1.0;
    textField.keyboardType=UIKeyboardTypeNamePhonePad;
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
    lll.textColor=[UIColor colorWithHexString:@"545454"];
    lll.font=[UIFont boldSystemFontOfSize:18];
    UIView *viewaa=[[UIView alloc] initWithFrame:CGRectMake(10,43 , self.view.frame.size.width, 2)];
    viewaa.backgroundColor=[UIColor colorWithHexString:@"34C083"];
    UILabel * text=[[UILabel alloc] initWithFrame:CGRectMake(100, 10, CGRectGetWidth(self.view.frame)-100,33)];
    text.textColor=[UIColor colorWithHexString:@"646464"];
    text.font=[UIFont boldSystemFontOfSize:18];
    TextFlowView *techangview;
    
    if (indexPath.row==0) {
        lll.text=@"药品名称:";
        techangview = [[TextFlowView alloc] initWithFrame:CGRectMake(100, 10, CGRectGetWidth(self.view.frame)-100,33) Text:[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"productName"]] textColor:[UIColor colorWithHexString:@"646464"] font:[UIFont boldSystemFontOfSize:18] backgroundColor:[UIColor clearColor] alignLeft:YES];
        [cell addSubview:techangview];
    }else if (indexPath.row==1){
        lll.text=@"药品编号:";
        text.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"productCode"]];
    }else if (indexPath.row==2){
        lll.text=@"批      号:";
        text.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"prodBatchNo"]];
    }else if (indexPath.row==3){
        lll.text=@"生产厂家:";
        techangview = [[TextFlowView alloc] initWithFrame:CGRectMake(100, 10, CGRectGetWidth(self.view.frame)-100,33) Text:[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"manufacturer"]] textColor:[UIColor colorWithHexString:@"646464"] font:[UIFont boldSystemFontOfSize:18] backgroundColor:[UIColor clearColor] alignLeft:YES];
        [cell addSubview:techangview];
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
    if (tableView == self.table) {
        NSString *txm=[arr[(long)indexPath.section] objectForKey:@"barCode"];
        if (self.passValueBlock!=nil) {
            self.passValueBlock(txm);
        }
        [self fanhui];
    }
}
-(void)passValue:(PassValueBlock)block{
    
    self.passValueBlock = block;
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self tuijianpan];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self tuijianpan];
}
-(void)tuijianpan{
    [self.view endEditing:YES];
    _mytf.layer.borderColor = [[UIColor blackColor]CGColor];
}
-(void)navigation{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self  action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
    XL_PanDianViewController*pan=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pandian"];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[pan class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}


@end
