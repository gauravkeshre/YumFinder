//
//  UIView+SmartHighlight.h
//  GKButtonIntercept
//
//  Created by Summer Green on 11/12/13.
//  Copyright (c) 2013 Summer Green (Research). All rights reserved.
//

#import <UIKit/UIKit.h>
#define HIGHLIGHT_SCALE_DURATION 0.25

@interface UIView (SmartHighlight)

-(void)focusWithScale:(CGFloat)scale;
-(void)dismissFocus;
-(void)shake;

-(void)tiltWithRadians:(CGFloat)radians;
@end
