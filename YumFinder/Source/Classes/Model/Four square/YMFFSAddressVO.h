//
//  YMFFSAddressVO.h
//  YumFinder
//
//  Created by Gaurav Keshre on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMFBaseVO.h"

@interface YMFFSAddressVO : YMFBaseVO
@property(nonatomic, strong)NSString *city;
@property(nonatomic, strong)NSString *cc;
@property(nonatomic, strong)NSString *country;
@property(nonatomic, strong)NSString *postalCode;
@property(nonatomic, strong)NSString *state;

@property(nonatomic, strong)NSString *formalAddress;
@property(nonatomic, strong)NSString *crossStreet;
@property(nonatomic, strong)NSString *streetAddress;

@end
