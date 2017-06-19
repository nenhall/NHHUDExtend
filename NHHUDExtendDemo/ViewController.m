//
//  ViewController.m
//  NHHUDExtendDemo
//
//  Created by neghao on 2017/6/9.
//  Copyright © 2017年 neghao. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+NHAdd.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
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
                   @"Mode Switching Auto Change"
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
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
            [MBProgressHUD showTitle:@"我在这里你知道吗？？" toView:self.view postion:NHHUDPostionBottom];
            break;
        case 1:
            [MBProgressHUD showTitle:@"我在这里你知道吗？？" toView:self.navigationController.view postion:NHHUDPostionTop style:NHHUDStyleDefault];
            break;
            
        case 2:
            [MBProgressHUD showLoadTitle:nil toView:self.view];
            break;
        
        case 3:
            [MBProgressHUD showLoadTitle:@"loading" toView:self.view];
            break;
            
        case 4: {
            [MBProgressHUD showAnnularDeterminateTitle:@"下载中..." toView:self.view progress:^(MBProgressHUD *hud) {
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
                [hud hideAnimated:YES];
            }];
        }
            break;

        case 6: {
            [MBProgressHUD showDeterminateTitle:@"loading" toView:self.view progress:^(MBProgressHUD *hud) {
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
            [MBProgressHUD showBarDeterminateTitle:@"loading" toView:self.view progress:^(MBProgressHUD *hud) {
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
            [MBProgressHUD showCustomView:[[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] toView:self.view title:@"Done"];
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
        default:
            break;
    }
}


- (IBAction)rightItemAction:(UIBarButtonItem *)sender {
    [MBProgressHUD hideHUDForView:self.view];
}


- (IBAction)leftItemAction:(UIBarButtonItem *)sender {
    
}


- (void)cancelDown:(MBProgressHUD *)hub {

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

@end
