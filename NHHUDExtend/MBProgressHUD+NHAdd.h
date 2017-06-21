//
//  MBProgressHUD+NHAdd.h
//  NHHUDExtendDemo
//
//  Created by neghao on 2017/6/11.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "MBProgressHUD.h"
#import "MBProgressHUD_NHExtend.h"

//默认持续显示时间(x秒后消失)
UIKIT_EXTERN CGFloat const delayTime;

/** 设置默认的显示风格：
 * 0: 为MBProgressHUD默认的白底黑字风格（默认）
 * 1: 为黑底白字
 * 2: 自定义风格<设置 NHCustomHudStyleBackgrandColor 及 NHCustomHudStyleContentColor>
 * 修改这个值可以减少频繁的调用setHudStyle，
 * eg：设置为1时，调用任何这个扩展内的方法，显示出hud的UI效果都会为黑底白字风格
 * 这里为了展示使用的是release为黑色
 */
#ifdef DEBUG
#define NHDefaultHudStyle 0
#else
#define NHDefaultHudStyle 1
#endif

/**
 * 风格为自定义时，在这里设置颜色
 */
#define NHCustomHudStyleBackgrandColor  [UIColor colorWithWhite:0.f alpha:0.7f]
#define NHCustomHudStyleContentColor    [UIColor colorWithWhite:1.f alpha:0.7f]

typedef void((^NHDownProgress)(MBProgressHUD *hud));
typedef void((^NHCancelationssss)(MBProgressHUD *hud));


@interface MBProgressHUD (NHAdd)

+ (MBProgressHUD *)createNewHud:(void (^)(MBProgressHUD *hud))hudBlock;
- (MBProgressHUD *(^) (UIView *))toView;
- (MBProgressHUD *(^) (NSString *))title;
- (MBProgressHUD *(^) (NSString *))customIcon;


/**
 只有默认的加载示图
 */
+ (MBProgressHUD *)showOnlyLoadToView:(UIView *)view;


/**
 *  自动消失成功提示，带默认图
 *
 *  @param success 要显示的文字
 *  @param view    要添加的view
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

/**
 *  自动消失错误提示,带默认图
 *
 *  @param error 要显示的错误文字
 *  @param view  要添加的View
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;


/**
 *  文字+菊花提示,不自动消失
 *
 *  @param title 要显示的文字
 *  @param view    要添加的View
 */
+ (void)showToView:(UIView *)view title:(NSString *)title;

+ (void)showToView:(UIView *)view postion:(NHHUDPostion)postion title:(NSString *)title;

+ (void)showToView:(UIView *)view style:(NHHUDStyle)style title:(NSString *)title;

+ (void)showToView:(UIView *)view
            postion:(NHHUDPostion)postion
             style:(NHHUDStyle)style
             title:(NSString *)title;


+ (MBProgressHUD *)showLoadToView:(UIView *)view title:(NSString *)title;

+ (MBProgressHUD *)showDeterminateToView:(UIView *)view title:(NSString *)title progress:(NHDownProgress)progress;

+ (MBProgressHUD *)showAnnularDeterminateToView:(UIView *)view title:(NSString *)title progress:(NHDownProgress)progress;

+ (MBProgressHUD *)showBarDeterminateToView:(UIView *)view title:(NSString *)title progress:(NHDownProgress)progress;

+ (MBProgressHUD *)showCancelationDeterminateToView:(UIView *)view
                                              title:(NSString *)title
                                        cancelTitle:(NSString *)cancelTitle
                                           progress:(NHDownProgress)progress
                                        cancelation:(NHCancelation)cancelation;

+ (void)showCustomView:(UIImage *)image toView:(UIView *)toView title:(NSString *)title;

+ (void)showModelSwitchingToView:(UIView *)toView title:(NSString *)title hudBlock:(NHDownProgress)hudBlock;

+ (MBProgressHUD *)showNetworkingNSProgressToView:(UIView *)view title:(NSString *)title;

+ (MBProgressHUD *)showDeterminateWithNSProgress:(NSProgress *)Progress toView:(UIView *)view title:(NSString *)title hudBlock:(NHDownProgress)hudBlock;

+ (MBProgressHUD *)showLoadToView:(UIView *)view backgroundColor:(UIColor *)backgroundColor title:(NSString *)title;

+ (MBProgressHUD *)showLoadToView:(UIView *)view contentColor:(UIColor *)contentColor title:(NSString *)title;

+ (MBProgressHUD *)showLoadToView:(UIView *)view
                     contentColor:(UIColor *)contentColor
                  backgroundColor:(UIColor *)backgroundColor
                            title:(NSString *)title;



/**
 *  自定义图片的提示，x秒后自动消息
 *
 *  @param iconName 图片地址(建议不要太大的图片)
 *  @param title 要显示的文字
 *  @param view 要添加的view
 *  @param time 停留时间
 */
+ (void)showCustomIcon:(NSString *)iconName Title:(NSString *)title ToView:(UIView *)view RemainTime:(CGFloat)time;












/**
 *  快速显示一条提示信息
 *
 *  @param message 要显示的文字
 */
+ (void)showAutoMessage:(NSString *)message;


/**
 *  自动消失提示，无图
 *
 *  @param message 要显示的文字
 *  @param view    要添加的View
 */
+ (void)showAutoMessage:(NSString *)message ToView:(UIView *)view;


/**
 *  自定义停留时间，有图
 *
 *  @param message 要显示的文字
 *  @param view    要添加的View
 *  @param time    停留时间
 */
+(void)showIconMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time;


/**
 *  自定义停留时间，无图
 *
 *  @param message 要显示的文字
 *  @param view 要添加的View
 *  @param time 停留时间
 */
+(void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time;


/**
 *  加载视图
 *
 *  @param view 要添加的View
 */
+ (void)showLoadToView:(UIView *)view;


/**
 *  进度条View
 *
 *  @param view     要添加的View
 *  @param model    进度条的样式
 *  @param text     显示的文字
 *
 *  @return 返回使用
 */
+ (MBProgressHUD *)showProgressToView:(UIView *)view ProgressModel:(MBProgressHUDMode)model Text:(NSString *)text;


/**
 *  隐藏ProgressView
 *
 *  @param view superView
 */
+ (void)hideHUDForView:(UIView *)view;


/**
 *  快速从window中隐藏ProgressView
 */
+ (void)hideHUD;


@end
