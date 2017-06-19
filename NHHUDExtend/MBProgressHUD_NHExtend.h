//
//  MBProgressHUD_NHExtend.h
//  NHHUDExtendDemo
//
//  Created by neghao on 2017/6/11.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger, NHHUDStyle) {
    NHHUDStyleDefault,//默认是白底黑字
    NHHUDStyleBlack,//黑底白字
    NHHUDStyleCustom,//:自定义风格<由自己设置自定义风格的颜色>
};

typedef NS_ENUM(NSInteger, NHHUDPostion) {
    NHHUDPostionTop,//上面
    NHHUDPostionCenten,//中间
    NHHUDPostionBottom,//下面
};
typedef void((^NHCancelation)(MBProgressHUD *hud));
typedef void((^NHActiveBlock)(id odj));

@interface MBProgressHUD ()
@property (nonatomic, assign) NHHUDStyle hudStyle;
@property (nonatomic, assign) NHHUDPostion hudPostion;
@property (nonatomic, copy) NHCancelation cancelation;
@property (nonatomic, copy) NHActiveBlock activeBlock;
@end
