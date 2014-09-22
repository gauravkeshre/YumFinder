//
//  US_MacroConstants.h
//  Nimar LabsA51
//
//  Created by Summer Green on 2/27/14.
//  Copyright (c) 2014 Summer Green. All rights reserved.
//

#define kNumberOfBubbleFrames 35
#define usKEYBAORD_DISMISS_DURATION 0.25
#define APP_FONT_NAME @"Helvetica Neue"
#define APP_FONT_SIZE 14.f
#define APP_FONT(x) [UIFont fontWithName:APP_FONT_NAME size:x]

#define SQUARE(x) ((x)*(x))

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f

#define IS_IOS6 ([[UIDevice currentDevice].systemVersion floatValue]<7)

#define kScrollContentHeight 700

#define kDESC_FONT_SIZE 14.f

#define kKeyboardHeight 206.f

#define kKeyboardHeightWithBar 241.f

#define kPushNotificationPostId @"PushNotificationPostId"

#define kSocialNetworkPostId @"SocialNetworkPostId"

#define kAPP_ITUNES_URL @"https://itunes.apple.com/us/app/Nimar Labs/id894322854?ls=1&mt=8"

#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

#define kSAVED_USER_DETAILS @"saved_user_details"

#define kREMEMBER_ME @"Remember me"


/*
 * Math
 */
#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)


/*
 * String Operations
 */

#define NSStringFromIntOrLong(num) [NSString stringWithFormat:@"%ld",(long)num]
#define ISNULL(obj) ([obj isEqual:[NSNull null]] || obj == nil)
