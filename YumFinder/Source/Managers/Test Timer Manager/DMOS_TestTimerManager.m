//
//  DMOS_TestTimerManager.m
//  SWTestTimer
//
//  Created by Sugeet on 1/07/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "DMOS_TestTimerManager.h"

@implementation DMOS_TestTimerManager
@synthesize currMinute=_currMinute;
@synthesize currSeconds=_currSeconds;

#pragma mark - Dealloc
-(void)dealloc
{
    NSLog(@"dealloc: DMOS_TestTimerManager");
    [timer invalidate]; timer=nil;
}

#pragma mark - Init Methodes
- (id) initWithMinutes:(int)currMinute andSeconds:(int)currSecond;
{
    self = [super init];
    if (self)
    {
        _currMinute=currMinute;
        _currSeconds=currSecond;
//        [self performSelector:@selector(start) withObject:nil afterDelay:1];
//        [self start];
    }
    return self;
}

#pragma mark - timing functions

-(void)start
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}
-(void)timerFired
{
    NSLog(@"timerFired");
    if((_currMinute>0 || _currSeconds>=0) && _currMinute>=0)
    {
        if(_currSeconds==0)
        {
            _currMinute-=1;
            _currSeconds=59;
        }
        else if(_currSeconds>0)
        {
            _currSeconds-=1;
        }
        if(_currSeconds<=0)
        {
            _currSeconds=0;
        }
        if(_currMinute>-1)
        {
            NSString *strTime =[NSString stringWithFormat:@"%@%d%@%02d",@"Time : ",_currMinute,@" min:",_currSeconds];
            if ([self.delegate respondsToSelector:@selector(countDownTimer:
                                                            CurrentCountDown:)]) {
                [self.delegate countDownTimer:self CurrentCountDown:strTime];
            }
        }
    }
    else
    {
        [timer invalidate];
    }
}


@end
