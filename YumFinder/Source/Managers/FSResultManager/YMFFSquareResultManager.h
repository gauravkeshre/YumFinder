//
//  YMFFSquareResultManager.h
//  YumFinder
//
//  Created by Gaurav Keshre on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMFFSquareResultManager : NSObject

-(void)parseResultFromArray:(NSArray *)array onSuccess:(YMF_SuccessCallback)callback;
@end
