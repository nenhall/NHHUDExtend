//
//  ViewController.m
//  NHHUDExtendDemo
//
//  Created by neghao on 2017/6/9.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+NHAdd.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    [MBProgressHUD createNewHud:^(MBProgressHUD *hud) {
        hud.toView(self.view).title(@"dfdfd").customIcon(@"");
  
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

  MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"成功";
//   MBProgressHUD *hud = [MBProgressHUD showOnlyLoadToView:self.view];
//    hud.hudPostion = NHHUDPostionBottom;
//    hud.hudStyle = NHHUDStyleBlack;
    
    [MBProgressHUD showMessage:@"我在这里你知道吗？？" toView:self.view postion:NHHUDPostionBottom];
    
//    [MBProgressHUD showMessage:@"我在这里你知道吗？？" toView:self.view postion:NHHUDPostionTop style:NHHUDStyleDefault];
    
}




@end
