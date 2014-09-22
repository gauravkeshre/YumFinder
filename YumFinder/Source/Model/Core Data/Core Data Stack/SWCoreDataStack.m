//
//  SWCoreDataStack.m
//  DiamondOffshore
//
//  Created by Summer Green on 8/1/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "SWCoreDataStack.h"
#import <CoreData/CoreData.h>

@interface SWCoreDataStack()
@property (nonatomic, strong, readwrite) NSManagedObjectModel *managedObjectModel;
@end

@implementation SWCoreDataStack

-(void)dealloc{
    //NSLog(@"dealloced SWCoreDataStack");
}
#pragma mark - MOC factory Methods
- (NSManagedObjectContext *)setupManagedObjectContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType
{
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:concurrencyType];
    managedObjectContext.persistentStoreCoordinator =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSError* error;
    
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES,
                              NSInferMappingModelAutomaticallyOption:@YES};
    
    [managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                  configuration:nil
                                                                            URL:[self storeURL]
                                                                        options:options
                                                                          error:&error];
    if (error) {
        //NSLog(@"error: %@", error.localizedDescription);
        //NSLog(@"rm \"%@\"", self.storeURL.path);
    }
    return managedObjectContext;
}

#pragma mark - Stack Methods

#pragma mark MOM
- (NSManagedObjectModel*)managedObjectModel
{
    if(_managedObjectModel !=nil){
        return _managedObjectModel;
    }
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
    return _managedObjectModel;
}
#pragma mark MOC
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    NSError *error = nil;;
    
    /*
     * NOTE: need to add this only when the migeration is commensed.
     *     NSDictionary *options = @{
     NSMigratePersistentStoresAutomaticallyOption : @YES,
     NSInferMappingModelAutomaticallyOption : @YES
     };

     */
    [_managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                   configuration:nil
                                                                             URL:[self storeURL]
                                                                         options:nil
                                                                           error:&error];
    
    if (error) {
        //NSLog(@"Error: %@", error.debugDescription);
        return nil;
    }
    
    return _managedObjectContext;
}

#pragma mark - Core data URLs Methods

- (NSURL*)storeURL{
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    return [documentsDirectory URLByAppendingPathComponent:@"DiamondOffshore.sqlite"];
}

- (NSURL*)modelURL
{
    return [[NSBundle mainBundle] URLForResource:@"DiamondOffshore" withExtension:@"momd"];
}

-(void)clean{
    self.managedObjectContext = nil;
    self.managedObjectModel = nil;
    
}
@end
