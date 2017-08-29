//
//  LWLPerson+Eat.m
//  Regux
//
//  Created by git on 2017/8/26.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import "LWLPerson+Eat.h"
#import <objc/runtime.h>

@implementation LWLPerson (Eat)

static char foodNameKey;
-(void)setFoodName:(NSString *)foodName {
    objc_setAssociatedObject(self, &foodNameKey, foodName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)foodName {
    return objc_getAssociatedObject(self, &foodNameKey);
}

-(void)eatFood {
    NSLog(@"Category:fruits");
}

@end
