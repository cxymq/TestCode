//
//  ViewController.m
//  Regux
//
//  Created by git on 2017/8/12.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import "ViewController.h"
#import "CryptorModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self test1];//test Regux
    [self test2];//base64 DES
}

- (void)test2 {
    NSString *pwd = @"12345678";
    NSString *key = @"b005cdb3";
    NSString *serectPwd = [CryptorModel encryptUseDES:pwd key:key];
    NSString *base64SerectPwd = [CryptorModel base64StringFromText:serectPwd];
    NSLog(@"base64SerectPwd=%@",base64SerectPwd);
    
    NSString *unbase64SerectPwd = [CryptorModel textFromBase64String:base64SerectPwd];
    NSString *unSerectPwd = [CryptorModel decryptUseDES:unbase64SerectPwd key:key];
    NSLog(@"unSerectPwd=%@",unSerectPwd);
}
- (void)test1 {
    NSString *str = @"wqe1244sdf34884";
    NSString *regular = @"[0-9]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regular];
    if ([predicate evaluateWithObject:str]) {
        NSLog(@"str Match");
    }else {
        NSLog(@"str NotMatch");
    }
    
    NSString *str2 = @"name=mikey==";
    NSError *err;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\s]+[=][^\\s]+" options:0 error:&err];
    if (regex != nil) {
        NSTextCheckingResult *firstMarch = [regex firstMatchInString:str2 options:0 range:NSMakeRange(0, str2.length)];
        if (firstMarch) {
            NSRange resultRange = [firstMarch rangeAtIndex:0];
            NSString *result = [str2 substringWithRange:resultRange];
            NSLog(@"(result = )%@",result);
        }
    }
    
    NSString *tmpStr = @"asd3=412==34aaa=accd";
    
    NSRange range;
    
    range = [tmpStr rangeOfString:@"="];
    
    if (range.location != NSNotFound) {
        
        NSLog(@"found at location = %lu, length = %lu",(unsigned long)range.location,(unsigned long)range.length);
        
        NSString *ok = [tmpStr substringFromIndex:range.location];
        
        NSLog(@"%@",ok);
        
    }else{  
        
        NSLog(@"Not Found");  
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
