//
//  DMOS_BaseManagedObject.m
//  DMOS
//
//  Created by Summer Green on 6/15/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "DMOS_BaseManagedObject.h"

@implementation DMOS_BaseManagedObject
@synthesize traversed;


+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moContext
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                               inManagedObjectContext:moContext];
}

+ (NSString *)entityName{
    
    NSString *strEntityName;
    
    if ([self respondsToSelector:@selector(entityName)])
    {
        strEntityName = NSStringFromClass(self);
    }
    
    if ([strEntityName length] == 0) {
        strEntityName = NSStringFromClass(self);
    }
    
    return strEntityName;
}
- (NSDictionary*) toDictionary
{
    self.traversed = YES;
    
    NSArray* attributes = [[[self entity] attributesByName] allKeys];
    NSArray* relationships = [[[self entity] relationshipsByName] allKeys];
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:
                                 [attributes count] + [relationships count] + 1];
    
    [dict setObject:[[self class] description] forKey:@"class"];
    
    for (NSString* attr in attributes) {
        NSObject* value = [self valueForKey:attr];
        
        if (value != nil) {
            [dict setObject:value forKey:attr];
        }
    }
    
    for (NSString* relationship in relationships) {
        NSObject* value = [self valueForKey:relationship];
        
        if ([value isKindOfClass:[NSSet class]]) {
            // To-many relationship
            
            // The core data set holds a collection of managed objects
            NSSet* relatedObjects = (NSSet*) value;
            
            // Our set holds a collection of dictionaries
            NSMutableSet* dictSet = [NSMutableSet setWithCapacity:[relatedObjects count]];
            
            for (DMOS_BaseManagedObject* relatedObject in relatedObjects) {
                if (!relatedObject.traversed) {
                    [dictSet addObject:[relatedObject toDictionary]];
                }
            }
            
            [dict setObject:dictSet forKey:relationship];
        }
        else if ([value isKindOfClass:[DMOS_BaseManagedObject class]]) {
            // To-one relationship
            
            DMOS_BaseManagedObject* relatedObject = (DMOS_BaseManagedObject*) value;
            
            if (!relatedObject.traversed) {
                // Call toDictionary on the referenced object and put the result back into our dictionary.
                [dict setObject:[relatedObject toDictionary] forKey:relationship];
            }
        }
    }
    
    return dict;
}
@end
