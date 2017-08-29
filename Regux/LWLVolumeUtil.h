//
//  LWLVolumeUtil.h
//  Regux
//
//  Created by git on 2017/8/29.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFAudio.h>
#import <MediaPlayer/MediaPlayer.h>

@interface LWLVolumeUtil : NSObject

+ (LWLVolumeUtil *)shareInstance;
- (void)loadVolumeView:(UIView *)view;
- (void)registerVolumeNotification;
- (void)removeVolumeNotification;

@end
