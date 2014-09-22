//
//  NSManagedObject+EasyFetching.h
//  Nimar Labs
//
//  Created by Summer Green on 6/20/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (EasyFetching)
+ (NSEntityDescription *)entityDescriptionInContext:(NSManagedObjectContext *)context;
+ (NSArray *)findAllObjects;
+ (NSArray *)findAllObjectsInContext:(NSManagedObjectContext *)context;

@end
