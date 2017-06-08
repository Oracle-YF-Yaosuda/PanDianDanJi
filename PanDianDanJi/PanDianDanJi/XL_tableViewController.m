//
//  XL_tableViewController.m
//  com.BeiGe.PanYouApp
//
//  Created by 小狼 on 2017/5/18.
//  Copyright © 2017年 BinXiaolang. All rights reserved.
//

#import "XL_tableViewController.h"
#import "XL_FMDB.h"
#import "WarningBox.h"
#import "XL_PanDianViewController.h"
#import "Color+Hex.h"
#import "XL_Header.h"
@interface XL_tableViewController ()
{
    XL_FMDB *XL;
    FMDatabase *db;
    
    NSArray*listarray;
}
@end

@implementation XL_tableViewController

-(void)viewWillAppear:(BOOL)animated{
    if (_biaoqian.selectedSegmentIndex == 0) {
        listarray =[self table_array:0];
    }else if(_biaoqian.selectedSegmentIndex == 1){
        listarray =[self table_array:1];
    }
    
    [_tableview reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self shujuku];
    _tableview.delegate =self;
    _tableview.dataSource=self;
    [_biaoqian addTarget:self action:@selector(Action:) forControlEvents:UIControlEventValueChanged];
    _biaoqian.tintColor=[UIColor colorWithHexString:@"34C083"];
    _biaoqian.selectedSegmentIndex=0;
    listarray=[self table_array:0];
    [_tableview reloadData];
    //去除多余分割线
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
-(void)Action:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex ==0) {
        listarray=[self table_array:0];
        [_tableview reloadData];
    }else{
        listarray=[self table_array:1];
        [_tableview reloadData];
    }
}
-(void)shujuku {
    XL = [XL_FMDB tool];
    [XL_FMDB allocWithZone:NULL];
    db = [XL getDBWithDBName:@"pandian.sqlite"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aa=@"weipan";
    UITableViewCell *cell=[self.tableview dequeueReusableCellWithIdentifier:aa];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
    }
    UILabel *huowei    =[cell viewWithTag:1000];
    UILabel *yaoming    =[cell viewWithTag:1001];    //weipan
    yaoming.textAlignment=NSTextAlignmentCenter;
    if (NULL == [listarray[indexPath.row] objectForKey:@"hwh"]) {
        huowei.text=@"";
    }else{
        huowei.text=[NSString stringWithFormat:@"%@",[listarray[indexPath.row] objectForKey:@"hwh"]];
    }
    if (nil ==[listarray[indexPath.row] objectForKey:@"productName"]) {
        yaoming.text=@"";
    }else{
        yaoming.text=[NSString stringWithFormat:@"%@",[listarray[indexPath.row] objectForKey:@"productName"]];
    }
    //点击不变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XL_PanDianViewController *pandian = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pandian"];
    pandian.rukou = @"1";//productCode
    if (NULL ==[listarray[indexPath.row] objectForKey:@"barCode"]) {
        pandian.jieshouzhi=[listarray[indexPath.row] objectForKey:@"productCode"];
    }else{
        pandian.jieshouzhi=[listarray[indexPath.row] objectForKey:@"barCode"];
    }
    [self.navigationController pushViewController:pandian animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listarray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSArray*)table_array:(int )i{
    NSArray* aa=[[NSArray alloc] init];
    NSDictionary*dd=[NSDictionary dictionaryWithObjectsAndKeys: @"0", @"checkNum",nil];
    if (i ==0) {
        aa=[XL DataBase:db selectKeyTypes:XiaZaiShiTiLei fromTable:XiaZaiBiaoMing where___Condition:dd];
    }else if (i == 1){
        aa=[XL DataBase:db selectKeyTypes:XiaZaiShiTiLei fromTable:XiaZaiBiaoMing where_Condition:dd];
    }
    return aa;
}
-(void)navigation{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
