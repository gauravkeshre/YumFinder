//
//  YMFSearchLandingVC.h
//  YumFinder
//
//  Created by Summer Green on 9/23/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ENUM(NSUInteger, YMFCollectionViewindex){
    YMFCollectionViewPictures=100,
    YMFCollectionViewCategories =120
};
@interface YMFSearchLandingVC : UITableViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong)NSArray *venues; //array of venues


@end
