//
//  NLSRootPageVC.h
//  GKPageControlDemo
//
//  Created by Green Summer on 9/27/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#define  TEMP_URL_1 @"http://www.json-generator.com/api/json/get/bZqLQrUule?indent=2"
#define TEMP_URL_2 @"http://www.json-generator.com/api/json/get/bXHMxbPIwO?indent=2"
//#define TEMP_URL @"http://www.json-generator.com/api/json/get/cdmWETUfxe?indent=2"

typedef void(^GKBlock)(BOOL b, id data);

@interface NLSRootPageVC : UIPageViewController <UIPageViewControllerDataSource , UIPageViewControllerDelegate>

@property(nonatomic, strong)NSMutableArray *venues;
@property NSUInteger currentIndex;

-(void) session_invokeURL:(NSString *)serviceURL
               withParams:(NSDictionary *)params
                 callback:(GKBlock)callback;
@end
