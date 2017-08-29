//
//  LWLPerson.m
//  Regux
//
//  Created by git on 2017/8/17.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import "LWLPerson.h"
#import <objc/runtime.h>

@implementation LWLPerson
-(instancetype)init {
    if (self = [super init]) {
        Method method = class_getInstanceMethod([self class], @selector(changeTitle));
        Method newMethod = class_getInstanceMethod([self class], @selector(changeTitle2));
        method_exchangeImplementations(method, newMethod);
    }
    return self;
}
- (void)changeTitle {
    self.title = @"John";
}
- (void)changeTitle2 {
    self.title = @"Machel";
}

@end
