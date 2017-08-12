//
//  ViewController.m
//  DeepCopy
//
//  Created by git on 17/2/22.
//  Copyright © 2017年 longwl. All rights reserved.
//

#import "ViewController.h"
#import "XcapManager.h"
#import "XMLParser.h"
#import "GDataXMLNode.h"
@interface ViewController ()

{
    NSInteger i ;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self test];
    
    UIButton *btnPut = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnPut setBackgroundColor:[UIColor lightGrayColor]];
    [btnPut setTitle:@"Put" forState:UIControlStateNormal];
    [btnPut setFrame:CGRectMake(100, 100, 100 , 50)];
    [self.view addSubview:btnPut];
    [btnPut addTarget:self action:@selector(putXcap) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnPutInfo = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnPutInfo setBackgroundColor:[UIColor lightGrayColor]];
    [btnPutInfo setTitle:@"PutINFO" forState:UIControlStateNormal];
    [btnPutInfo setFrame:CGRectMake(200, 100, 100 , 50)];
    [self.view addSubview:btnPutInfo];
    [btnPutInfo addTarget:self action:@selector(putInfoXcap) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnGet = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnGet setBackgroundColor:[UIColor blueColor]];
    [btnGet setTitle:@"Get" forState:UIControlStateNormal];
    [btnGet setFrame:CGRectMake(100, 300, 100 , 50)];
    [self.view addSubview:btnGet];
    [btnGet addTarget:self action:@selector(getXcap) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnGetInfo = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnGetInfo setBackgroundColor:[UIColor blueColor]];
    [btnGetInfo setTitle:@"GetInfo" forState:UIControlStateNormal];
    [btnGetInfo setFrame:CGRectMake(200, 300, 100 , 50)];
    [self.view addSubview:btnGetInfo];
    [btnGetInfo addTarget:self action:@selector(getInfoXcap) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnAdd setBackgroundColor:[UIColor yellowColor]];
    [btnAdd setTitle:@"Add" forState:UIControlStateNormal];
    [btnAdd setFrame:CGRectMake(100, 500, 100 , 50)];
    [self.view addSubview:btnAdd];
    [btnAdd addTarget:self action:@selector(addXcap) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btndel = [UIButton buttonWithType:UIButtonTypeSystem];
    [btndel setBackgroundColor:[UIColor yellowColor]];
    [btndel setTitle:@"Delete" forState:UIControlStateNormal];
    [btndel setFrame:CGRectMake(200, 500, 100 , 50)];
    [self.view addSubview:btndel];
    [btndel addTarget:self action:@selector(deleteXcap) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnXml = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnXml setBackgroundColor:[UIColor yellowColor]];
    [btnXml setTitle:@"xmlPUT" forState:UIControlStateNormal];
    [btnXml setFrame:CGRectMake(300, 500, 100 , 50)];
    [self.view addSubview:btnXml];
    [btnXml addTarget:self action:@selector(xmlCompose) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnXml2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnXml2 setBackgroundColor:[UIColor yellowColor]];
    [btnXml2 setTitle:@"xmlGET" forState:UIControlStateNormal];
    [btnXml2 setFrame:CGRectMake(300, 600, 100 , 50)];
    [self.view addSubview:btnXml2];
    [btnXml2 addTarget:self action:@selector(getInfo) forControlEvents:UIControlEventTouchUpInside];
    
}
- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

- (void)deleteXcap {
    XcapManager *manager = [XcapManager sharedXcapManager];
    [manager xcapDeleteContractsBuddyWithUserId:@"U104@115.28.200.181:5527" isAll:NO buddyId:nil success:^(NSURLSessionDataTask *dataTask, id responseObj) {
        XMLParser *parser = [[XMLParser alloc]init];
        NSArray *bodies = [parser parseData:responseObj];
        NSLog(@"%@",bodies);
    } failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
        
    }];
}
- (void)putInfoXcap {
    NSString *iconStr =[self encodeToBase64String:[UIImage imageNamed:@"Default.png"]];
    //@"wedsad3qeware";
    //[self encodeToBase64String:[UIImage imageNamed:@"Default.png"]];
    XcapManager *manager = [XcapManager sharedXcapManager];
    //NSString *str1 = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf8\"?>\n<buddy nick=\"2029%ld\" id=\"U104\" sex=\"0\" area=\"江苏 南京\" birthday=\"1994/12/21\" icon=\"\">\n</buddy>",i++];
    NSString *str1 = @"<buddy nick=\"1731\" id=\"U116\" sex=\"0\"\
    area="" birthday=\"1994/12/21\" icon="">\
    <doors>\
    <door doorId = \"s456\" expireDate = \"2017.9.21\"  PermissionerUserId =\"\"/>\
    <door doorId = \"s456\" expireDate = \"2017.9.21\" PermissionerUserId = \"\" />\
    <doors/>\
    </buddy>";
    [manager xcapPutContractsBuddyWithUserId:@"U116@118.144.86.70:5527" buddyStr:str1 isAll:NO buddyId:nil success:^(NSURLSessionUploadTask *uploadTask, id responseObj) {
        XMLParser *parser = [[XMLParser alloc]init];
        NSArray *bodies = [parser parseData:responseObj];
        NSLog(@"%@",bodies);
    } failure:^(NSURLSessionUploadTask *uploadTask, NSError *error) {
        
    }];
}
- (void)getInfoXcap {
    XcapManager *manager = [XcapManager sharedXcapManager];
    [manager xcapGetContractsBuddyWithUserId:@"00E427005F5C" isAll:NO buddyId:nil success:^(NSURLSessionDataTask *dataTask, id responseObj) {
        XMLParser *parser = [[XMLParser alloc]init];
        NSArray *bodies = [parser parseData:responseObj];
        NSLog(@"00E427005F5C:%@",bodies);
    } failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
        
    }];
}
- (void)putXcap {
    XcapManager *manager = [XcapManager sharedXcapManager];
    //NSString *str1 = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\
    <body>\
    <buddy name=\"空调\" type='AC' id=\"00E07032AC935\" image=\"app07.png\"/>\
    <buddy name=\"窗帘\" type='curtain' id=\"00E07032AC93\" image=\"app09.png\"/>\
    <buddy name=\"1号楼2单元3门\" type=\"VI\" id=\"aca21368c901\" image=\"nw.png\"><menu id=\"1002\" op=\"call\" name=\"监视\"/><menu id=\"1003\" name=\"开锁\"/></buddy>\
    <buddy name=\"空调1\" type='AC' id=\"00E07032AC91\" image=\"app06.png\"/>\
    <buddy name=\"灯光\" type='light' id=\"00E427005F5C\" image=\"app05.png\"/>\
    </body>";
    NSString *str1 = @"<buddy name=\"灯光\" type=\"light\" id=\"00E427005F5C\" image=\"app05.png\"/>";
    [manager xcapPutContractsBuddyWithUserId:@"U28" buddyStr:str1 isAll:YES buddyId:@"00E427005F5C"  success:^(NSURLSessionUploadTask *uploadTask, id responseObj) {
        XMLParser *parser = [[XMLParser alloc]init];
        NSArray *bodies = [parser parseData:responseObj];
        NSLog(@"00E427005F5C-put:%@",bodies);
    } failure:^(NSURLSessionUploadTask *uploadTask, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];

}

- (void)getXcap {
    XcapManager *manager = [XcapManager sharedXcapManager];
     [manager xcapGetContractsBuddyWithUserId:@"U28" isAll:YES buddyId:nil  success:^(NSURLSessionDataTask *dataTask, id responseObj) {
         XMLParser *parser = [[XMLParser alloc]init];
         NSArray *bodies = [parser parseData:responseObj];
         NSLog(@"ALLBuddies:%@",bodies);

     } failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
     if (error) {
     NSLog(@"%@",error);
     }
     }];
    
}

- (void) addXcap {
    XcapManager *manager = [XcapManager sharedXcapManager];
    NSString *str2 = @"<buddy name=\"单元门bob \" type=\"VI\" id=\"e0b94d6d1b9f\" image=\"\"/>";
    [manager xcapPutContractsBuddyWithUserId:@"e0b94d6d1b9f@118.144.86.70:5527" buddyStr:str2 isAll:NO buddyId:nil  success:^(NSURLSessionUploadTask *uploadTask, id responseObj) {
        XMLParser *parser = [[XMLParser alloc]init];
        NSArray *bodies = [parser parseData:responseObj];
        NSLog(@"%@",bodies);

    } failure:^(NSURLSessionUploadTask *uploadTask, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}

- (void)getInfo {
    XcapManager *manager = [XcapManager sharedXcapManager];
    [manager xcapGetContractsBuddyWithUserId:@"U104@115.28.200.181:5527" isAll:NO buddyId:nil success:^(NSURLSessionDataTask *dataTask, id responseObj) {
        XMLParser *parser = [[XMLParser alloc]init];
        NSArray *arr = [parser parseData:responseObj];
        NSLog(@"%@",arr);
    } failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
        
    }];
}

-(void)xmlCompose {
    NSDictionary *menuDicAttribute = [NSDictionary dictionaryWithObjects:@[@"23",@"me"] forKeys:@[@"id",@"name"]];
    NSMutableDictionary *menuDic = [NSMutableDictionary dictionaryWithObject:menuDicAttribute forKey:@"attribute"];
    [menuDic setValue:@"menu" forKey:@"tag"];
    [menuDic setValue:nil forKey:@"children"];
    NSArray *arr = @[menuDic,menuDic];
    
    NSArray *keys = [NSArray arrayWithObjects:@"name",@"userId",@"area",@"birth", nil];
    NSArray *values = [NSArray arrayWithObjects:@"Rose",@"U123",@"江苏 南京",@"1994/06/08", nil];
    NSDictionary *dataDic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSMutableDictionary *buddyDic = [NSMutableDictionary dictionaryWithObject:dataDic forKey:@"attribute"];
    [buddyDic setValue:@"buddy" forKey:@"tag"];
    [buddyDic setValue:arr forKey:@"children"];
    
    //NSString *xmlStr = [self composeWithInfoDic2:buddyDic];
    
    //NSString *xmlStr = [self composeWithInfoDic:buddyDic];
    //NSLog(@"xmlStr = %@",xmlStr);
    [self xmlComposeqwe];
    //NSData *buddyData = [NSPropertyListSerialization dataWithPropertyList:buddyDic format:NSPropertyListXMLFormat_v1_0 options:NSPropertyListWriteInvalidError error:nil];
    //NSLog(@"XML: %@", [[NSString alloc] initWithData:buddyData encoding:NSUTF8StringEncoding]);
    XcapManager *manager = [XcapManager sharedXcapManager];
    
}

- (NSString *)composeWithInfoDic:(NSDictionary *)dic {
    NSMutableString *xmlString = [[NSMutableString alloc] initWithString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"];
    [xmlString appendFormat:@"<%@ ",dic.allKeys.firstObject];
    NSDictionary *infoProperty = dic.allValues.firstObject;
    NSArray *keys = infoProperty.allKeys;
    for (id key in keys) {
        [xmlString appendFormat:@"%@=\"%@\" ",key,[infoProperty valueForKey:key]];
    }
    [xmlString appendFormat:@"></%@>",dic.allKeys.firstObject];
    
    return xmlString;
}

- (NSString *)composeWithInfoDic2:(NSDictionary *)dic {
    NSMutableString *xmlString = [[NSMutableString alloc] initWithString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"];
    [self parserDicWithDic:dic xml:xmlString];
    return xmlString;
}

- (void)parserDicWithDic:(NSDictionary *)dic xml:(NSMutableString *)xmlString{
    NSDictionary *attDic = [dic valueForKey:@"attribute"];
    if (attDic.count == 0) {
        [xmlString appendFormat:@"<%@>",[dic valueForKey:@"tag"]];
    }else {
        [xmlString appendFormat:@"<%@ ",[dic valueForKey:@"tag"]];
        NSArray *keys = attDic.allKeys;
        for (int i = 0; i < keys.count; i++) {
            if (i == keys.count-1) {
                [xmlString appendFormat:@"%@=\"%@\">",keys[i],[attDic valueForKey:keys[i]]];
            }else {
                [xmlString appendFormat:@"%@=\"%@\" ",keys[i],[attDic valueForKey:keys[i]]];
            }
        }
        NSArray *childrens = [dic valueForKey:@"children"];
        if (childrens && (childrens.count>0)) {
            for (NSDictionary *children in childrens) {
                [self parserDicWithDic:children xml:xmlString];
            }
        }
    }
    
    [xmlString appendFormat:@"</%@>",[dic valueForKey:@"tag"]];
}

- (void)xmlComposeqwe {
    // 创建一个标签元素
    GDataXMLElement *element = [GDataXMLNode elementWithName:@"buddy" stringValue:@""];
    // 创建一个属性
    GDataXMLElement *attribute = [GDataXMLNode attributeWithName:@"name" stringValue:@"单元门口机"];
    GDataXMLElement *attribute2 = [GDataXMLNode attributeWithName:@"type" stringValue:@"VI"];
    [element addAttribute:attribute];
    [element addAttribute:attribute2];
    // 创建一个根标签
    GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"body"];
    // 把标签与属性添加到根标签中
    [rootElement addChild:element];
    // 生成xml文件内容
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
    NSData *data = [xmlDoc XMLData];
    NSString *xmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", xmlString);
}


- (void)test {
    
    int a = 1;
    int *pa = &a;
    int *pb = pa;
    NSLog(@"a = %p,b = %p",pa,pb);
    int b = 2;
    pa = &b;
    NSLog(@"2a = %p,b = %p",pa,pb);
    
    NSString *str1 = @"asd";
    NSString *copyStr1 = [str1 copy];
    NSMutableString *mutableStr1 = [str1 mutableCopy];
    NSLog(@"str1 = %p,%@",str1,str1);
    NSLog(@"copyStr1 = %p,%@",copyStr1,copyStr1);
    NSLog(@"mutableStr1 = %p,%@",mutableStr1,mutableStr1);
    copyStr1 = @"qwe";
    NSLog(@"str1 = %p,%@",str1,str1);
    NSLog(@"copyStr1 = %p,%@",copyStr1,copyStr1);
    NSLog(@"mutableStr1 = %p,%@",mutableStr1,mutableStr1);
    [mutableStr1 appendString:@"zxc"];
    //mutableStr1 = [@"zxc" mutableCopy];
    NSLog(@"str1 = %p,%@",str1,str1);
    NSLog(@"copyStr1 = %p,%@",copyStr1,copyStr1);
    NSLog(@"mutableStr1 = %p,%@",mutableStr1,mutableStr1);
    
    NSMutableString *str = [NSMutableString stringWithString:@"123"];
    NSArray *arr = [NSArray arrayWithObjects:str, nil];
    NSArray *copyArr = [arr copy];
    NSMutableArray *mutableCopyArr = [arr mutableCopy];
    NSLog(@"str = %p,%@",str,str);
    NSLog(@"arr = %p,firstObj = %p,%@\n",arr,arr.firstObject,arr.firstObject);
    NSLog(@"copyArr = %p,firstObj = %p,%@\n",copyArr,copyArr.firstObject,copyArr.firstObject);
    NSLog(@"mutableCopyArr = %p,firstObj = %p,%@\n",mutableCopyArr,mutableCopyArr.firstObject,mutableCopyArr.firstObject);
    //mutableCopyArr[0] = @"456qwe";
    [mutableCopyArr[0] appendString:@"123"];
    NSLog(@"str = %p,%@",str,str);
    NSLog(@"arr = %p,firstObj = %p,%@\n",arr,arr.firstObject,arr.firstObject);
    NSLog(@"copyArr = %p,firstObj = %p,%@\n",copyArr,copyArr.firstObject,copyArr.firstObject);
    NSLog(@"mutableCopyArr = %p,firstObj = %p,%@\n",mutableCopyArr,mutableCopyArr.firstObject,mutableCopyArr.firstObject);
    //NSLog(@"str2 = %p,%@",str2,str2);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
