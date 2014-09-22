//
//  UIStoryboard+convenience.m
//  Nimar Labs
//
//  Created by Summer Green on 11/16/13.
//  Copyright (c) 2013 Nimar Labs. All rights reserved.
//

#import "UIStoryboard+convenience.h"

@implementation UIStoryboard (convenience)
+(UIStoryboard *)mainStoryboard{
    return [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
}

+(UIStoryboard *)loginStoryboard{
    return [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
}
+(UIStoryboard *)menuStorynoard{
    return [UIStoryboard storyboardWithName:@"Menu" bundle:[NSBundle mainBundle]];
}
@end
