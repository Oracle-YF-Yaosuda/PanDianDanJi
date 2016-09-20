//
//  XL_PanDianViewController.m
//  PanDianDanJi
//
//  Created by newmac on 16/9/14.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import "XL_PanDianViewController.h"
#import "XL_ZhuJiMaViewController.h"
#import "DSKyeboard.h"
#import "XL_Header.h"
#import "XL_FMDB.h"
#import "WarningBox.h"
@interface XL_PanDianViewController (){
    
    XL_FMDB *XL;
    FMDatabase *db;
    
    /*判断传值*/
    int chuanzhipanduan;
}

@end

@implementation XL_PanDianViewController

-(void)viewWillAppear:(BOOL)animated{
    if (chuanzhipanduan==1) {
        chuanzhipanduan=0;
        
        
    }
    else{
        
        
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    chuanzhipanduan=0;
     UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    [_ypname addGestureRecognizer:labelTapGestureRecognizer];
    _ypname.userInteractionEnabled = YES;
    _Search.textColor = [UIColor lightGrayColor];
   
    [_Search.layer setBorderWidth:1.0];
    [_Search.layer setCornerRadius:5.0];
    
    
    
    [self shujuku];
    // Do any additional setup after loading the view.
}

-(void)labelClick{
    NSLog(@"1");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)shujuku {
    XL = [XL_FMDB tool];
    [XL_FMDB allocWithZone:NULL];
    db = [XL getDBWithDBName:@"pandian.sqlite"];
    
}

#pragma mark  数字键盘
- (IBAction)zero:(id)sender {
    if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
    _Search.text = @"0";
    }else{
        
        _Search.text = [_Search.text stringByAppendingString:@"0"];
    }
}

- (IBAction)one:(id)sender {

    if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
        _Search.text = @"1";
    }else{
        _Search.text = [_Search.text stringByAppendingString:@"1"];
    }
}

- (IBAction)two:(id)sender {
    if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
        _Search.text = @"2";
    }else{
        _Search.text = [_Search.text stringByAppendingString:@"2"];
    }
}

- (IBAction)three:(id)sender {
    if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
        _Search.text = @"3";
    }else{
        _Search.text = [_Search.text stringByAppendingString:@"3"];
    }
}

- (IBAction)four:(id)sender {
    if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
        _Search.text = @"4";
    }else{
        _Search.text = [_Search.text stringByAppendingString:@"4"];
    }
}

- (IBAction)five:(id)sender {
    if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
        _Search.text = @"5";
    }else{
        _Search.text = [_Search.text stringByAppendingString:@"5"];
    }
}

- (IBAction)six:(id)sender {
    if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
        _Search.text = @"6";
    }else{
        _Search.text = [_Search.text stringByAppendingString:@"6"];
    }
}

- (IBAction)seven:(id)sender {
    if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
        _Search.text = @"7";
    }else{
        _Search.text = [_Search.text stringByAppendingString:@"7"];
    }
}


- (IBAction)eight:(id)sender {
    if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
        _Search.text = @"8";
    }else{
        _Search.text = [_Search.text stringByAppendingString:@"8"];
    }
}

- (IBAction)nine:(id)sender {
    if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
        _Search.text = @"9";
    }else{
        _Search.text = [_Search.text stringByAppendingString:@"9"];
    }
}

- (IBAction)houtui:(id)sender {
    if([_Search.text isEqualToString:@""]||[_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
     _Search.text = @"🔍扫描或输入药品条形码";
    }else{
     _Search.text= [_Search.text substringToIndex:[_Search.text length] - 1];
        if(_Search.text.length==0){
        _Search.text = @"🔍扫描或输入药品条形码";
        }
    }
    
}

- (IBAction)clear:(id)sender {
    
  _Search.text = @"🔍扫描或输入药品条形码";
    
}

- (IBAction)check:(id)sender {
    
    if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
       [WarningBox warningBoxModeText:@"请输入条码后进行查询" andView:self.view];
    }else{
       NSArray *arr=[XL  DataBase:db selectKeyTypes:XiaZaiShiTiLei fromTable:XiaZaiBiaoMing whereKey:@"barCode" containStr:[NSString stringWithFormat:@"%@",_Search.text]];
   
        NSLog(@"%@",arr);
    }
    
    
}

- (IBAction)zhujima:(id)sender {
    
    XL_ZhuJiMaViewController *zhuji=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"zhujima"];
    [zhuji passValue:^(NSString *str) {
        _Search.text=str;
        chuanzhipanduan=1;
        NSLog(@"%@",str);
    }];

    [self.navigationController pushViewController:zhuji animated:YES];
   
}
@end
