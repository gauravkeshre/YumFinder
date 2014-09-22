//
//  DMOS_CoreDataManager.h
//  DMOS
//
//  Created by Summer Green on 6/13/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWCoreDataStack.h"
@class SWCoreDataStack;
#pragma mark - custom block
typedef void (^SW_SuccessCallback)  (id result);


@interface DMOS_CoreDataManager : SWCoreDataStack

@property(nonatomic, strong, readonly)SWCoreDataStack *coreDataStack;
+ (NSManagedObjectContext *)mainManagedObjectContext;

// For deletion of objects


+(BOOL)saveWithError:(NSError *)err;

#pragma mark - Search Methods
+(NSMutableArray *)getObjectsForEntity:(NSString*)entityName
                           withSortKey:(NSString*)sortKey
                      andSortAscending:(BOOL)sortAscending;

+(NSMutableArray *)searchObjectsForEntity:(NSString*)entityName
                            withPredicate:(NSPredicate *)predicate
                               andSortKey:(NSString*)sortKey
                         andSortAscending:(BOOL)sortAscending;

+(NSMutableArray *)getObjectsForEntity:(NSString*)entityName
                           withSortKey:(NSString*)sortKey
                      andSortAscending:(BOOL)sortAscending
                            andContext:(NSManagedObjectContext *)managedObjectContext;

+(NSMutableArray *)searchObjectsForEntity:(NSString*)entityName
                            withPredicate:(NSPredicate *)predicate
                               andSortKey:(NSString*)sortKey
                         andSortAscending:(BOOL)sortAscending
                               andContext:(NSManagedObjectContext *)managedObjectContext;


#pragma mark - COUNT 
+(NSUInteger)countForEntity:(NSString *)entityName;
+(NSUInteger)countForEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate;

+(NSUInteger)countForEntity:(NSString *)entityName andContext:(NSManagedObjectContext *)managedObjectContext;
+(NSUInteger)countForEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate andContext:(NSManagedObjectContext *)managedObjectContext;

#pragma mark - DELETE
+(BOOL)deleteAllObjectsForEntity:(NSString*)entityName withPredicate:(NSPredicate*)predicate;
+(BOOL)deleteAllObjectsForEntity:(NSString*)entityName;

+(BOOL)deleteAllObjectsForEntity:(NSString*)entityName andContext:(NSManagedObjectContext *)managedObjectContext;

+(BOOL)deleteAllObjectsForEntity:(NSString*)entityName withPredicate:(NSPredicate*)predicate andContext:(NSManagedObjectContext *)managedObjectContext;

@end
