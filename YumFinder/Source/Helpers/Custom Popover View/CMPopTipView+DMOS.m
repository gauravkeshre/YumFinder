//
//  CMPopTipView+DMOS.m
//  DMOS
//
//  Created by Summer Green on 6/18/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "CMPopTipView+DMOS.h"

@implementation CMPopTipView (DMOS)
+ (instancetype)toastMessageWithTitle:(NSString *)title message:(NSString *)message{
    CMPopTipView *pop = [[CMPopTipView alloc]initWithTitle:title message:message];
    [pop setBackgroundColor:[UIColor blackColor]];
    [pop setBorderColor:[UIColor appBlueColor]];
    [pop setBorderWidth:1];
    [pop setPreferredPointDirection:PointDirectionDown];
    [pop setPointerSize:0];
    [pop setDismissTapAnywhere:YES];
    [pop setSidePadding:8.f];
    [pop setTitleFont:APP_FONT(12.f)];
    [pop setCornerRadius:3.f];
    //    [CMPopTipView set]
    return pop;
    
    
}

+ (instancetype)validationMessageWithTitle:(NSString *)title message:(NSString *)message{
    
    CMPopTipView *pop = [CMPopTipView toastMessageWithTitle:title message:message];
    [pop setBackgroundColor:[UIColor blackColor]];
    [pop setBorderColor:[UIColor appBlueColor]];
    [pop setTextColor:[UIColor whiteColor]];
    [pop setTitleFont:APP_FONT(10.f)];
    [pop setPointerSize:7];
    [pop setPreferredPointDirection:PointDirectionUp];
    [pop setDismissTapAnywhere:YES];
    [pop setSidePadding:8.f];
    return pop;
}
@end
