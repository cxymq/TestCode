//
//  XMLParser.m
//  SmartHome
//
//  Created by Liqiang on 16/6/12.
//  Copyright © 2016年 octatech.com. All rights reserved.
//

#import "XMLParser.h"
@interface XMLParser ()<NSXMLParserDelegate>
{
    
    int parseLevel;
}
@end

@implementation XMLParser

- (id) init {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:@"root" forKeyPath:@"tag"];
    [dict setValue:[[NSMutableDictionary alloc] init] forKey:@"attribute"];
    [dict setValue:nil forKey:@"str"];
    [dict setValue:[[NSMutableArray alloc] init] forKey:@"children"];

    self.currentElements = [[NSMutableArray alloc] init];
    [self.currentElements addObject:dict];
    parseLevel = 0;
    return self;
}

- (NSMutableArray*) parseData:(NSData *)data
{
//    DLog(@"%@",data);
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
    NSError *error = [parser parserError] ;
    
    return [self getResult];
}

- (void)parser:(NSXMLParser *)parser
    didStartElement:(NSString *)elementName
    namespaceURI:(NSString *)nameSpaceURI
    qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:elementName forKeyPath:@"tag"];
    [dict setValue:attributeDict forKey:@"attribute"];
    [dict setValue:nil forKey:@"str"];;
    [dict setValue:[[NSMutableArray alloc] init] forKey:@"children"];
    [[self.currentElements[parseLevel] valueForKey:@"children"] addObject:dict];
    [self.currentElements addObject:dict];
    parseLevel++;
}

- (void)parser:(NSXMLParser *)parser
    foundCharacters:(NSString *)string
{
    // currently we ignore the strings
    string = [string stringByTrimmingCharactersInSet: NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if([string isEqualToString:@""] == NO) {
        NSLog(@"Add string %@", string);
        [self.currentElements[parseLevel] setValue:string forKey:@"str"];
    }
}

- (void)parser:(NSXMLParser *)parser
    didEndElement:(NSString *)elementName
    namespaceURI:(NSString *)namespaceURI
    qualifiedName:(NSString *)qName
{
    [self.currentElements removeLastObject];
    parseLevel--;
}

- (NSMutableArray *) getResult {
    if(self.currentElements.count > 0) {
        NSLog(@"%@",self.currentElements);
        return [self.currentElements[0] valueForKey:@"children"];
       
    }
    
    return nil;
}

-(void) dumpDict: (NSDictionary *)dict level:(int) level {
    NSString *prefix = @"";
    for(int i = 0; i< level; i++) {
        prefix = [prefix stringByAppendingString:@"    "];
    }
    NSLog(@"%@ tag: %@", prefix, dict[@"tag"]);
    NSDictionary *attrib = dict[@"attribute"];
    for(NSString *key in [attrib allKeys]) {
        NSLog(@"%@    %@ : %@", prefix, key, attrib[key]);
    }
    
    for(NSDictionary *child in dict[@"children"]) {
        [self dumpDict:child level:level + 1];
    }
}
@end
