//
//  HideAlert.m
//  Regux
//
//  Created by git on 2017/9/4.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import "HideAlert.h"

@implementation HideAlert

-(void)hideAlert {
    if ([self.delegate respondsToSelector:@selector(hideAlertNotification)]) {
        [self.delegate hideAlertNotification];
    }
}

@end
