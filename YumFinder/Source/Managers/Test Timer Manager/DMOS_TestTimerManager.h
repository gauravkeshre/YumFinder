//
//  DMOS_TestTimerManager.h
//  SWTestTimer
//
//  Created by Sugeet on 1/07/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DMOS_TestTimerManagerDelegate;

@interface DMOS_TestTimerManager : NSObject
{
    NSTimer *timer;
}
@property (nonatomic, weak) id<DMOS_TestTimerManagerDelegate> delegate;
@property(nonatomic)int currMinute;
@property(nonatomic)int currSeconds;


- (id) initWithMinutes:(int)currMinute andSeconds:(int)currSecond;
-(void)start;
@end

@protocol DMOS_TestTimerManagerDelegate <NSObject>
- (void)countDownTimer:(DMOS_TestTimerManager *)countDown
      CurrentCountDown:(NSString *) currentCountDown;
@end
