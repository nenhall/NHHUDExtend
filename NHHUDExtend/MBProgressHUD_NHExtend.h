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
@property (nonatomic, copy  ) MBProgressHUD *(^cancelation)(NHCancelation cancelation);

@property (nonatomic, assign, readonly) MBProgressHUD *(^hudContentStyle)(NHHUDContentStyle hudContentStyle);
@property (nonatomic, assign, readonly) MBProgressHUD *(^hudPostion)(NHHUDPostion hudPostion);
@property (nonatomic, assign, readonly) MBProgressHUD *(^hudProgressStyle)(NHHUDProgressStyle hudProgressStyle);
@property (nonatomic, copy  , readonly) MBProgressHUD *(^title)(NSString *title);
@property (nonatomic, copy  , readonly) MBProgressHUD *(^customIcon)(NSString *customIcon);
@property (nonatomic, strong, readonly) MBProgressHUD * (^titleColor)(UIColor *titleColor);
@property (nonatomic, strong, readonly) MBProgressHUD *(^hudBackgroundColor)(UIColor *backgroundColor);
@property (nonatomic, strong, readonly) MBProgressHUD * (^bezelBackgroundColor)(UIColor *bezelBackgroundColor);







@end
