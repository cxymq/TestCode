//
//  LWLAlertViewController.h
//  Regux
//
//  Created by git on 2017/9/4.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LWLAlertViewController : NSObject

- (instancetype)initWithTitle:(NSString *)titile message:(NSString *)message alertStyle:(UIAlertControllerStyle)alertStyle;
- (void)addAlertAction:(UIAlertAction *)action;

@end
