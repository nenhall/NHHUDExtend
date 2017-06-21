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
                   @"Auto Hidden Only Text - Bottom",
                   @"Auto Hidden Only Text - Top",
                   @"Only Load View",
                   @"Load And Title",
                   @"Down Annular Determinate",
                   @"Down Cancelation Determinate",
                   @"Determinate Model",
                   @"Bar Determinate",
                   @"Custom Load View",
                   @"Mode Switching Auto Change",
                   @"Networking Request/down",
                   @"Determinate NSProgress",
                   @"DimBackground",
                   @"Custom Content View Color",
                   @"Custom Load And Title Color"
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
    
#warning 在实际使用中 MBProgressHUD Block 内需要弱化self的地方，请自行添加，这里只为了演示使用方法，未做处理

    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
            [MBProgressHUD showToView:self.view postion:NHHUDPostionBottom title:@"我在这里你知道吗？？"];
            break;
        case 1:
            [MBProgressHUD showToView:self.navigationController.view postion:NHHUDPostionTop style:NHHUDStyleDefault title:@"我在这里你知道吗？"];
            break;
            
        case 2:
            [MBProgressHUD showLoadToView:self.view title:nil];
            break;
        
        case 3:
            [MBProgressHUD showLoadToView:self.view title:@"loading"];

            break;
            
        case 4: {
            [MBProgressHUD showAnnularDeterminateToView:self.view title:@"loading" progress:^(MBProgressHUD *hud) {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    [self doSomeWorkWithProgress:hud];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                    });
                });
            }];
        }
            break;
            
        case 5: {
            [MBProgressHUD showCancelationDeterminateToView:self.view title:@"loading" cancelTitle:@"cancel" progress:^(MBProgressHUD *hud) {
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

        case 6: {
            [MBProgressHUD showDeterminateToView:self.view title:@"loading" progress:^(MBProgressHUD *hud) {
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
            [MBProgressHUD showBarDeterminateToView:self.view title:@"loading" progress:^(MBProgressHUD *hud) {
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
            [MBProgressHUD showCustomView:[[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                   toView:self.view
                                    title:@"Done"];
        }
            break;
            
        case 9: {
            [MBProgressHUD showModelSwitchingToView:self.view title:@"Preparing..." hudBlock:^(MBProgressHUD *hud) {
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
            
        case 10: {
            [MBProgressHUD  showNetworkingNSProgressToView:self.view title:@"loading..."];
            [self doSomeNetworkWorkWithProgress];
        }
            break;
            
        case 11: {
            // Set up NSProgress
            NSProgress *progressObject = [NSProgress progressWithTotalUnitCount:100];
            [MBProgressHUD  showDeterminateWithNSProgress:progressObject toView:self.view title:@"loading..." hudBlock:^(MBProgressHUD *hud) {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    // Do something useful in the background and update the HUD periodically.
                    [self doSomeWorkWithProgressObject:hud.progressObject];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                    });
                });
            }];
            [self doSomeNetworkWorkWithProgress];
        }
            break;
            
        case 12: {
            MBProgressHUD *hud = [MBProgressHUD showLoadToView:self.navigationController.view
                                               backgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]
                                                         title:@"loading..."];
            [self autoHiddenHud:hud];
        }
            break;
            
        case 13: {
          MBProgressHUD *hud = [MBProgressHUD showLoadToView:self.view
                             contentColor:[UIColor redColor]
                                    title:@"loading..."];
            [self autoHiddenHud:hud];
        }
            break;
            
        case 14: {
            [MBProgressHUD showLoadToView:self.view
                             contentColor:[UIColor redColor]
                          backgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]
                                    title:@"loading..."];
            
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
    
#ifdef DEBUG 
    NSString *meg = @"切换到release模式后重新运行就即可,或者手动修改宏：\nNHDefaultHudStyle = 1";
#else
    NSString *meg = @"切换到Debu模式后重新运行就即可，或者手动修改宏：\nNHDefaultHudStyle = 0";
#endif
    
    [[[UIAlertView alloc] initWithTitle:@"提示"
                                message:meg
                               delegate:self
                      cancelButtonTitle:@"确定"
                      otherButtonTitles:nil, nil] show];
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

- (void)doSomeNetworkWorkWithProgress {
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    NSURL *URL = [NSURL URLWithString:@"https://support.apple.com/library/APPLE/APPLECARE_ALLGEOS/HT1425/sample_iPod.m4v.zip"];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:URL];
    [task resume];
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
