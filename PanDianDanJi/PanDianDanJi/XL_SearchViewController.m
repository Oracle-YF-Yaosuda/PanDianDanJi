//
//  XL_SearchViewController.m
//  PanDianDanJi
//
//  Created by newmac on 16/9/19.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import "XL_SearchViewController.h"
#import "TextFlowView.h"
#import "Color+Hex.h"
#import "XL_FMDB.h"
#import "XL_Header.h"
#import "DSKyeboard.h"
#import "WarningBox/WarningBox.h"
#import "ZYCustomKeyboardTypeNumberView.h"

@interface XL_SearchViewController ()<ZYCustomKeyboardTypeNumberViewDelegate>{
    NSArray *  arr;
    XL_FMDB *   XL;
    FMDatabase *db;
    
    NSMutableDictionary*dic11;
}

@end

@implementation XL_SearchViewController

-(void)viewWillAppear:(BOOL)animated{
    
    arr=[XL  DataBase:db selectKeyTypes:TongBuShiTiLei fromTable:TongBuBiaoMing whereCondition:[NSDictionary dictionaryWithObjectsAndKeys:_str,@"barCode", nil]];
    if (arr.count==0) {
        NSArray*diyi;
        diyi =[ XL DataBase:db selectKeyTypes:TongBuShiTiLei fromTable:TongBuBiaoMing whereKey:@"barCode" containStr:@","] ;
        NSMutableArray *arr2=[[NSMutableArray alloc] init];
        for (NSDictionary*dd in diyi) {
            NSString *muma=[NSString stringWithFormat:@"%@",[dd objectForKey:@"barCode"]];
            NSArray * dier=[muma componentsSeparatedByString:@","];
            for (NSString*ss in dier) {
                if ([ss isEqualToString:_str]) {
                    [arr2 addObject:dd];
                    break;
                }
            }
        }
        
        arr =[NSArray arrayWithArray:arr2];
    }
    if (arr.count==0) {
        dic11=[[NSMutableDictionary alloc] init];
        [self navigationyou];
    }else{
        dic11=[NSMutableDictionary dictionaryWithDictionary:arr[0]];
        [_table reloadData];
        _table.hidden=NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tabledelegate];
    [self shujuku];
    [self navigation];
}
-(void)shujuku{
    XL = [XL_FMDB tool];
    [XL_FMDB allocWithZone:NULL];
    db = [XL getDBWithDBName:@"pandian.sqlite"];
    [XL DataBase:db createTable:TongBuBiaoMing keyTypes:TongBuShiTiLei];
}
#pragma mark ------tableview
-(void)tabledelegate{
    _table.delegate=self;
    _table.dataSource=self;
    //去除多余分割线
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //解决tableview多出的白条
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(NSArray*)gudingshuzu{
    NSArray *guding =[NSArray arrayWithObjects:@"药品名称:",@"药品数量:",@"药品编号:",@"货        位:",@"助  记  码:",@"生产厂家:",@"药品规格:",@"批        号:", nil];
    return guding;
}
-(NSArray *)duiying{
    NSArray*guding=[NSArray arrayWithObjects:@"productName",@"checkNum",@"productCode",@"oldpos",@"pycode",@"manufacturer",@"specification",@"prodBatchNo",nil];
    return guding;
}
-(NSArray *)xiabian{
    NSArray*guding=[NSArray arrayWithObjects:@"药品名称:",@"药品编号:",@"批        号:",@"生产厂家:",@"药品规格:",nil];
    return guding;
}
-(NSArray *)tishi{
    NSArray*tishi=[NSArray arrayWithObjects:@"例:阿莫西林",@"例:10",@"例:4111011",@"例:A1",@"例:AMXL",@"例:吉林银河药业有限公司",@"例:57mg*6片",@"例:J7628", nil];
    return tishi;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  arr.count+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 8;
    }else
        return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str=@"cell";
    NSArray*guding=[self gudingshuzu];
    NSArray*xiabian=[self xiabian];
    NSArray*tishi=[self tishi];
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    UILabel*lll=[[UILabel alloc] initWithFrame:CGRectMake(10, 7, 100, 30)];
    lll.textColor=[UIColor colorWithHexString:@"545454"];
    lll.font=[UIFont boldSystemFontOfSize:16];
    UITextField * text=[[UITextField alloc] initWithFrame:CGRectMake(100, 7, CGRectGetWidth(self.view.frame)-110,30)];
    text.textColor=[UIColor colorWithHexString:@"646464"];
    text.tag=100+indexPath.row;
    text.layer.cornerRadius=5;
    text.layer.borderWidth=1;
    text.delegate=self;
    text.layer.borderColor=[[UIColor grayColor] CGColor];
    text.placeholder=tishi[indexPath.row];
    text.adjustsFontSizeToFitWidth=YES;
    if (text.tag==101) {
         [ZYCustomKeyboardTypeNumberView customKeyboardViewWithServiceTextField:text Delegate:self];
    }
    UILabel *text1=[[UILabel alloc] initWithFrame:CGRectMake(100, 7, CGRectGetWidth(self.view.frame)-110,30)];
    text1.textColor=[UIColor colorWithHexString:@"767676"];
    if (indexPath.section==0) {
        lll.text=guding[indexPath.row];
        NSArray *hah=[self duiying];
        if (NULL != [dic11 objectForKey:hah[indexPath.row]]) {
            text.text=[NSString stringWithFormat:@"%@",[dic11 objectForKey:hah[indexPath.row]] ];
        }else{
            if(indexPath.row==0){
                @try {
                    if (NULL==[arr[0] objectForKey:@"productName"]){
                        text.text = @"";
                    }else
                        text.text=[NSString stringWithFormat:@"%@",[arr[0] objectForKey:@"productName"]];
                } @catch (NSException *exception) {
                    text.text=@"";
                }
            }else if (indexPath.row==1){
            }else if (indexPath.row==2){
                @try {
                    if (NULL==[arr[0] objectForKey:@"productCode"]){
                        text.text = @"";
                    }else
                        text.text=[NSString stringWithFormat:@"%@",[arr[0] objectForKey:@"productCode"]];
                } @catch (NSException *exception) {
                    text.text=@"";
                }
            }else if (indexPath.row==3){
                text.text=@"";
            }else if (indexPath.row==4){
                @try {
                    if (NULL==[arr[0] objectForKey:@"pycode"]){
                        text.text = @"";
                    }else
                        text.text=[NSString stringWithFormat:@"%@",[arr[0] objectForKey:@"pycode"]];
                } @catch (NSException *exception) {
                    text.text=@"";
                }
            }else if (indexPath.row==5){
                @try {
                    if (NULL==[arr[0] objectForKey:@"manufacturer"]){
                        text.text = @"";
                    }else
                        text.text=[NSString stringWithFormat:@"%@",[arr[0] objectForKey:@"manufacturer"]];
                } @catch (NSException *exception) {
                    text.text=@"";
                }
            }else if (indexPath.row==6){
                @try {
                    if (NULL==[arr[0] objectForKey:@"specification"]){
                        text.text = @"";
                    }else
                        text.text=[NSString stringWithFormat:@"%@",[arr[0] objectForKey:@"specification"]];
                } @catch (NSException *exception) {
                    text.text=@"";
                }
            }else if (indexPath.row==7){
                @try {
                    if (NULL==[arr[0] objectForKey:@"prodBatchNo"]){
                        text.text = @"";
                    }else
                        text.text=[NSString stringWithFormat:@"%@",[arr[0] objectForKey:@"prodBatchNo"]];
                } @catch (NSException *exception) {
                    text.text=@"";
                }
            }
        }
        [cell addSubview:text];
    }else{
        lll.text=xiabian[indexPath.row];
        
        if(indexPath.row==0){
            if (NULL==[arr[indexPath.section-1] objectForKey:@"productName"]){
                text1.text = @"";
            }else
                text1.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section-1] objectForKey:@"productName"]];
        }else if (indexPath.row==1){
            if (NULL==[arr[indexPath.section-1] objectForKey:@"productCode"]){
                text1.text = @"";
            }else
                text1.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section-1] objectForKey:@"productCode"]];
        }else if (indexPath.row==2){
            if (NULL==[arr[indexPath.section-1] objectForKey:@"prodBatchNo"]){
                text1.text = @"";
            }else
                text1.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section-1] objectForKey:@"prodBatchNo"]];
        }else if (indexPath.row==3){
            if (NULL==[arr[indexPath.section-1] objectForKey:@"manufacturer"]){
                text1.text = @"";
            }else
                text1.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section-1] objectForKey:@"manufacturer"]];
        }else if (indexPath.row==4){
            if (NULL==[arr[indexPath.section-1] objectForKey:@"specification"]){
                text1.text = @"";
            }else
                text1.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section-1] objectForKey:@"specification"]];
        }
        [cell addSubview:text1];
    }
    [cell addSubview:lll];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setupCustomedKeyboard:(UITextField*)tf {
    tf.inputView = [DSKyeboard keyboardWithTextField:tf];
    [(DSKyeboard *)tf.inputView dsKeyboardTextChangedOutputBlock:^(NSString *fakePassword) {
        tf.text = fakePassword;
    } loginBlock:^(NSString *password) {
        [tf resignFirstResponder];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section!=0) {
        NSMutableDictionary*txm=[NSMutableDictionary dictionaryWithDictionary:arr[indexPath.section-1]];
        [txm setObject:@"0" forKey:@"checkNum"];
        [txm setObject:@"" forKey:@"oldpos"];
        if (self.passdicValueBlock!=nil) {
            self.passdicValueBlock(txm);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.view endEditing:YES];
    }
}
#pragma mark-----text
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (arr.count!=0) {
        if (textField.tag==103) {
            [self setupCustomedKeyboard:textField];
            [self navigationyou];
        
        }else
            return NO;
    }else{
        if (textField.tag==101) {
            
        }else
            [self setupCustomedKeyboard:textField];
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    UITableViewCell * cell=(UITableViewCell*)[textField superview];
    NSIndexPath *indexPath=[_table indexPathForCell:cell];
    NSArray*guiding=[self duiying];
    [dic11 setObject:textField.text forKey:[NSString stringWithFormat:@"%@",guiding[indexPath.row]]];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    if(textField.tag == 100||textField.tag == 101||textField.tag==105||textField.tag==106){
//        textField.inputView = nil;
//        [textField reloadInputViews];
//        [textField becomeFirstResponder];
//    }
}
-(void)passdicValue:(PassdicValueBlock)block{
    self.passdicValueBlock = block;
}
#pragma mark ------上边按钮
-(void)navigation{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self  action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)navigationyou{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self  action:@selector(baocun)];
    [self.navigationItem setRightBarButtonItem:left];
}
-(void)fanhui{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)baocun{
    [self.view endEditing:YES];
    if (arr.count==0) {
        if ([dic11 allKeys].count==8) {
            [self chuanshu];
        }else
            [WarningBox warningBoxModeText:@"请填写完整信息!" andView:self.view];
        
    }else{
        if (NULL == [dic11 objectForKey:@"checkNum"]) {
            [WarningBox warningBoxModeText:@"请填写完整信息!" andView:self.view];
        }else
            [self chuanshu];
    }
}
-(void)chuanshu{
    int q=0;
    for (NSString*ss in [dic11 allKeys]) {
        if ([[dic11 objectForKey:ss]isEqualToString:@""]) {
            if ([ss isEqualToString:@"approvalNumber"]) {
                
            }else
                q=1;
        }
    }
    if (q==0) {
        NSMutableDictionary *dd=[NSMutableDictionary dictionaryWithDictionary:dic11];
        if (arr.count==0) {
            [dd setObject:_str forKey:@"barCode"];
        }
        if (self.passdicValueBlock!=nil) {
            self.passdicValueBlock(dd);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [WarningBox warningBoxModeText:@"请填写完整信息!" andView:self.view];
    }
}


@end
