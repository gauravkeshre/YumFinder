//
//  UIView+SmartHighlight.m
//  GKButtonIntercept
//
//  Created by Summer Green on 11/12/13.
//  Copyright (c) 2013 Summer Green (Research). All rights reserved.
//

#import "UIView+SmartHighlight.h"
#import "CAMediaTimingFunction+AdditionalEquations.h"
@implementation UIView (SmartHighlight)

-(void)shake{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.1];
    [shake setRepeatCount:2];
    [shake setAutoreverses:YES];
    [shake setSpeed:1.5f];
//    [shake setTimingFunction:[CAMediaTimingFunction easeOutSine]];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(self.center.x - 5,self.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(self.center.x + 5, self.center.y)]];
    
    [self.layer addAnimation:shake forKey:@"position"];
}


-(void)focusWithScale:(CGFloat)scale{
    CGAffineTransform t = CGAffineTransformMakeScale(scale, scale);
    [UIView animateWithDuration:HIGHLIGHT_SCALE_DURATION animations:^{
        self.transform = t;
    }];
}
-(void)dismissFocus{
    [self focusWithScale:1.f];
}
-(void)tiltWithRadians:(CGFloat)radians{
    self.transform= CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(radians));
}
@end
