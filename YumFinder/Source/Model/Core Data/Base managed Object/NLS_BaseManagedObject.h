//
//  DMOS_BaseManagedObject.h
//  DMOS
//
//  Created by Summer Green on 6/15/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NLS_BaseManagedObject : NSManagedObject

@property(nonatomic)BOOL traversed;
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+ (NSString*)entityName;
- (NSDictionary*) toDictionary;
@end
