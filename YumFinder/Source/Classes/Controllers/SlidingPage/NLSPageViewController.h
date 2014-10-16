//
//  NLSPageViewController.h
//  GKPageControlDemo
//
//  Created by Green Summer on 9/27/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLSPageViewController : UIViewController<NLSDataReceiverDelegate>

@property NSUInteger index;
@property NSUInteger tag;

@end
