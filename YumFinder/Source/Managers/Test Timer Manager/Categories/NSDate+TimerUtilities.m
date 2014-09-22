//
//  NSDate+TimerUtilities.m
//  DMOSTimerDemo
//
//  Created by Summer Green on 8/2/14.
//  Copyright (c) 2014 Nimar Labs Pvt. Ltd. All rights reserved.
//

#import "NSDate+TimerUtilities.h"

@implementation NSDate (TimerUtilities)

NSString *NStringFromInterval(NSTimeInterval timeInterval,BOOL longFormat)
{
#define SECONDS_PER_MINUTE (60)
#define MINUTES_PER_HOUR (60)
#define SECONDS_PER_HOUR (SECONDS_PER_MINUTE * MINUTES_PER_HOUR)
#define HOURS_PER_DAY (24)
    
    // convert the time to an integer, as we don't need double precision, and we do need to use the modulous operator
    int ti = round(timeInterval);
    
    if (longFormat) {
        return [NSString stringWithFormat:@"%.2d:%.2d:%.2d", (ti / SECONDS_PER_HOUR) % HOURS_PER_DAY, (ti / SECONDS_PER_MINUTE) % MINUTES_PER_HOUR, ti % SECONDS_PER_MINUTE];
    }else{
        return [NSString stringWithFormat:@"%.2d:%.2d", (ti / SECONDS_PER_MINUTE) % MINUTES_PER_HOUR, ti % SECONDS_PER_MINUTE];

    }
    
#undef SECONDS_PER_MINUTE
#undef MINUTES_PER_HOUR
#undef SECONDS_PER_HOUR
#undef HOURS_PER_DAY
}
@end
