//
//  DownloadImage.h
//  Regux
//
//  Created by git on 2017/8/31.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DownloadImageDelegate <NSObject>

- (void)onFinishedWithImg:(UIImage *)img;

@end

@interface DownloadImage : NSObject

@property (nonatomic, weak) id<DownloadImageDelegate> delegate;

+ (DownloadImage *)shareInstanceDownload;

- (UIImage *)downloadImageWithUrl:(NSString *)urlStr;

@end
