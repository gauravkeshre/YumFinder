//
//  YMFFSVenueCategoryVO.m
//  YumFinder
//
//  Created by Gaurav Keshre on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFFSVenueCategoryVO.h"

@implementation YMFFSVenueCategoryVO


+(instancetype)initWithDictionary:(NSDictionary *)d{
    YMFFSVenueCategoryVO *category = [YMFFSVenueCategoryVO new];
    
    [category setPluralName:d[fsPLURALNAME]];
    [category setIsPrimary:[d[fsPRIMARY] boolValue]];
    [category setCategoryID:d[fsID]];
    [category setShortName:d[fsSHORTNAME]];
    [category setCategoryName:d[fsNAME]];
    [category setPrefix:d[fsICON][fsPREFIX]];
    [category setSuffix:d[fsICON][fsSUFFIX]];
    return category;
}
-(NSString *)iconURLWithSize:(CGFloat)size{
    return [NSString stringWithFormat:@"%@%f%@", self.prefix, size, self.suffix];
}
@end


/*
 * {
 "pluralName":"Sushi Restaurants",
 "primary":true,
 "name":"Sushi Restaurant",
 "shortName":"Sushi",
 "id":"4bf58dd8d48988d1d2941735",
 "icon":{
    "prefix":"https://ss1.4sqi.net/img/categories_v2/food/sushi_",
    "suffix":".png"
 }
 */