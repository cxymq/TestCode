//
//  LWLAlertViewController.m
//  Regux
//
//  Created by git on 2017/9/4.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import "LWLAlertViewController.h"
#import "HideAlert.h"

@interface LWLAlertViewController()<HideAlertDelegate>
{
    UIAlertController *_alertVc;
}

@end

@implementation LWLAlertViewController

- (void)hideAlertNotification {
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (instancetype)initWithTitle:(NSString *)titile message:(NSString *)message alertStyle:(UIAlertControllerStyle)alertStyle {
    if (self = [super init]) {
        
        HideAlert *alert = [[HideAlert alloc]init];
        alert.delegate = self;
        
        _alertVc = [UIAlertController alertControllerWithTitle:titile message:message preferredStyle:alertStyle];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:_alertVc animated:YES completion:nil];
    }
    return self;
}
- (void)addAlertAction:(UIAlertAction *)action {
    [_alertVc addAction:action];
}

@end
