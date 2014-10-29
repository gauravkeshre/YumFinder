//
//  YMFImageDownloadOperation.m
//  YumFinder
//
//  Created by Green Summer on 10/6/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFImageDownloadOperation.h"

@implementation YMFImageDownloadOperation

-(void)main{
    @autoreleasepool {
        if (self.isCancelled) {
            return;
        }
        
        [self performMain];
    }
}

-(void)performMain{
    
    
}

@end
