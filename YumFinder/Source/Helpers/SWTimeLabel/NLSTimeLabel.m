//
//  SWTimeLabel.m
//  SWTimeLabelDemo
//
//  Created by Summer Green on 3/9/13.
//  Copyright (c) 2013 Nimar Labs. All rights reserved.
//

#import "NLSTimeLabel.h"
#import "NSDate-Utilities.h"
@interface NLSTimeLabel()
{
    NSTimer     *_timer;
    NSString    *_datetimeString;
    NSDate      *_datetime;
    NSInteger   _value;
}

#pragma mark - Title Methods
-(void)setTitle:(NSString *)title;

@end

@implementation NLSTimeLabel
@synthesize fontName;
- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
    _datetime = nil;
    _datetimeString = nil;
    fontName = nil;
}
- (void)awakeFromNib {
    [super awakeFromNib];

    if (self.fontName) {
        self.titleLabel.font = [UIFont fontWithName:self.fontName size:self.titleLabel.font.pointSize];
    }
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark - Custom Setter Methods
-(void)setTextHorizontalAlignment:(UIControlContentHorizontalAlignment)alignment{
    textAlignment = alignment;
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    //self.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}

-(void)setFontSize:(CGFloat )size{
    if (self.fontName) {
        self.titleLabel.font = [UIFont fontWithName:self.fontName size:self.titleLabel.font.pointSize];
    }else{
        self.titleLabel.font = [UIFont systemFontOfSize:size];
    }
}
#pragma mark - Timer Methods

-(void)tik:(NSTimer *)timer{
    NSString *fuzzytime = [NSDate fuzzyTime:_datetimeString];
    [self setTitle:fuzzytime];
}

#pragma mark - Update Title Methods

-(void)setTitle:(NSString *)title{
    [super setTitle:title forState:UIControlStateNormal];
    [super setTitle:title forState:UIControlStateHighlighted];
    [super setTitle:title forState:UIControlStateSelected];
    [super setTitle:title forState:UIControlStateDisabled];
}

#pragma mark - Overriden ignortance Methods

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
       // DebugLog(@"ignorring title: %@", title);
    return;
}

#pragma mark - Date Methods
-(void)stopTimer{
    _datetimeString = nil;
    if (_timer!=nil) {
        [_timer invalidate];_timer = nil;
    }
}

-(void)startTimerWithIntialDate:(NSString *)date{
    _datetimeString = date;
    if (_timer!=nil) {
        [_timer invalidate];_timer = nil;
    }
    _timer = [[NSTimer alloc]initWithFireDate:[NSDate date] interval:1 target:self selector:@selector(tik:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

#pragma mark - Action Methods
-(void)displayDate{
    
}
@end
