//
//  HideAlert.h
//  Regux
//
//  Created by git on 2017/9/4.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HideAlertDelegate <NSObject>

- (void)hideAlertNotification;

@end

@interface HideAlert : NSObject

@property (nonatomic, weak) id<HideAlertDelegate> delegate;

- (void)hideAlert;

@end
