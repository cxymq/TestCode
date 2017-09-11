//
//  WQQViewController.m
//  Regux
//
//  Created by git on 2017/9/4.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import "WQQViewController.h"
#import "LWLAlertViewController.h"
#import "HideAlert.h"
#import "WQQ2ViewController.h"

@interface WQQViewController ()

@end

@implementation WQQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self test8];//global alert and hide it
    
    UIViewController *vca = [UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController;
    UIViewController *vcb = [UIApplication sharedApplication].keyWindow.rootViewController.presentingViewController;
    sleep(3);
    WQQ2ViewController *vc = [[WQQ2ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}
- (void)test8 {
    
    LWLAlertViewController *alertVc = [[LWLAlertViewController alloc]initWithTitle:@"西西生活" message:@"消息新通知" alertStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertVc addAlertAction:okAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
