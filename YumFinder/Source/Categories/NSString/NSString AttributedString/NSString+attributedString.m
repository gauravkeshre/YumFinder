//
//  NSString+attributedString.m
//  DMOS_temp
//
//  Created by Hemanth on 6/27/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "NSString+attributedString.h"

@implementation NSString (attributedString)
+(NSAttributedString *)attributedString:(NSString *)string WithColor:(UIColor *)color forWordIndex:(NSInteger)index
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSArray *matches= [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSTextCheckingResult *wordRange=[matches objectAtIndex:index];
    NSRange hashRange = [string rangeOfString:(NSString *)wordRange];
    [attributedString addAttribute:NSForegroundColorAttributeName
                    value:color
                    range:hashRange];
    return attributedString;
}
-(NSAttributedString *)attributedStringWithColor:(UIColor *)color forWordIndex:(NSInteger)index
{
    return [NSString attributedString:self WithColor:color forWordIndex:index];
}
+(NSAttributedString *)attributedString:(NSString *)string WithColor:(UIColor *)color
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:color
                             range:NSMakeRange(0, [string length])];
    return attributedString;
}
-(NSAttributedString *)attributedStringWithColor:(UIColor *)color
{
    return [NSString attributedString:self WithColor:color];

}
+(NSAttributedString *)underlinedAttributedStringFor:(NSString *)str
{
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:str];
    [attrString addAttribute:NSUnderlineStyleAttributeName
                      value:[NSNumber numberWithInt:1]
                      range:(NSRange){0,[attrString length]}];
    return attrString;
}
-(NSAttributedString *)underlinedAttributedString
{
    return [NSString underlinedAttributedStringFor:self];
}
@end
