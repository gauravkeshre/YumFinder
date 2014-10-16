//
//  YMFAdvanceSearchTVC.h
//  YumFinder
//
//  Created by Summer Green on 10/2/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ENUM(NSUInteger, YMFSearchParamType){
    YMFSearchParamTypeCuisine = 100,
    YMFSearchParamTypeDistnce,
    YMFSearchParamTypeAddress,
    YMFSearchParamTypeRating,
    YMFSearchParamTypePrice
};
@interface YMFAdvanceSearchTVC : UITableViewController<UITextFieldDelegate>

@end
