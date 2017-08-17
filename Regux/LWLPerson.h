//
//  LWLPerson.h
//  Regux
//
//  Created by git on 2017/8/17.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWLPerson : NSObject

@property (nonatomic, strong) NSString *title;

-(instancetype)init;
- (void)changeTitle;
- (void)changeTitle2;

@end
