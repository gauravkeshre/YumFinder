//
//  SWCountDownTimerLabel.h
//  DMOSTimerDemo
//
//  Created by Summer Green on 8/2/14.
//  Copyright (c) 2014 Nimar Labs Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#define COLOR_RGB(r,g,b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]



typedef void(^SWTimerTickBlock)(NSTimeInterval elapsedTime, NSTimeInterval remainingTime, NSTimeInterval totalDuration, BOOL aboutToFinish);

typedef void(^SWTimeUpBlock)(NSTimeInterval totalDuration);


typedef NS_ENUM(NSInteger, SWCountDownFormat) {
    SWCountDownFormatDefault,
    SWCountDownFormatHHMMSS,
    SWCountDownFormatMMSS
};

@interface SWCountDownTimerLabel : UILabel

@property(nonatomic) BOOL highlightTowardsEnd;

@property(nonatomic, copy)SWTimerTickBlock tickBlock;
@property(nonatomic, copy)SWTimeUpBlock timeUpBlock;


@property(nonatomic) NSTimeInterval totalDuration;
@property(nonatomic) NSTimeInterval warningDuration;
@property(nonatomic) NSTimeInterval tickInterval;
@property(nonatomic) SWCountDownFormat countDownFormat;

@property(nonatomic) BOOL animateCountDown;

-(void)setTotalDuration:(NSTimeInterval)totalDuration
   andStartAutomaticaly:(BOOL)start
        withTickHandler:(SWTimerTickBlock)timerTickBlock
        withTimeUpHandler:(SWTimeUpBlock)timeUpBlock;
-(void)startCountdown;
-(void)stop;
@end


