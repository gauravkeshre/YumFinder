//
//  UITextView+Additions.m
//  Nimar Labs
//
//  Created by Summer Green on 6/18/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "UITextView+Additions.h"
#define kTextFieldSpacing 20
@implementation UITextView (Additions)

-(BOOL)isEmpty{
    BOOL flag = NO;
    NSString *str = [self text];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([str length]<1) {
        flag = flag || YES;
    }
    return flag;
}


-(void)clear{
    [self setText:@""];
}
@end

@implementation UITextField (Additions)

-(BOOL)isEmpty{
    BOOL flag = NO;
    NSString *str = [self text];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([str length]<1) {
        flag = flag || YES;
    }
    return flag;
}


-(void)clear{
    [self setText:@""];
}


-(void)addErrorInfoButtonWithTarget:(id)target andSelector:(SEL)sel{
    [self setRightView:nil];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [button setImage:[UIImage imageNamed:@"icon-error.png"] forState:UIControlStateNormal];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    button.tag = self.tag;
    [self setRightView:button];
    [self setRightViewMode:UITextFieldViewModeUnlessEditing];
}

-(void)removeErrorInfoButton{
    [self setRightView:nil];
}
-(void)addLeftSpacingWithBlueTextColor
{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kTextFieldSpacing,  self.frame.size.height)];
    leftView.backgroundColor =  [UIColor clearColor];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
    [self setTextColor:[UIColor appTextBlueColor]];
    leftView=nil;
}
-(void)setPlaceholderColor:(UIColor*)phColor{
    [self setValue:phColor forKeyPath:@"_placeholderLabel.textColor"];
}
@end


