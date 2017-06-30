//
//  MBProgressHUD_NHExtend.h
//  NHHUDExtendDemo
//
//  Created by neghao on 2017/6/11.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger, NHHUDContentStyle) {
    NHHUDContentWhiteBackground,//默认是白底黑字 Default
    NHHUDContentBlack,//黑底白字
    NHHUDContentCustom,//:自定义风格<由自己设置自定义风格的颜色>
};

typedef NS_ENUM(NSInteger, NHHUDPostion) {
    NHHUDPostionTop,//上面
    NHHUDPostionCenten,//中间
    NHHUDPostionBottom,//下面
};

typedef NS_ENUM(NSInteger, NHHUDProgressStyle) {
    NHHUDProgressDeterminate,///双圆环,进度环包在内
    NHHUDProgressDeterminateHorizontalBar,///横向Bar的进度条
    NHHUDProgressAnnularDeterminate,///双圆环，完全重合
    NHHUDProgressCancelationDeterminate,///带取消按钮 - 双圆环 - 完全重合
};


typedef void((^NHCancelation)(MBProgressHUD *hud));

@interface MBProgressHUD ()
@property (nonatomic, assign) NHHUDContentStyle hudContentStyle;
@property (nonatomic, assign) NHHUDPostion hudPostion;
@property (nonatomic, assign) NHHUDProgressStyle hudProgressStyle;
@property (nonatomic, copy) NHCancelation cancelation;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *bezelViewColor;

@end
