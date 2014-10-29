//
//  SWCoreDataStack.h
//  Yumfinder
//
//  Created by Summer Green on 8/1/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWCoreDataStack : NSObject
@property (nonatomic, strong, readonly)NSURL *storeURL;
@property (nonatomic, strong, readonly)NSURL *modelURL;
@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;

-(void)clean;

@end
