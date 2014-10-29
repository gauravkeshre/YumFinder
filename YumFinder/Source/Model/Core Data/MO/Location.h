//
//  Location.h
//  YumFinder
//
//  Created by Green Summer on 10/12/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NLS_BaseManagedObject.h"
@class Venue, YMFFSLocationVO;

@interface Location : NLS_BaseManagedObject

@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lng;
@property (nonatomic, retain) Venue *venue;

@end
