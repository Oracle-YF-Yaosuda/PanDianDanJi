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

@interface XL_SearchViewController (){
    NSArray * arr;
    XL_FMDB *   XL;
    FMDatabase *db;
}

@end

@implementation XL_SearchViewController

-(void)viewWillAppear:(BOOL)animated{
    arr=[XL  DataBase:db selectKeyTypes:XiaZaiShiTiLei fromTable:XiaZaiBiaoMing whereKey:@"approvalNumber" containStr:[NSString stringWithFormat:@"%@",_str]];
    NSLog(@"\n\nchuanguolaide-*-*-*-*-*-*-*\n\n%@\n\n",_str);
    if (NULL == arr) {
        NSLog(@"arr==null");
    }else{
        [_table reloadData];
        _table.hidden=NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tabledelegate];
    [self shujuku];
    _table.hidden=YES;
}
-(void)shujuku{
    XL = [XL_FMDB tool];
    [XL_FMDB allocWithZone:NULL];
    db = [XL getDBWithDBName:@"pandian.sqlite"];
    [XL DataBase:db createTable:XiaZaiBiaoMing keyTypes:XiaZaiShiTiLei];
}
#pragma mark ------tableview
-(void)tabledelegate{
    _table.delegate=self;
    _table.dataSource=self;
    _table.hidden=YES;
    //去除多余分割线
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  arr.count;
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
    lll.font=[UIFont boldSystemFontOfSize:16];
    UIView *viewaa=[[UIView alloc] initWithFrame:CGRectMake(10,43 , self.view.frame.size.width, 2)];
    viewaa.backgroundColor=[UIColor colorWithHexString:@"34C083"];
    UILabel * text=[[UILabel alloc] initWithFrame:CGRectMake(100, 10, CGRectGetWidth(self.view.frame)-100,33)];
    text.textColor=[UIColor colorWithHexString:@"646464"];
    text.font=[UIFont boldSystemFontOfSize:16];
    TextFlowView *techangview;
    
    if (indexPath.row==0) {
        lll.text=@"药品名称:";
        techangview = [[TextFlowView alloc] initWithFrame:CGRectMake(100, 10, CGRectGetWidth(self.view.frame)-100,33) Text:[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"productName"]] textColor:[UIColor colorWithHexString:@"646464"] font:[UIFont boldSystemFontOfSize:16] backgroundColor:[UIColor clearColor] alignLeft:YES];
        [cell addSubview:techangview];
    }else if (indexPath.row==1){
        lll.text=@"药品编号:";
        text.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"productCode"]];
    }else if (indexPath.row==2){
        lll.text=@"批      号:";
        text.text=[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"prodBatchNo"]];
    }else if (indexPath.row==3){
        lll.text=@"生产厂家:";
        techangview = [[TextFlowView alloc] initWithFrame:CGRectMake(100, 10, CGRectGetWidth(self.view.frame)-100,33) Text:[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"manufacturer"]] textColor:[UIColor colorWithHexString:@"646464"] font:[UIFont boldSystemFontOfSize:16] backgroundColor:[UIColor clearColor] alignLeft:YES];
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

@end
