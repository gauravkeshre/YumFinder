//
//  YMFAppearanceManager.m
//  YumFinder
//
//  Created by Summer Green on 9/22/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFAppearanceManager.h"

@implementation YMFAppearanceManager

+(void)applyAppearance{
    UIImage *textFieldBackground = [[UIImage imageNamed:@"bg_textField"]resizableImageWithCapInsets:UIEdgeInsetsMake(16.0, 29.f, 16.0, 30.f)];
    
    [[UITextField appearance] setBackground:textFieldBackground];
    [[UITextField appearance] setBorderStyle:UITextBorderStyleNone];
    
}
@end
