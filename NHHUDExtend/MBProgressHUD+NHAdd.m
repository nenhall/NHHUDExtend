//
//  MBProgressHUD+NHAdd.m
//  NHHUDExtendDemo
//
//  Created by neghao on 2017/6/11.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "MBProgressHUD+NHAdd.h"
#import "MBProgressHUD_NHExtend.h"
#import <objc/message.h>

CGFloat const delayTime = 1.2;
#define kLoadImage(name) [UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", (name)]]


@implementation MBProgressHUD (NHAdd)
static char activeBlockKey;
static char cancelationKey;


NS_INLINE MBProgressHUD *createNew(UIView *view) {
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    return [MBProgressHUD showHUDAddedTo:view animated:YES];
}

NS_INLINE MBProgressHUD *settHUD(UIView *view, NSString *title, BOOL autoHidden) {
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
    
    if (autoHidden) {
        // x秒之后消失
        [hud hideAnimated:YES afterDelay:delayTime];
    }
    
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
        if (NHDefaultHudStyle == 1) {
            self.bezelView.backgroundColor = [UIColor blackColor];
            self.contentColor = [UIColor whiteColor];
            
        } else {
            self.bezelView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
            self.contentColor = [UIColor colorWithWhite:0.f alpha:0.7f];
        }
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

- (void)setCancelation:(NHCancelation)cancelation {
    objc_setAssociatedObject(self, &cancelationKey, cancelation, OBJC_ASSOCIATION_COPY);
}

- (NHCancelation)cancelation {
    return objc_getAssociatedObject(self, &cancelationKey);
}

- (void)setActiveBlock:(NHActiveBlock)activeBlock {
    objc_setAssociatedObject(self, &activeBlockKey, activeBlock, OBJC_ASSOCIATION_COPY);
}

- (NHActiveBlock)activeBlock {
    return objc_getAssociatedObject(self, &activeBlockKey);
}


+ (MBProgressHUD *)showOnlyLoadToView:(UIView *)view {
   return createNew(view);
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    MBProgressHUD *hud = settHUD(view, success, YES);
    
    // 设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.customView = [[UIImageView alloc] initWithImage:kLoadImage(@"success.png")];
}


+ (void)showError:(NSString *)error toView:(UIView *)view {
    MBProgressHUD *hud = settHUD(view, error, YES);
    // 设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 自定义图片
    hud.customView = [[UIImageView alloc] initWithImage:kLoadImage(@"error.png")];
}


+ (void)showToView:(UIView *)view title:(NSString *)title {
    MBProgressHUD *hud = settHUD(view, title, YES);
    hud.mode = MBProgressHUDModeText;
}

+ (void)showToView:(UIView *)view postion:(NHHUDPostion)postion title:(NSString *)title {
    MBProgressHUD *hud = settHUD(view, title, YES);
    hud.mode = MBProgressHUDModeText;
    hud.hudPostion = postion;
}


+ (void)showToView:(UIView *)view style:(NHHUDStyle)style title:(NSString *)title{
    MBProgressHUD *hud = settHUD(view, title, YES);
    hud.mode = MBProgressHUDModeText;
    hud.hudStyle = style;
}

+ (void)showToView:(UIView *)view
           postion:(NHHUDPostion)postion
             style:(NHHUDStyle)style
             title:(NSString *)title {
    
    MBProgressHUD *hud = settHUD(view, title, YES);
    hud.mode = MBProgressHUDModeText;
    hud.hudStyle = style;
    hud.hudPostion = postion;
}


+ (MBProgressHUD *)showLoadToView:(UIView *)view title:(NSString *)title {
    MBProgressHUD *hud = settHUD(view, title, NO);
    hud.mode = MBProgressHUDModeIndeterminate;
    return hud;
}


+ (MBProgressHUD *)showDeterminateToView:(UIView *)view title:(NSString *)title progress:(NHDownProgress)progress {
    MBProgressHUD *hud = settHUD(view, title, NO);
    hud.mode = MBProgressHUDModeDeterminate;
    if (progress) {
        progress(hud);
    }
    return hud;
}


+ (MBProgressHUD *)showAnnularDeterminateToView:(UIView *)view title:(NSString *)title progress:(NHDownProgress)progress {
    MBProgressHUD *hud = settHUD(view, title, NO);
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    if (progress) {
        progress(hud);
    }
    return hud;
}

//横向bar进度条
+ (MBProgressHUD *)showBarDeterminateToView:(UIView *)view title:(NSString *)title progress:(NHDownProgress)progress {
    MBProgressHUD *hud = settHUD(view, title, NO);
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    if (progress) {
        progress(hud);
    }
    return hud;
}


+ (MBProgressHUD *)showCancelationDeterminateToView:(UIView *)view
                                              title:(NSString *)title
                                        cancelTitle:(NSString *)cancelTitle
                                           progress:(NHDownProgress)progress
                                        cancelation:(NHCancelation)cancelation {
    MBProgressHUD *hud = settHUD(view, title, NO);
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    [hud.button setTitle:cancelTitle ?: NSLocalizedString(@"Cancel", @"HUD cancel button title") forState:UIControlStateNormal];
    [hud.button addTarget:hud action:@selector(didClickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    if (progress) {
        progress(hud);
    }
    hud.cancelation = cancelation;
    
    return hud;
}


+ (void)showCustomView:(UIImage *)image toView:(UIView *)toView title:(NSString *)title {

    MBProgressHUD *hud = settHUD(toView, title, YES);
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
}


+ (void)showModelSwitchingToView:(UIView *)toView title:(NSString *)title hudBlock:(NHDownProgress)hudBlock{
    
    MBProgressHUD *hud = settHUD(toView, title, NO);
    
    // Will look best, if we set a minimum size.
    hud.minSize = CGSizeMake(150.f, 100.f);
    
    if (hudBlock) {
        hudBlock(hud);
    }
}


- (void)didClickCancelButton {
    if (self.cancelation) {
        self.cancelation(self);
    }
}

+ (MBProgressHUD *)showDeterminateNSProgressToView:(UIView *)view title:(NSString *)title {
    MBProgressHUD *hud = settHUD(view, title, NO);
    hud.mode = MBProgressHUDModeDeterminate;
    return hud;
}


+ (MBProgressHUD *)showNetworkingNSProgressToView:(UIView *)view title:(NSString *)title {
    MBProgressHUD *hud = settHUD(view, title, NO);
    hud.minSize = CGSizeMake(150.f, 100.f);
    return hud;
}

+ (MBProgressHUD *)showDeterminateWithNSProgress:(NSProgress *)Progress toView:(UIView *)view title:(NSString *)title hudBlock:(NHDownProgress)hudBlock {
    MBProgressHUD *hud = settHUD(view, title, NO);
    if (hudBlock) {
        hudBlock(hud);
    }
    return hud;
}


+ (MBProgressHUD *)showLoadToView:(UIView *)view backgroundColor:(UIColor *)backgroundColor title:(NSString *)title {
    MBProgressHUD *hud = settHUD(view, title, NO);
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.backgroundColor = backgroundColor;
    return hud;
}

+ (MBProgressHUD *)showLoadToView:(UIView *)view contentColor:(UIColor *)contentColor title:(NSString *)title {
    MBProgressHUD *hud = settHUD(view, title, NO);
    hud.contentColor = contentColor;
//    hud.bezelView.backgroundColor = [UIColor blackColor];
//    hud.label.textColor = [UIColor redColor];
//    hud.backgroundView.color = [UIColor blackColor];
    
    return hud;
}

+ (MBProgressHUD *)showLoadToView:(UIView *)view
                     contentColor:(UIColor *)contentColor
                  backgroundColor:(UIColor *)backgroundColor
                            title:(NSString *)title {
    
    MBProgressHUD *hud = settHUD(view, title, NO);
    hud.contentColor = contentColor;
    //    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.backgroundView.color = backgroundColor;
    
    return hud;
}


//+ (MBProgressHUD *)showLoadToView:(UIView *)view backgroundColor:(UIColor *)backgroundColor contentColor:(UIColor *)contentColor  title:(NSString *)title {


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
