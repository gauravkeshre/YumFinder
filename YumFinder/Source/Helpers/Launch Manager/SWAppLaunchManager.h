//
//  SWAppLaunchManager.h
//  Nimar LabsA51
//
//  Created by Summer Green on 2/26/14.
//  Copyright (c) 2014 Summer Green. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    SWLaunchManagerOptionUnknown = 0,
    SWLaunchManagerOptionFreshInstallation,         //doesn't guarantees that the app has never been installed before.
    SWLaunchManagerOptionFirstLaunchOfNewVersion
}SWLaunchManagerOption;
@interface SWAppLaunchManager : NSObject

+(SWLaunchManagerOption) launchSummary;
@end
