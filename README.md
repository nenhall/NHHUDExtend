基于 MBProgressHUD 的定制化封装，
使用方便、快捷，可能完全定制你自己需要的风格，支持链式语法；
产品需求变幻莫测，昨天还是要白色的提示框风格，今天就变成了黑色或者其它颜色，出现位置要在上面/下面，这时你使用这个类扩展完全能满足你的需求；

#### 本库的特点：

* 显示位置自定制(默认是在中间)；
* 文字颜色自定制，也可能一劳永逸设置全局属性；
* 加载进度条多种风格，进度条颜色可自定制；
* 持续显示时间一键设置，也可自定义单条的持续时间；
* 背景蒙版：要或者不要，背景颜色；
* 支持链式语法；
* 项目中难免会有几个界面的提示框需求特别，这时你可以使用链式语法来全方面的定制风格；

<br />

##### 全局配置：
###### MBProgressHUD+NHAdd.h
>注意点：
>##### 1，所有类方法中有返回本类的，则不会自动消失，返回值为void的都会自动消失(默认值:delayTime)
>##### 2，蒙层默认为清除色，给`hudBackgroundColor`设置颜色就会自动有

/

>//持续显示时间设置(默认1.2s)：
>UIKIT_EXTERN CGFloat const delayTime;

/
 
>/**设置默认的风格：默认为淡灰白色背景 = 0，文字及加载图颜色为黑色
>*  NHHUDContentDefaultStyle = 0,//默认是白底黑字 Default
>*  NHHUDContentBlackStyle = 1,//黑底白字
>*  NHHUDContentCustomStyle = 2,
>*/
> 如果你的项目大部份需要的是“黑底白字”风格，那么你将下属性改成1，如果0和1都不是，那么请‘NHDefaultHudStyle’设置为2，并同时设置下面两个颜色属性宏:`NHCustomHudStyleBackgrandColor 、 NHCustomHudStyleContentColor`。
>/#define NHDefaultHudStyle  1

/

>风格为自定义时(NHHUDContentCustomStyle)，在这里设置颜色
 >//背景颜色
>\#define NHCustomHudStyleBackgrandColor  [UIColor colorWithWhite:0.f alpha:0.7f]
>// 文字、加载图、进度条颜色
>\#define NHCustomHudStyleContentColor    [UIColor colorWithWhite:1.f alpha:0.7f]


```
//内容风格
typedef NS_ENUM(NSInteger, NHHUDContentStyle) {
    NHHUDContentDefaultStyle = 0,//默认是白底黑字 Default
    NHHUDContentBlackStyle = 1,//黑底白字
    NHHUDContentCustomStyle = 2,//:自定义风格<由自己设置自定义风格的颜色>
};

//显示位置
typedef NS_ENUM(NSInteger, NHHUDPostion) {
    NHHUDPostionTop,//上面
    NHHUDPostionCenten,//中间
    NHHUDPostionBottom,//下面
};

//进度条类型
typedef NS_ENUM(NSInteger, NHHUDProgressStyle) {
    NHHUDProgressDeterminate,///双圆环,进度环包在内
    NHHUDProgressDeterminateHorizontalBar,///横向Bar的进度条
    NHHUDProgressAnnularDeterminate,///双圆环，完全重合
    NHHUDProgressCancelationDeterminate,///带取消按钮 - 双圆环 - 完全重合
};
```
![](https://github.com/neghao/NHHUDExtend/blob/master/NHHUDExtend.gif)
##### 示例方法
```
/**
 纯加载图
 */
+ (MBProgressHUD *)showOnlyLoadToView:(UIView *)view;

/**
 纯文字
 */
+ (void)showOnlyTextToView:(UIView *)view title:(NSString *)title;

/**
 *  成功提示 - 自动消失，带默认成功图
 *
 *  @param success 要显示的文字
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

/**
 *  错误提示 - 自动消失, 带默认错误图
 *
 *  @param error 要显示的错误文字
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;

/**
 纯文字+自定位置(上、中、下) - 自动消失
 @param postion 位置：上、中、下
 */
+ (void)showTitleToView:(UIView *)view postion:(NHHUDPostion)postion title:(NSString *)title;

/**
 纯文字+自定背景风格 - 自动消失
 
 @param contentStyle 背景风格：白、黑
 */
+ (void)showTitleToView:(UIView *)view contentStyle:(NHHUDContentStyle)contentStyle title:(NSString *)title;


/**
 纯标题 + 详情 + 自定背景风格 - 自动消失
 
 @param contentStyle 背景风格：白、黑
 */
+ (void)showDetailToView:(UIView *)view contentStyle:(NHHUDContentStyle)contentStyle title:(NSString *)title detail:(NSString *)detail;


/**
 纯文字+自定位置、风格 - 自动消失
 
 @param postion 位置
 @param contentStyle 风格
 */
+ (void)showTitleToView:(UIView *)view
                postion:(NHHUDPostion)postion
           contentStyle:(NHHUDContentStyle)contentStyle
                  title:(NSString *)title;


/**
 文字+加载图
 */
+ (MBProgressHUD *)showLoadToView:(UIView *)view title:(NSString *)title;



/**
 纯文字+自定位置 x秒后自动消失
 
 @param delay 延迟消失时间
 */
+ (void)showTitleToView:(UIView *)view
           contentStyle:(NHHUDContentStyle)contentStyle
                  title:(NSString *)title
             afterDelay:(NSTimeInterval)delay;


/**
 文字 + 进度条
 
 @param progressStyle 进度条风格
 @param progress 当前进度值
 */
+ (MBProgressHUD *)showDownToView:(UIView *)view
                    progressStyle:(NHHUDProgressStyle)progressStyle
                            title:(NSString *)title
                         progress:(NHCurrentHud)progress;


/**
 文字 + 进度条 + 取消按钮
 
 @param progressStyle 进度条风格
 @param progress 当前进度值
 @param cancelTitle 取消按钮名称
 @param cancelation 取消按钮的点击事件
 */
+ (MBProgressHUD *)showCancelationToView:(UIView *)view
                           progressStyle:(NHHUDProgressStyle)progressStyle
                                   title:(NSString *)title
                             cancelTitle:(NSString *)cancelTitle
                                progress:(NHCurrentHud)progress
                             cancelation:(NHCancelation)cancelation;


/**
 文字 + 自定图片
 @param image 图片
 */
+ (void)showCustomView:(UIImage *)image toView:(UIView *)toView title:(NSString *)title;


/**
 文字 + 默认加载图 + 自定朦胧层背景色
 
 @param backgroundColor 自定背景色
 */
+ (MBProgressHUD *)showLoadToView:(UIView *)view backgroundColor:(UIColor *)backgroundColor title:(NSString *)title;


/**
 文字 + 默认加载图 + 自定文字、加载图颜色
 
 @param contentColor 自定文字、加载图颜色
 */
+ (MBProgressHUD *)showLoadToView:(UIView *)view contentColor:(UIColor *)contentColor title:(NSString *)title;
```

#### 使用方法示例：
```
//只有文字，显示位置在下面
[MBProgressHUD showTitleToView:self.view postion:NHHUDPostionBottom title:_listTitle[row]];

//只有文字，显示位置在上面，黑色风格
[MBProgressHUD showTitleToView:self.navigationController.view postion:NHHUDPostionTop contentStyle:NHHUDContentBlackStyle title:_listTitle[row]];

//带取消按钮的下载进度提示
[MBProgressHUD showCancelationToView:self.view progressStyle:NHHUDProgressDeterminate title:_listTitle[row] cancelTitle:@"cancel" progress:^(MBProgressHUD *hud) {
dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    [self doSomeWorkWithProgress:hud];
            dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                    });
                });
            } cancelation:^(MBProgressHUD *hud) {
                [self cancelDown:hud];
            }];
            
//自定义图片
[MBProgressHUD showCustomView:[[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                   toView:self.view
                                    title:@"Done"];
                                    
//自定制NSProgress
NSProgress *progressObject = [NSProgress progressWithTotalUnitCount:100];
[MBProgressHUD  showDeterminateWithNSProgress:progressObject toView:self.view title:_listTitle[16] hudBlock:^(MBProgressHUD *hud) {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    // Do something useful in the background and update the HUD periodically.
                    [self doSomeWorkWithProgressObject:hud.progressObject];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                    });
                });
            }];
            
//使用链式语法完全定制
[MBProgressHUD createHudToView:self.navigationController.view title:_listTitle[row] configHud:^(MBProgressHUD *hud) {
                hud.title(@"new title");
                hud.contentColor = [UIColor yellowColor];
                hud.titleColor(UIColor.redColor);
                hud.bezelBackgroundColor(UIColor.greenColor);
                hud.hudBackgroundColor([[UIColor blueColor] colorWithAlphaComponent:0.2]);
            }];
```

            

