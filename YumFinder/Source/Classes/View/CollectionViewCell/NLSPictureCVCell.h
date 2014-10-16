//
//  NLSPictureCVCell.h
//  GKPageControlDemo
//
//  Created by Summer Green on 9/28/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLSPictureCVCell : UICollectionViewCell <NLSDataReceiverDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet MRCircularProgressView *activityIndicator;
-(void)resetImages;
@end
