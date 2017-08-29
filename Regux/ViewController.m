//
//  ViewController.m
//  Regux
//
//  Created by git on 2017/8/12.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import "ViewController.h"
#import "CryptorModel.h"
#import "LWLPerson.h"
#import "LWLPerson+Eat.h"
#import "XMLParser.h"
#import "LWLVolumeUtil.h"


@interface ViewController ()

{
    CGFloat _oldVolume;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self test1];//test Regux
    //[self test2];//base64 DES
    //[self test3];//test 16 chratate
    //[self test4];//test class_method
    //[self test5];//test xml parse
    //[self test6];//test after crashed,get logs from iphone
    [self test7];//test control volume keys
}

- (void)test7 {
    [[LWLVolumeUtil shareInstance] loadVolumeView:self.view];
    [[LWLVolumeUtil shareInstance] removeVolumeNotification];
    [[LWLVolumeUtil shareInstance] registerVolumeNotification];
}


- (void)test6 {
    NSArray *arr = @[@"1",@"2"];
    NSLog(@"%@",[arr objectAtIndex:6]);
}
- (void)test5 {
    NSString *xml = @"<buddy ver=\"1502697089457\" name=\"西西科技大管家1\" type=\"BM\" id=\"90416dcbdc2b\" mainType=\"SERVICE\">\
    <menu id=\"1587657524438178\" name=\"演示房间1\" >\
        <light id=\"1587657524438178_1\" name=\"客卧灯\"/>\
        <light id=\"1587657524438178_2\" name=\"客卧灯2\"/>\
        <aircondition id=\"345890\" name=\"空调\" airconditionCode =\"G829\"/>\
    </menu>\
    <menu id=\"1002\" name=\"演示房间2\" pwd=\"\"/>\
    </buddy>";
    XMLParser *parse = [[XMLParser alloc]init];
    NSArray *result = [parse parseData:[xml dataUsingEncoding:NSUTF8StringEncoding
                                        ]];
    NSLog(@"result = %@",result);
}
- (void)test4 {
    LWLPerson *lwlPerson = [[LWLPerson alloc]init];
    [lwlPerson changeTitle];
    NSLog(@"title=%@",lwlPerson.title);
    lwlPerson.foodName = @"apple";
}
- (void)test3 {
    NSString *result = @"4";
    NSString * temp10 = [NSString stringWithFormat:@"%lu",strtoul([result UTF8String],0,16)];
    NSLog(@"心跳数字 10进制 %@",temp10);
    //转成数字
    int cycleNumber = [temp10 intValue];
    NSLog(@"心跳数字 ：%d",cycleNumber);
}

- (void)test2 {
    NSString *pwd = @"817193";
    NSString *key = @"09005039";
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
