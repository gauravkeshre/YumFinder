//
//  NSManagedObject+EasyFetching.m
//  Nimar Labs
//
//  Created by Summer Green on 6/20/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "NSManagedObject+EasyFetching.h"

@implementation NSManagedObject (EasyFetching)

+ (NSEntityDescription *)entityDescriptionInContext:(NSManagedObjectContext *)context;
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    return [self respondsToSelector:@selector(entityInManagedObjectContext:)] ?
    [self performSelector:@selector(entityInManagedObjectContext:) withObject:context] :
#pragma clang diagnostic pop
 
    [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:context];
}

+ (NSArray *)findAllObjects;
{
    return nil;
//    NSManagedObjectContext *context = [DMOS_CoreDataManager mainManagedObjectContext];
//    return [self findAllObjectsInContext:context];
}

+ (NSArray *)findAllObjectsInContext:(NSManagedObjectContext *)context;
{
    NSEntityDescription *entity = [self entityDescriptionInContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (error != nil)
    {
        //handle errors
    }
    return results;
}
@end
