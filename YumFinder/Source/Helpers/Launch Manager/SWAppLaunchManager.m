//
//  SWAppLaunchManager.m
//  Nimar LabsA51
//
//  Created by Summer Green on 2/26/14.
//  Copyright (c) 2014 Summer Green. All rights reserved.
//

#import "SWAppLaunchManager.h"

NSString *const SW_PreviousVersionArrayKey = @"USL::PreviousAppVersions";

@implementation SWAppLaunchManager


#pragma mark - Private Helper Methods


#pragma mark - Public Static Methods
+(SWLaunchManagerOption) launchSummary{
    SWLaunchManagerOption launchStatus = SWLaunchManagerOptionUnknown;
    
/*  1.
 *  Get current version ("Bundle Version") from the default Info.plist file
 */
    NSString *currentVersion = (NSString*)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    NSArray *prevStartupVersions = [[NSUserDefaults standardUserDefaults] arrayForKey:SW_PreviousVersionArrayKey];
    if (prevStartupVersions == nil)
    {
        // Starting up for first time with NO pre-existing installs (e.g., fresh
        // install of some version)
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObject:currentVersion] forKey:@"prevStartupVersions"];
        launchStatus = SWLaunchManagerOptionFreshInstallation; //first launch of the app
    } else {
        if (![prevStartupVersions containsObject:currentVersion])
        {
            // Starting up for first time with this version of the app. This
            // means a different version of the app was alread installed once
            // and started.
            NSMutableArray *updatedPrevStartVersions = [NSMutableArray arrayWithArray:prevStartupVersions];
            [updatedPrevStartVersions addObject:currentVersion];
            [[NSUserDefaults standardUserDefaults] setObject:updatedPrevStartVersions forKey:SW_PreviousVersionArrayKey];
        launchStatus = SWLaunchManagerOptionFirstLaunchOfNewVersion; //first launch of this version of the app
        }
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return launchStatus;
}
@end
