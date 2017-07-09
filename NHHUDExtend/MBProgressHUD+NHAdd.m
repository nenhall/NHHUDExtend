//
//  MBProgressHUD+NHAdd.m
//  NHHUDExtendDemo
//
//  Created by neghao on 2017/6/11.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "MBProgressHUD+NHAdd.h"
#import "MBProgressHUD_NHExtend.h"
#import "MBProgressHUD.h"
#import <objc/message.h>

CGFloat const delayTime = 1.2;
#define kLoadImage(name) [UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", (name)]]


@implementation MBProgressHUD (NHAdd)
static char cancelationKey;


NS_INLINE MBProgressHUD *createNew(UIView *view) {
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    return [MBProgressHUD showHUDAddedTo:view animated:YES];
}

NS_INLINE MBProgressHUD *settHUD(UIView *view, NSString *title, BOOL autoHidden) {
    MBProgressHUD *hud = createNew(view);
    //文字
    hud.label.text = title;
    //支持多行
    hud.label.numberOfLines = 0;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    //设置默认风格
    if (NHDefaultHudStyle == 1) {
        hud.hudContentStyle(NHHUDContentBlack);
        
    } else if (NHDefaultHudStyle == 2) {
        hud.hudContentStyle(NHHUDContentCustom);
    }
    
    if (autoHidden) {
        // x秒之后消失
        [hud hideAnimated:YES afterDelay:delayTime];
    }
    
    return hud;
}


+ (MBProgressHUD *)showOnlyLoadToView:(UIView *)view {
   return createNew(view);
}

+ (void)showOnlyTextToView:(UIView *)view title:(NSString *)title {
    MBProgressHUD *hud = settHUD(view, title, YES);
    hud.mode = MBProgressHUDModeText;
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


+ (void)showTitleToView:(UIView *)view postion:(NHHUDPostion)postion title:(NSString *)title {
    MBProgressHUD *hud = settHUD(view, title, YES);
    hud.mode = MBProgressHUDModeText;
    hud.hudPostion(postion);
}

//纯标题 + 自定背景风格 - 自动消失
+ (void)showTitleToView:(UIView *)view contentStyle:(NHHUDContentStyle)contentStyle title:(NSString *)title{
    MBProgressHUD *hud = settHUD(view, title, YES);
    hud.mode = MBProgressHUDModeText;
    hud.hudContentStyle(contentStyle);
}

//纯标题 + 详情 + 自定背景风格 - 自动消失
+ (void)showDetailToView:(UIView *)view contentStyle:(NHHUDContentStyle)contentStyle title:(NSString *)title detail:(NSString *)detail {
    MBProgressHUD *hud = settHUD(view, title, YES);
    hud.detailsLabel.text = detail;
    hud.mode = MBProgressHUDModeText;
    hud.hudContentStyle(contentStyle);
}

+ (void)showTitleToView:(UIView *)view
                postion:(NHHUDPostion)postion
           contentStyle:(NHHUDContentStyle)contentStyle
                  title:(NSString *)title {
    
    MBProgressHUD *hud = settHUD(view, title, YES);
    hud.mode = MBProgressHUDModeText;
    hud.hudContentStyle(contentStyle);
    hud.hudPostion(postion);
}


+ (MBProgressHUD *)showLoadToView:(UIView *)view title:(NSString *)title {
    MBProgressHUD *hud = settHUD(view, title, NO);
    hud.mode = MBProgressHUDModeIndeterminate;
    return hud;
}


+ (void)showTitleToView:(UIView *)view contentStyle:(NHHUDContentStyle)contentStyle title:(NSString *)title afterDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = settHUD(view, title, NO);
    hud.mode = MBProgressHUDModeText;
    hud.hudContentStyle(contentStyle);
    [hud hideAnimated:YES afterDelay:delay];
}


+ (MBProgressHUD *)showDownToView:(UIView *)view progressStyle:(NHHUDProgressStyle)progressStyle title:(NSString *)title progress:(NHCurrentHud)progress {
    MBProgressHUD *hud = settHUD(view, title, NO);
    
    if (progressStyle == NHHUDProgressDeterminateHorizontalBar) {
        hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
        
    } else if (progressStyle == NHHUDProgressDeterminate) {
        hud.mode = MBProgressHUDModeDeterminate;
        
    } else if (progressStyle == NHHUDProgressAnnularDeterminate) {
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        
    }

    if (progress) {
        progress(hud);
    }
    return hud;
    
}

+ (MBProgressHUD *)showCancelationToView:(UIView *)view
                           progressStyle:(NHHUDProgressStyle)progressStyle
                                   title:(NSString *)title
                             cancelTitle:(NSString *)cancelTitle
                                progress:(NHCurrentHud)progress
                             cancelation:(NHCancelation)cancelation {
    
    MBProgressHUD *hud = settHUD(view, title, NO);
    
    if (progressStyle == NHHUDProgressDeterminateHorizontalBar) {
        hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
        
    } else if (progressStyle == NHHUDProgressDeterminate) {
        hud.mode = MBProgressHUDModeDeterminate;
        
    } else if (progressStyle == NHHUDProgressAnnularDeterminate) {
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        
    }
    
    [hud.button setTitle:cancelTitle ?: NSLocalizedString(@"Cancel", @"HUD cancel button title") forState:UIControlStateNormal];
    [hud.button addTarget:hud action:@selector(didClickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    hud.cancelation(cancelation);
    if (progress) {
        progress(hud);
    }
    
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


+ (void)showModelSwitchToView:(UIView *)toView title:(NSString *)title hudBlock:(NHCurrentHud)hudBlock{
    
    MBProgressHUD *hud = settHUD(toView, title, NO);
    
    // Will look best, if we set a minimum size.
    hud.minSize = CGSizeMake(150.f, 100.f);
    
    if (hudBlock) {
        hudBlock(hud);
    }
}


- (void)didClickCancelButton {
    if (self.cancelation) {
        self.cancelation = ^(NHCancelation cancelation) {
//                    objc_setAssociatedObject(self, &cancelationKey, cancelation, OBJC_ASSOCIATION_COPY);
//            objc_getAssociatedObject(self, &cancelationKey);
                    return self;
                };
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

+ (MBProgressHUD *)showDeterminateWithNSProgress:(NSProgress *)Progress toView:(UIView *)view title:(NSString *)title hudBlock:(NHCurrentHud)hudBlock {
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
    return hud;
}

+ (MBProgressHUD *)showLoadToView:(UIView *)view
                     contentColor:(UIColor *)contentColor
                  backgroundColor:(UIColor *)backgroundColor
                            title:(NSString *)title {
    
    MBProgressHUD *hud = settHUD(view, title, NO);
    hud.contentColor = contentColor;
    hud.backgroundView.color = backgroundColor;
    
    return hud;
}


+ (MBProgressHUD *)showLoadToView:(UIView *)view
                       titleColor:(UIColor *)titleColor
                   bezelViewColor:(UIColor *)bezelViewColor
                  backgroundColor:(UIColor *)backgroundColor
                            title:(NSString *)title {
    
    MBProgressHUD *hud = settHUD(view, title, NO);
    hud.label.textColor = titleColor;
    hud.bezelView.backgroundColor = bezelViewColor;
    hud.backgroundView.color = backgroundColor;
    
    return hud;
}

+ (MBProgressHUD *)createHudToView:(UIView *)view title:(NSString *)title configHud:(NHCurrentHud)configHud {
    MBProgressHUD *hud = settHUD(view, title, YES);
    if (configHud) {
        configHud(hud);
    }
    return hud;
}

+ (void)hideHUDForView:(UIView *)view {
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:view animated:YES];
}


+ (void)hideHUD {
    [self hideHUDForView:nil];
}


#pragma mark -- sett // gett
+ (MBProgressHUD *)createNewHud:(void (^)(MBProgressHUD *))hudBlock {
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hudBlock(hud);
    return hud;
}

- (MBProgressHUD *(^)(UIColor *))hudBackgroundColor {
    return ^(UIColor *hudBackgroundColor) {
        self.backgroundView.color = hudBackgroundColor;
        return self;
    };
}


- (MBProgressHUD *(^)(UIView *))toView {
    return ^(UIView *view){
        return self;
    };
}


- (MBProgressHUD *(^)(NSString *))title {
    return ^(NSString *title){
        self.label.text = title;
        return self;
    };
}

- (MBProgressHUD *(^)(NSString *))customIcon {
    return ^(NSString *customIcon) {
        self.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:customIcon]];
        return self;
    };
}

- (MBProgressHUD *(^)(UIColor *))titleColor {
    return ^(UIColor *titleColor){
        self.label.textColor = titleColor;
        return self;
    };
}

- (MBProgressHUD *(^)(UIColor *))bezelBackgroundColor {
    return ^(UIColor *bezelViewColor){
        self.bezelView.backgroundColor = bezelViewColor;
        return self;
    };
}


- (MBProgressHUD *(^)(NHHUDContentStyle))hudContentStyle {
    return ^(NHHUDContentStyle hudContentStyle){
        if (hudContentStyle == NHHUDContentBlack) {
            self.bezelView.backgroundColor = [UIColor blackColor];
            self.contentColor = [UIColor whiteColor];
            
        } else if (hudContentStyle == NHHUDContentCustom) {
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
        return self;
    };
}


- (MBProgressHUD *(^)(NHHUDPostion))hudPostion {
    return ^(NHHUDPostion hudPostion){
        if (hudPostion == NHHUDPostionTop) {
            self.offset = CGPointMake(0.f, -MBProgressMaxOffset);
        } else if (hudPostion == NHHUDPostionCenten) {
            self.offset = CGPointMake(0.f, 0.f);
        } else {
            self.offset = CGPointMake(0.f, MBProgressMaxOffset);
        }
        return self;
    };
}

- (MBProgressHUD *(^)(NHHUDProgressStyle))hudProgressStyle {
    return ^(NHHUDProgressStyle hudProgressStyle){
        if (hudProgressStyle == NHHUDProgressDeterminate) {
            self.mode = MBProgressHUDModeDeterminate;
            
        } else if (hudProgressStyle == NHHUDProgressAnnularDeterminate) {
            self.mode = MBProgressHUDModeAnnularDeterminate;

        } else if (hudProgressStyle == NHHUDProgressCancelationDeterminate) {
            self.mode = MBProgressHUDModeDeterminate;

        } else if (hudProgressStyle == NHHUDProgressDeterminateHorizontalBar) {
            self.mode = MBProgressHUDModeDeterminateHorizontalBar;

        }
        return self;
    };
}

- (MBProgressHUD *(^)(NHCancelation))cancelation {
    return ^(NHCancelation cancelation) {
        objc_setAssociatedObject(self, &cancelationKey, cancelation, OBJC_ASSOCIATION_COPY);
//        objc_getAssociatedObject(self, &cancelationKey);
        return self;
    };
}
//
//- (void)setCancelation:(MBProgressHUD *(^)(NHCancelation))cancelation {
//    cancelation = ^(NHCancelation cancelation) {
//        objc_setAssociatedObject(self, &cancelationKey, cancelation, OBJC_ASSOCIATION_COPY);
//        return self;
//    };
//}

//- (void)setCancelation:(NHCancelation)cancelation {
//    
//}

//- (NHCancelation)cancelation {
//    return objc_getAssociatedObject(self, &cancelationKey);
//}

//- (void)setTitleColor:(UIColor *)titleColor {
//    self.label.textColor = titleColor;
//}
//
//- (void)setBezelViewColor:(UIColor *)bezelViewColor {
//    self.bezelView.backgroundColor = bezelViewColor;
//}


//- (void)setActiveBlock:(NHActiveBlock)activeBlock {
//    objc_setAssociatedObject(self, &activeBlockKey, activeBlock, OBJC_ASSOCIATION_COPY);
//}
//
//- (NHActiveBlock)activeBlock {
//    return objc_getAssociatedObject(self, &activeBlockKey);
//}

@end
