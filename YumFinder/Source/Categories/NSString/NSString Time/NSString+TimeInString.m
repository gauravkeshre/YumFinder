//
//  NSString+TimeInString.m
//  DMOS_temp
//
//  Created by Sugeet on 08/07/14.
//  Copyright (c) 2014 Softway. All rights reserved.
//

#import "NSString+TimeInString.h"

@implementation NSString (TimeInString)

+(NSString *)getStringWithTime:(NSString *)timerString
{
    NSScanner* timeScanner=[NSScanner scannerWithString:timerString];
    int hours,minutes,seconds;
    [timeScanner scanInt:&hours];
    [timeScanner scanString:@":" intoString:nil]; //jump over :
    [timeScanner scanInt:&minutes];
    [timeScanner scanString:@":" intoString:nil]; //jump over :
    [timeScanner scanInt:&seconds];
    NSString *time;
    if (hours==0) {
        if (minutes==0) {
            if (seconds==0) {
                time=@"Invalid time";
            }
            else
            {
                time=[NSString stringWithFormat:@"%dsec",seconds];
            }
        }
        else
        {
            if (seconds==0) {
                time=[NSString stringWithFormat:@"%dmin",minutes];
            }
            else
            {
                time=[NSString stringWithFormat:@"%dmin %dsec",minutes,seconds];
            }
        }
    }
    else
    {
        if (minutes==0) {
            if (seconds==0) {
                time=[NSString stringWithFormat:@"%dhrs",hours];
            }
            else
            {
                time=[NSString stringWithFormat:@"%dhrs %dsec",hours,seconds];
            }
        }
        else
        {
            if (seconds==0) {
                time=[NSString stringWithFormat:@"%dhrs %dmin",hours,minutes];
            }
            else
            {
                time=[NSString stringWithFormat:@"%dhrs %dmin %dsec",hours,minutes,seconds];
            }
        }
    }
    timeScanner = nil;
     //NSLog(@"%@",time);
    return time;
}
+(NSString *)getMinutesWithTime:(NSString *)timerString
{
    NSScanner* timeScanner=[NSScanner scannerWithString:timerString];
    int hours,minutes,seconds;
    [timeScanner scanInt:&hours];
    [timeScanner scanString:@":" intoString:nil]; //jump over :
    [timeScanner scanInt:&minutes];
    [timeScanner scanString:@":" intoString:nil]; //jump over :
    [timeScanner scanInt:&seconds];
    //NSLog(@"%@",[NSString stringWithFormat:@"%d",hours*60+minutes]);
    return [NSString stringWithFormat:@"%d",hours*60+minutes];
}

@end
