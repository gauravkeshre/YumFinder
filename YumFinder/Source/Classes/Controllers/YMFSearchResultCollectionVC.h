//
//  YMFSearchResultCollectionVC.h
//  GKColelctionViewDemo
//
//  Created by Summer Green on 10/2/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#define  TEMP_URL_1 @"http://www.json-generator.com/api/json/get/bZqLQrUule?indent=2"
#define TEMP_URL_2 @"http://www.json-generator.com/api/json/get/bXHMxbPIwO?indent=2"
#define TEMP_URL @"http://www.json-generator.com/api/json/get/bOjbENBnWW?indent=2"

typedef void(^GKBlock)(BOOL b, id data);

@interface YMFSearchResultCollectionVC : UICollectionViewController
@property  (nonatomic, strong)NSArray *foursquareArray;
@end
