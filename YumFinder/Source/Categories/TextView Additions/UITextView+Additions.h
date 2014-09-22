//
//  UITextView+Additions.h
//  Nimar Labs
//
//  Created by Summer Green on 6/18/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Additions)

-(BOOL)isEmpty;
-(void)clear;
@end


@interface UITextField (Additions)

-(BOOL)isEmpty;
-(void)clear;

-(void)addErrorInfoButtonWithTarget:(id)target andSelector:(SEL)sel;
-(void)removeErrorInfoButton;
-(void)addLeftSpacingWithBlueTextColor;
-(void)setPlaceholderColor:(UIColor*)phColor;
@end
