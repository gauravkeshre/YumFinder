//
//  YMFFSLocationVO.h
//  YumFinder
//
//  Created by Gaurav Keshre on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMFBaseVO.h"
@interface YMFFSLocationVO : YMFBaseVO
@property BOOL isVerified;

@property unsigned long distance;
@property(nonatomic, strong)NSString *lat;
@property(nonatomic, strong)NSString *lng;


@end
