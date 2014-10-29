//
//  NSString+TimeInString.h
//  DMOS_temp
//
//  Created by Green on 08/07/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TimeInString)

+(NSString *)getStringWithTime:(NSString *)timerString;
+(NSString *)getMinutesWithTime:(NSString *)timerString;

@end
