//
//  UIColor+AppTheme.h
//  Nimar Labs
//
//  Created by Summer Green on 6/15/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UI_COLOR_WITH_RGB(r,g,b)[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
@interface UIColor (AppTheme)

//hemanth
+(UIColor *)appThemeColor;
+(UIColor *)appDarkColor;
+(UIColor *)appUnselectedMenuColor;
+(UIColor *)appRedColor;
+(UIColor *)appGreenColor;
+(UIColor *)appBlueColor;
+(UIColor *)appYellowColor;
+(UIColor *)appTextBlueColor;
+(UIColor *)appTextGrayColor;
+(UIColor *)appTextPlaceholderColor;
+(UIColor *)skinColor;
@end
