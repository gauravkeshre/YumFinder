//
//  YMFVenueHeaderCVC.h
//  GKColelctionViewDemo
//
//  Created by Summer Green on 10/2/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMFVenueHeaderCVC;
@protocol YMFVenueHeaderDelegate <NSObject>

-(void)venueHeader:(YMFVenueHeaderCVC *)header didSelectAtIndex:(NSIndexPath *)indexPath;

@end
@interface YMFVenueHeaderCVC : UICollectionReusableView

@property (weak, nonatomic)id<YMFVenueHeaderDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) NSIndexPath *indexPath;
@end
