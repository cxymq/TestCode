//
//  XMLParser.h
//  SmartHome
//
//  Created by Liqiang on 16/6/12.
//  Copyright © 2016年 octatech.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParser : NSObject <NSXMLParserDelegate>
- (NSMutableArray *) parseData: (NSData *)data;
@property (nonatomic, retain) NSMutableArray *currentElements;
@end
