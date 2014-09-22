//
//  NSString+attributedString.h
//  DMOS_temp
//
//  Created by Hemanth on 6/27/14.
//  Copyright (c) 2014 Softway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (attributedString)
+(NSAttributedString *)attributedString:(NSString *)string WithColor:(UIColor *)color forWordIndex:(NSInteger)index;
-(NSAttributedString *)attributedStringWithColor:(UIColor *)color forWordIndex:(NSInteger)index;

+(NSAttributedString *)attributedString:(NSString *)string WithColor:(UIColor *)color;
-(NSAttributedString *)attributedStringWithColor:(UIColor *)color;

+(NSAttributedString *)underlinedAttributedStringFor:(NSString *)str;
-(NSAttributedString *)underlinedAttributedString;
@end
