//
//  SWCountDownTimerLabel.m
//  DMOSTimerDemo
//
//  Created by Summer Green on 8/2/14.
//  Copyright (c) 2014 Nimar Labs Pvt. Ltd. All rights reserved.
//
//16, 124, 246
//246, 240, 109
#import "SWCountDownTimerLabel.h"
#import "NSDate+TimerUtilities.h"
@interface SWCountDownTimerLabel()
{
    NSTimeInterval elapsedTime;
}
@property (nonatomic, strong)NSTimer *timer;

@end

@implementation SWCountDownTimerLabel

@synthesize  warningDuration = _warningDuration;

#pragma mark - Dealloc Methods
-(void)dealloc{
    [self cleanUp];
}
-(void)cleanUp{
    [self stopCountDown];
    self.tickBlock = nil;
    self.timeUpBlock = nil;
}

#pragma mark - Life Cycle Methods

-(SWCountDownFormat)countDownFormat{
    if (_countDownFormat<1 || (NSInteger)_countDownFormat==NSNotFound || _countDownFormat ==SWCountDownFormatDefault) {
        return SWCountDownFormatHHMMSS;
    }
    return _countDownFormat;
    
}

-(void)setTotalDuration:(NSTimeInterval)td{
    if (td<1 || td==NSNotFound) {
        _totalDuration = 0;
    }
    _totalDuration = td *60;
    
}


-(NSTimeInterval)warningDuration{
    if (_warningDuration<1 || _warningDuration==NSNotFound) {
        return 0;
    }
    return _warningDuration;
}
-(void)setWarningDuration:(NSTimeInterval)wd{
    if (wd<1 || wd==NSNotFound) {
        _warningDuration = 0;
    }
    _warningDuration = wd *60;
}

-(NSTimeInterval)tickInterval{
    if (_tickInterval<1 || _tickInterval==NSNotFound) {
        return 1;
    }
    return _tickInterval;
}
#pragma mark - Convenience Methods
-(void)tick:(NSTimer *)tTimer{
    if (elapsedTime==NSNotFound)return;
    
    NSTimeInterval timeREmaining = self.totalDuration-(++elapsedTime);//(elapsedTime+=self.tickInterval);
    
    if (timeREmaining >=0) {
        NSString *strFormatted= [self stringFromInterval:timeREmaining];
        
//        //NSLog(@"tick : %@", strFormatted);
        [self setText:strFormatted withAnimtion:self.animateCountDown];

        
        if (self.tickBlock) {
            self.tickBlock(elapsedTime, timeREmaining, self.totalDuration, (timeREmaining<=self.warningDuration));
        }
        return;
    }
    
    /*
     * stop timer
     */
    if(timeREmaining == 0)
    [self stopCountDown];
    
    if (self.timeUpBlock) {
        self.timeUpBlock(elapsedTime);
    }
    elapsedTime = NSNotFound;
}

#pragma mark - Timer Operations Methods
-(void)startCountdown{
    //NSLog(@"Start");
    
    
    /*
     * Clear previous traces
     */
    [self stopCountDown];
    elapsedTime =0;
    
    /*
     * Force First tick
     */
    
        [self tick:nil];
    
    /*
     * Start TImer
     */
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.tickInterval
                                                  target:self
                                                selector:@selector(tick:)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
}

-(void)stopCountDown{
    //NSLog(@"Stop");
    
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Initializer Methods
-(void)setTotalDuration:(NSTimeInterval)duration
   andStartAutomaticaly:(BOOL)shouldStartNow
        withTickHandler:(SWTimerTickBlock)timerTickBlock
      withTimeUpHandler:(SWTimeUpBlock)timeUpBlock{

    if (duration<1 || duration==NSNotFound) {
        
        NSString *strFormatted= [self stringFromInterval:0];
        [self setText:strFormatted withAnimtion:self.animateCountDown];
        
        [self cleanUp];
        return;
    }
    /*
     * assign blocks
     */
    
    self.tickBlock = timerTickBlock;
    self.timeUpBlock = timeUpBlock;
    
    
    /*
     * Assign Duration
     */
    self.totalDuration = duration;
    
    
    /*
     * Should Start Automatically?
     */
    if (shouldStartNow) {
        [self startCountdown];
    }
}

-(void)stop{
    [self cleanUp];
}


-(void)setText:(NSString *)text withAnimtion:(BOOL)fadeAnimate{
    if (fadeAnimate) {
        CATransition *animation = [CATransition animation];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionFade;
        animation.duration = 0.4;
        [self.layer addAnimation:animation forKey:@"kCATransitionFade"];
    }
    self.text = text;
}

-(NSString *)stringFromInterval:(NSTimeInterval)inter{
    NSString *strFormatted;// = NStringFromInterval(timeREmaining);
    switch (self.countDownFormat) {
        case SWCountDownFormatDefault:
        case SWCountDownFormatHHMMSS:
            strFormatted = NStringFromInterval(inter, YES);
            break;
        case SWCountDownFormatMMSS:
            strFormatted = NStringFromInterval(inter, NO);
            break;
            
        default:
            break;
    }
    return strFormatted;
}
@end
