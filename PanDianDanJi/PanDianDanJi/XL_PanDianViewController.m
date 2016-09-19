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
@interface XL_PanDianViewController (){
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
- (IBAction)zero:(id)sender {
    _Search.text = @"0";
}

- (IBAction)one:(id)sender {
}

- (IBAction)two:(id)sender {
}

- (IBAction)three:(id)sender {
}

- (IBAction)four:(id)sender {
}

- (IBAction)five:(id)sender {
}

- (IBAction)six:(id)sender {
}

- (IBAction)seven:(id)sender {
}

- (IBAction)eight:(id)sender {
}

- (IBAction)nine:(id)sender {
}

- (IBAction)houtui:(id)sender {
}

- (IBAction)clear:(id)sender {
    
  _Search.text = @"🔍扫描或输入药品条形码";
    
}

- (IBAction)check:(id)sender {
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
