//
//  MBProgressHUD+NHAdd.m
//  NHHUDExtendDemo
//
//  Created by neghao on 2017/6/11.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "MBProgressHUD+NHAdd.h"
#import "MBProgressHUD_NHExtend.h"

CGFloat const delayTime = 1.2;
#define kLoadImage(name) [UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", (name)]]


@implementation MBProgressHUD (NHAdd)

NS_INLINE MBProgressHUD *createNew(UIView *view) {
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    return [MBProgressHUD showHUDAddedTo:view animated:YES];
}

NS_INLINE MBProgressHUD *settHUD(UIView *view, NSString *title) {
    MBProgressHUD *hud = createNew(view);
    //文字
    hud.label.text = title;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    //设置默认风格
    if (NHDefaultHudStyle == 1) {
        hud.hudStyle = NHHUDStyleBlack;
        
    } else if (NHDefaultHudStyle == 2) {
        hud.hudStyle = NHHUDStyleCustom;
    }
    
    // x秒之后消失
    [hud hideAnimated:YES afterDelay:delayTime];
    return hud;
}


- (void)setHudStyle:(NHHUDStyle)hudStyle {
    if (hudStyle == NHHUDStyleBlack) {
        self.bezelView.backgroundColor = [UIColor blackColor];
        self.contentColor = [UIColor whiteColor];
        
    } else if (hudStyle == NHHUDStyleCustom) {
        self.bezelView.backgroundColor = NHCustomHudStyleBackgrandColor;
        self.contentColor = NHCustomHudStyleContentColor;
        
    } else {
        self.bezelView.backgroundColor = [UIColor whiteColor];
        self.contentColor = [UIColor blackColor];
        self.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
        self.backgroundView.alpha = 0;
    }
}

- (void)setHudPostion:(NHHUDPostion)hudPostion {
    if (hudPostion == NHHUDPostionTop) {
        self.offset = CGPointMake(0.f, -MBProgressMaxOffset);
    } else if (hudPostion == NHHUDPostionCenten) {
        self.offset = CGPointMake(0.f, 0.f);
    } else {
        self.offset = CGPointMake(0.f, MBProgressMaxOffset);
    }
}


+ (MBProgressHUD *)showOnlyLoadToView:(UIView *)view {
   return createNew(view);
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    MBProgressHUD *hud = settHUD(view, success);
    
    // 设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.customView = [[UIImageView alloc] initWithImage:kLoadImage(@"success.png")];
}


+ (void)showError:(NSString *)error toView:(UIView *)view {
    MBProgressHUD *hud = settHUD(view, error);
    // 设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 自定义图片
    hud.customView = [[UIImageView alloc] initWithImage:kLoadImage(@"error.png")];
}


+ (void)showMessage:(NSString *)message toView:(UIView *)view {

    MBProgressHUD *hud = settHUD(view, message);
    hud.mode = MBProgressHUDModeText;
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view postion:(NHHUDPostion)postion {
    MBProgressHUD *hud = settHUD(view, message);
    hud.mode = MBProgressHUDModeText;
    hud.hudPostion = postion;
}


+ (void)showMessage:(NSString *)message toView:(UIView *)view style:(NHHUDStyle)style {
    MBProgressHUD *hud = settHUD(view, message);
    hud.mode = MBProgressHUDModeText;
    hud.hudStyle = style;
}


+ (void)showMessage:(NSString *)message
             toView:(UIView *)view
            postion:(NHHUDPostion)postion
              style:(NHHUDStyle)style {
    
    MBProgressHUD *hud = settHUD(view, message);
    hud.mode = MBProgressHUDModeText;
    hud.hudStyle = style;
    hud.hudPostion = postion;
}







+ (MBProgressHUD *)createNewHud:(void (^)(MBProgressHUD *))hudBlock {
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hudBlock(hud);
    return hud;
}

- (MBProgressHUD *(^)(UIView *))toView {

    return ^(UIView *view){
        
        return self;
    };
}

- (MBProgressHUD *(^)(NSString *))title {
    return ^(NSString *title){
        
        return self;
    };
}

- (MBProgressHUD *(^)(NSString *))customIcon {

    return ^(NSString *customIcon) {
        return self;
    };
}



@end
