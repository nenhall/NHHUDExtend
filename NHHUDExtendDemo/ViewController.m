//
//  ViewController.m
//  NHHUDExtendDemo
//
//  Created by neghao on 2017/6/9.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+NHAdd.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *listTitle;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _listTitle = @[
                   @"Only Text - Bottom",
                   @"Only Text - Top DefaultStyle",
                   @"Only Load View",
                   @"Load And Title",
                   @"AfterDelay：10 AutoHidden",
                   @"Only Text Detail",
                   @"Down Determinate Model",
                   @"Down Bar Determinate",
                   @"Down Cancelation Determinate",
                   @"Custom Down Cancelation",
                   @"Custom Load View",
                   @"Determinate NSProgress",
                   @"DimBackground",
                   @"Custom Content View Color",
                   @"Custom Load 、Title 、Background Color",
                   @"Mode Switching Auto Change",
                   @"Networking Request/down",
                   @"Only Text And DetailTitle - Bottom",
                   @"Fully Customized HUD",
                   ];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listTitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [_listTitle objectAtIndex:indexPath.row];

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
#warning 在实际使用中 MBProgressHUD Block 内有需要弱化self的地方，请自行添加，这里只为了演示使用方法，未做处理

    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
            [MBProgressHUD showTitleToView:self.view postion:NHHUDPostionBottom title:_listTitle[row]];
            break;
            
        case 1:
            [MBProgressHUD showTitleToView:self.navigationController.view
                                   postion:NHHUDPostionTop
                              contentStyle:NHHUDContentDefaultStyle
                                     title:_listTitle[row]];
            break;
            
        case 2:
            [MBProgressHUD showOnlyLoadToView:self.view];
            break;
        
        case 3:
            [MBProgressHUD showLoadToView:self.view title:_listTitle[row]];
            break;
            
        case 4: {
            [MBProgressHUD showTitleToView:self.view contentStyle:NHHUDContentDefaultStyle title:_listTitle[row] afterDelay:10];
        }
            break;
            
        case 5: {
            [MBProgressHUD showOnlyTextToView:self.view title:@"the is title" detail:@"the is detail,the is detail,the is detail"];
        }
            break;
            
        case 6: {
            [MBProgressHUD showDownToView:self.view progressStyle:NHHUDProgressDeterminate title:_listTitle[row] progress:^(MBProgressHUD *hud) {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    [self doSomeWorkWithProgress:hud];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                    });
                });
            }];
        }
            break;
            
        case 7: {
            [MBProgressHUD showDownToView:self.view progressStyle:NHHUDProgressDeterminateHorizontalBar title:_listTitle[row] progress:^(MBProgressHUD *hud) {
                hud.allContentColors([UIColor yellowColor]);
                hud.progressColor([UIColor whiteColor]);
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    [self doSomeWorkWithProgress:hud];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                    });
                });
            }];
        }
            break;
            
        case 8: {
            [MBProgressHUD showDownToView:self.view progressStyle:NHHUDProgressDeterminate title:_listTitle[row] cancelTitle:@"cancel" progress:^(MBProgressHUD *hud) {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    [self doSomeWorkWithProgress:hud];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                    });
                });
            } cancelation:^(MBProgressHUD *hud) {
                [self cancelDown:hud];
            }];
        }
            break;
            
        case 9: {
            [MBProgressHUD showDownToView:self.view progressStyle:NHHUDProgressDeterminateHorizontalBar title:_listTitle[row] cancelTitle:@"cancel" progress:^(MBProgressHUD *hud) {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    [self doSomeWorkWithProgress:hud];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                    });
                });
            } cancelation:^(MBProgressHUD *hud) {
                [self cancelDown:hud];
            }];
        }
            break;
            
        case 10: {
            [MBProgressHUD showCustomView:[[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                   toView:self.view
                                    title:@"Done"];
        }
            break;
            
        case 11: {
            [MBProgressHUD showModelSwitchToView:self.view title:@"Preparing..." configHud:^(MBProgressHUD *hud) {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    // Do something useful in the background and update the HUD periodically.
                    [self doSomeWorkWithMixedProgress:hud];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                    });
                });
            }];
        }
            break;
            
        case 12: {
            MBProgressHUD *hud = [MBProgressHUD showLoadToView:self.navigationController.view
                                               backgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]
                                                         title:_listTitle[row]];
            [self autoHiddenHud:hud];
        }
            break;
            
        case 13: {
            MBProgressHUD *hud = [MBProgressHUD showLoadToView:self.view
                                                  contentColor:[UIColor redColor]
                                                         title:_listTitle[row]];
            [self autoHiddenHud:hud];
        }
            break;
            
        case 14: {
            [MBProgressHUD showLoadToView:self.view
                               titleColor:[UIColor lightGrayColor]
                           bezelViewColor:[UIColor purpleColor]
                          backgroundColor:[[UIColor yellowColor] colorWithAlphaComponent:0.5]
                                    title:_listTitle[row]];
        }
            break;
            
        case 15: {
            [MBProgressHUD showModelSwitchToView:self.view title:@"Preparing..." configHud:^(MBProgressHUD *hud) {
                [self doSomeNetworkWorkWithProgress];
            }];
        }
            break;
            
        case 16: {
            NSProgress *progressObject = [NSProgress progressWithTotalUnitCount:100];
            [MBProgressHUD  showDownWithNSProgress:progressObject toView:self.view title:_listTitle[16] configHud:^(MBProgressHUD *hud) {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    [self doSomeWorkWithProgressObject:hud.progressObject];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                    });
                });
            }];
            [self doSomeNetworkWorkWithProgress];
        }
            break;
            
            case 17:{
                [MBProgressHUD showDetailToView:self.view postion:NHHUDPostionBottom title:@"title" detail:_listTitle[row]];
        }
            break;
            
        case 18:{
            [MBProgressHUD createHudToView:self.navigationController.view title:_listTitle[row] configHud:^(MBProgressHUD *hud) {
                hud.title(@"new title");
                hud.contentColor = [UIColor yellowColor];
                hud.titleColor(UIColor.redColor);
                hud.bezelBackgroundColor(UIColor.greenColor);
                hud.hudBackgroundColor([[UIColor blueColor] colorWithAlphaComponent:0.2]);
            }];
        }
            break;
        default:
            break;
    }
}


- (IBAction)rightItemAction:(UIBarButtonItem *)sender {
    [MBProgressHUD hideHUDForView:self.view];
}


- (IBAction)leftItemAction:(UIBarButtonItem *)sender {
    NSString *meg = @"改变 MBProgressHUD+NHAdd.h\n  中的 NHDefaultHudStyle的值";
    [MBProgressHUD showDetailToView:self.view postion:NHHUDPostionCenten title:@"风格切换" detail:meg];
}


- (void)cancelDown:(MBProgressHUD *)hud {
    [hud hideAnimated:YES];
    NSLog(@"点击了取消");
}


- (void)autoHiddenHud:(MBProgressHUD *)hud {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomeWorkWithProgress:hud];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    });
}

- (void)doSomeWorkWithProgressObject:(NSProgress *)progressObject {
    // This just increases the progress indicator in a loop.
    while (progressObject.fractionCompleted < 1.0f) {
        if (progressObject.isCancelled) break;
        [progressObject becomeCurrentWithPendingUnitCount:1];
        [progressObject resignCurrent];
        usleep(50000);
    }
}


- (void)doSomeWorkWithProgress:(MBProgressHUD *)hub {
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        dispatch_async(dispatch_get_main_queue(), ^{
            hub.progress = progress;
        });
        usleep(50000);
    }
}

- (void)doSomeWorkWithMixedProgress:(MBProgressHUD *)hud {
    // Indeterminate mode
    sleep(2);
    // Switch to determinate mode
    dispatch_async(dispatch_get_main_queue(), ^{
        hud.mode = MBProgressHUDModeDeterminate;
        hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    });
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        dispatch_async(dispatch_get_main_queue(), ^{
            hud.progress = progress;
        });
        usleep(50000);
    }
    // Back to indeterminate mode
    dispatch_async(dispatch_get_main_queue(), ^{
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = NSLocalizedString(@"Cleaning up...", @"HUD cleanining up title");
    });
    sleep(2);
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        hud.customView = imageView;
        hud.mode = MBProgressHUDModeCustomView;
        hud.label.text = NSLocalizedString(@"Completed", @"HUD completed title");
    });
    sleep(2);
}

- (void)doSomeNetworkWorkWithProgress {
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    NSURL *URL = [NSURL URLWithString:@"https://support.apple.com/library/APPLE/APPLECARE_ALLGEOS/HT1425/sample_iPod.m4v.zip"];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:URL];
    [task resume];
}

#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    // Do something with the data at location...
    
    // Update the UI on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
        UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        hud.customView = imageView;
        hud.mode = MBProgressHUDModeCustomView;
        hud.label.text = NSLocalizedString(@"Completed", @"HUD completed title");
        [hud hideAnimated:YES afterDelay:3.f];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    float progress = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
    
    // Update the UI on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
        hud.mode = MBProgressHUDModeDeterminate;
        hud.progress = progress;
    });
}

@end
