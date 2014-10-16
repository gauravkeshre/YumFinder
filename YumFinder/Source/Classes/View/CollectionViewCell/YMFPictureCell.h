//
//  YMFPictureCell.h
//  YumFinder
//
//  Created by Summer Green on 9/26/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

NS_ENUM(NSUInteger, YMFPictureCellType){
    YMFPictureCellTypeUnknown,
    YMFPictureCellTypeInstagram,
    YMFPictureCellTypeGeneral
};
#import <UIKit/UIKit.h>
#import "NLSDataReceiverDelegate.h"
@interface YMFPictureCell : UICollectionViewCell<NLSDataReceiverDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property enum YMFPictureCellType pictureCellType;

@end

/*
 * 
 
 
 [SVProgressHUD show];
 YMFFSquareResultManager *manager = [YMFFSquareResultManager new];
 YMFSearchLandingVC *__weak _weakSelf = self;
 [manager fetchInstagramImagesForVenue:self.currentVenue withCallBack:^(id result) {
 [SVProgressHUD dismiss];
 [_weakSelf.venues[indexPath.row] setMedia:media];
 [_weakSelf.imagesCollectionView reloadData];
 } onFailure:^(id result) {
 [SVProgressHUD dismiss];
 NSLog(@"ERROR---%@", result);
 }];

 */