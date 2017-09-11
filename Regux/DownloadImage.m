//
//  DownloadImage.m
//  Regux
//
//  Created by git on 2017/8/31.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import "DownloadImage.h"

#define CachedImageFile(url) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[url lastPathComponent]]

@interface DownloadImage()

@property (nonatomic, strong) NSMutableDictionary *images;
@property (nonatomic, strong) NSMutableDictionary *operations;
@property (nonatomic, strong) NSOperationQueue *queue;
@end

static NSString *dowmloadImgLock = @"DownloadImageLock";
static DownloadImage *s_instance;
@implementation DownloadImage

+ (DownloadImage *)shareInstanceDownload {
    @synchronized (dowmloadImgLock) {
        if (!s_instance) {
            s_instance = [[DownloadImage alloc]init];
        }
        return s_instance;
    }
}

-(instancetype)init {
    if (self = [super init]) {
        self.queue = [[NSOperationQueue alloc]init];
    }
    return self;
}

-(UIImage *)downloadImageWithUrl:(NSString *)urlStr {
    UIImage *image = self.images[urlStr];
    if (image) {
        
    } else {
        NSString *filePath = CachedImageFile(urlStr);
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (data) {
            image = [UIImage imageWithData:data];
        } else {
            image = [UIImage imageNamed:@"placeholder"];
            [self downloadImg:urlStr];
        }
    }
    return image;
}

- (void)downloadImg:(NSString *)urlStr {
    
    NSBlockOperation *operation = self.operations[urlStr];
    if (operation) {
        return;
    }
    operation = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:urlStr];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (image) {
                self.images[urlStr] = image;
                NSData *data = UIImagePNGRepresentation(image);
                [data writeToFile:CachedImageFile(urlStr) atomically:YES];
            }
            [self.operations removeObjectForKey:urlStr];
            
            if (_delegate && [_delegate respondsToSelector:@selector(onFinishedWithImg:)]) {
                [_delegate onFinishedWithImg:image];
            }
            //refresh
            // 刷新当前表格，减少系统开销
            //[appsVc.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }];
    [self.queue addOperation:operation];
    self.operations[urlStr] = operation;
}



@end
