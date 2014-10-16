//
//  UIColor+AppTheme.m
//  Nimar Labs
//
//  Created by Summer Green on 6/15/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "UIColor+AppTheme.h"

@implementation UIColor (AppTheme)

//hemanth
+(UIColor *)appDarkColor{
    return UI_COLOR_WITH_RGB(1.f, 4.f, 5.f);
}
+(UIColor *)appUnselectedMenuColor{
    return UI_COLOR_WITH_RGB(0.f, 104.f, 164.f);
}
+(UIColor *)appRedColor{
    return UI_COLOR_WITH_RGB(237.f, 27.f, 47.f);
}
+(UIColor *)appGreenColor{
    return UI_COLOR_WITH_RGB(45.f, 204.f, 112.f);
}
+(UIColor *)appBlueColor{
    return UI_COLOR_WITH_RGB(142.f, 180.f, 223.f);
}
+(UIColor *)appYellowColor{
    return UI_COLOR_WITH_RGB(255.f, 191.f, 0.f);
}
+(UIColor *)appTextBlueColor
{
    return UI_COLOR_WITH_RGB(40.0, 77.f, 112.f);
}
+(UIColor *)appTextGrayColor
{
    return UI_COLOR_WITH_RGB(58.f, 58.f, 58.f);
}

+(UIColor *)appTextBackgroundBlueColor
{
    return UI_COLOR_WITH_RGB(183.f, 196.f, 207.f);
}
+(UIColor *)appTextPlaceholderColor{
    return [self appTextGrayColor];
}
+(UIColor *)appThemeColor{
        return UI_COLOR_WITH_RGB(115.f, 95.f, 138.f);

}
+(UIColor *)skinColor{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"skin_square"]];
}
@end
