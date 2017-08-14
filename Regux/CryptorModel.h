//
//  CryptorModel.h
//  SmartHome
//
//  Created by BOB on 17/5/8.
//  Copyright © 2017年 octatech.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CryptorModel : NSObject
//加密
+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
//解密
+ (NSString *) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
+ (NSString *)base64StringFromText:(NSString *)text;
+ (NSString *)textFromBase64String:(NSString *)base64;

@end
