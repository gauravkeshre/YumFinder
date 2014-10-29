//
//  Address.h
//  YumFinder
//
//  Created by Green Summer on 10/12/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NLS_BaseManagedObject.h"
@class Venue;
@class YMFFSAddressVO;
@interface Address : NLS_BaseManagedObject

@property (nonatomic, retain) NSString * cc;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * crossStreet;
@property (nonatomic, retain) NSString * formalAddress;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * streetAddress;
@property (nonatomic, retain) Venue *venue;

@end
