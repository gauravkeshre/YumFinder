//
//  DMOS_CoreDataManager.m
//  DMOS
//
//  Created by Summer Green on 6/13/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "DMOS_CoreDataManager.h"
#import <CoreData/CoreData.h>

static DMOS_CoreDataManager *privateManager;


@implementation DMOS_CoreDataManager


#pragma mark - Singleton

+ (DMOS_CoreDataManager *)privateInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        privateManager = [DMOS_CoreDataManager new];
    });
    return privateManager;
}

#pragma mark - Public API Methods

+ (NSManagedObjectContext *)mainManagedObjectContext{
    return [[DMOS_CoreDataManager privateInstance] managedObjectContext];
}

#pragma mark - Retrieve objects
+(NSMutableArray *)searchObjectsForEntity:(NSString*)entityName
                            withPredicate:(NSPredicate *)predicate
                               andSortKey:(NSString*)sortKey
                         andSortAscending:(BOOL)sortAscending{
    return [[self class] searchObjectsForEntity:entityName
                                  withPredicate:predicate
                                     andSortKey:sortKey
                               andSortAscending:sortAscending
                                     andContext:[[self class] mainManagedObjectContext]];
}
// Fetch objects with a predicate
+(NSMutableArray *)searchObjectsForEntity:(NSString*)entityName
                            withPredicate:(NSPredicate *)predicate
                               andSortKey:(NSString*)sortKey
                         andSortAscending:(BOOL)sortAscending
                               andContext:(NSManagedObjectContext *)managedObjectContext
{
	// Create fetch request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	// If a predicate was specified then use it in the request
	if (predicate != nil)
		[request setPredicate:predicate];
	
	// If a sort key was passed then use it in the request
	if (sortKey != nil) {
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:sortAscending];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[request setSortDescriptors:sortDescriptors];
	}
	
	// Execute the fetch request
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    request = nil;
	// If the returned array was nil then there was an error
	if (mutableFetchResults == nil)
		NSLog(@"Couldn't get objects for entity %@", entityName);
	
	// Return the results
	return mutableFetchResults;
}

// Fetch objects without a predicate
+(NSMutableArray *)getObjectsForEntity:(NSString*)entityName
                           withSortKey:(NSString*)sortKey
                      andSortAscending:(BOOL)sortAscending{
    return [self getObjectsForEntity:entityName
                         withSortKey:sortKey
                    andSortAscending:sortAscending
                          andContext:[self mainManagedObjectContext]];
}

+(NSMutableArray *)getObjectsForEntity:(NSString*)entityName
                           withSortKey:(NSString*)sortKey
                      andSortAscending:(BOOL)sortAscending
                            andContext:(NSManagedObjectContext *)managedObjectContext{
	return [self searchObjectsForEntity:entityName withPredicate:nil andSortKey:sortKey andSortAscending:sortAscending andContext:managedObjectContext];
}

#pragma mark - Count objects

// Get a count for an entity with a predicate
+(NSUInteger)countForEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate {
    return [self countForEntity:entityName
                  withPredicate:predicate andContext:[self mainManagedObjectContext]];
}

+(NSUInteger)countForEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate andContext:(NSManagedObjectContext *)managedObjectContext
{
	// Create fetch request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	[request setIncludesPropertyValues:NO];
	
	// If a predicate was specified then use it in the request
	if (predicate != nil)
		[request setPredicate:predicate];
	
	// Execute the count request
	NSError *error = nil;
	NSUInteger count = [managedObjectContext countForFetchRequest:request error:&error];
	request= nil;
	// If the count returned NSNotFound there was an error
	if (count == NSNotFound)
		NSLog(@"Couldn't get count for entity %@", entityName);
	
	// Return the results
	return count;
}

// Get a count for an entity without a predicate
+(NSUInteger)countForEntity:(NSString *)entityName{
    return [self countForEntity:entityName withPredicate:nil andContext:[self mainManagedObjectContext]];
}
+(NSUInteger)countForEntity:(NSString *)entityName andContext:(NSManagedObjectContext *)managedObjectContext
{
	return [self countForEntity:entityName withPredicate:nil andContext:managedObjectContext];
}

#pragma mark - Delete Objects

// Delete all objects for a given entity
+(BOOL)deleteAllObjectsForEntity:(NSString*)entityName withPredicate:(NSPredicate*)predicate{
    return [self deleteAllObjectsForEntity:entityName withPredicate:predicate andContext:[self mainManagedObjectContext]];
}

+(BOOL)deleteAllObjectsForEntity:(NSString*)entityName withPredicate:(NSPredicate*)predicate andContext:(NSManagedObjectContext *)managedObjectContext
{
	// Create fetch request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	// Ignore property values for maximum performance
	[request setIncludesPropertyValues:NO];
	
	// If a predicate was specified then use it in the request
	if (predicate != nil)
		[request setPredicate:predicate];
	
	// Execute the count request
	NSError *error = nil;
	NSArray *fetchResults = [managedObjectContext executeFetchRequest:request error:&error];
    request = nil;
    
	// Delete the objects returned if the results weren't nil
	if (fetchResults != nil) {
		for (NSManagedObject *manObj in fetchResults) {
			[managedObjectContext deleteObject:manObj];
		}
	} else {
		NSLog(@"Couldn't delete objects for entity %@", entityName);
		return NO;
	}
	
	return YES;
}

+(BOOL)deleteAllObjectsForEntity:(NSString*)entityName{
    return [self deleteAllObjectsForEntity:entityName andContext:[self mainManagedObjectContext]];
}

+(BOOL)deleteAllObjectsForEntity:(NSString*)entityName andContext:(NSManagedObjectContext *)managedObjectContext
{
	return [self deleteAllObjectsForEntity:entityName withPredicate:nil andContext:managedObjectContext];
}
#pragma mark - SAVE Methods

+(BOOL)saveWithError:(NSError *)err{
    BOOL flag = [[self mainManagedObjectContext] save:&err];
    return flag && (err==nil);
}
@end