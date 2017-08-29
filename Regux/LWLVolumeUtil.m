//
//  LWLVolumeUtil.m
//  Regux
//
//  Created by git on 2017/8/29.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import "LWLVolumeUtil.h"
#import "AppDelegate.h"

static LWLVolumeUtil *v_instance = nil;
@interface LWLVolumeUtil()
{
    CGFloat _oldVolumeValue;
    CGFloat _newVolumeValue;
}
@property (nonatomic, strong) MPVolumeView *volumeView;

@end
@implementation LWLVolumeUtil

+ (LWLVolumeUtil *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        v_instance = [[LWLVolumeUtil alloc]init];
    });
    return v_instance;
}
-(instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
-(MPVolumeView *)volumeView {
    if (!_volumeView) {
        _volumeView = [[MPVolumeView alloc]initWithFrame:CGRectMake(-20, -20, 10, 10)];
        _volumeView.hidden = NO;
    }
    return _volumeView;
}
//将MPVolumeView添加到界面上，获取初始音量值
- (void)loadVolumeView:(UIView *)view {
    [view addSubview:self.volumeView];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:NULL];
    _oldVolumeValue = [[AVAudioSession sharedInstance] outputVolume];
    //[[AVAudioSession sharedInstance] outputVolume];
}
//这种方式获取的初始音量值为0，暂不使用
- (CGFloat)getCurrentVolumeValue {
    UISlider *volumeViewSlider;
    for (UIView *view in [self.volumeView subviews]) {
        if ([[[view class] description] isEqualToString:@"MPVolumeSlider"]) {
            volumeViewSlider = (UISlider *)view;
        }
    }
    return volumeViewSlider.value;
}
- (void)registerVolumeNotification {
    NSError *error;
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}
- (void)volumeChanged:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"AVSystemController_SystemVolumeDidChangeNotification"]) {
        NSDictionary *userInfo = notification.userInfo;
        //AVSystemController_UserVolumeAboveEUVolumeLimitNotificationParameter
        //AVSystemController_AudioCategoryNotificationParameter
        CGFloat volume = [userInfo[@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
        _newVolumeValue = volume;
        NSString *reasonStr = userInfo[@"AVSystemController_AudioVolumeChangeReasonNotificationParameter"];
        if ([reasonStr isEqualToString:@"ExplicitVolumeChange"]) {
            
            if (_newVolumeValue > _oldVolumeValue || _newVolumeValue == 1) {
                NSLog(@"ExplicitVolumeChange+");
            }
            if (_newVolumeValue < _oldVolumeValue || _newVolumeValue == 0) {
                NSLog(@"ExplicitVolumeChange_");
            }
            _oldVolumeValue = _newVolumeValue;
        }
    }
}
- (void)removeVolumeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
}

@end
