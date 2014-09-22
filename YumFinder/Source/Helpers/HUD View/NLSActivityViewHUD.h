//
//  NLSActivityViewHUD.h
//  Restaurage
//
//  Created by Summer Green on 9/20/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>


@class NLSActivityViewHUD;

typedef NS_ENUM(NSUInteger, NLSActivityMode){
    NLSActivityModeLoading,
    NLSActivityModeOnlyIcon,
    NLSActivityModeOnlyMessge,
    NLSActivityModeOnlyIconWithMessage,
};

@protocol SWActivityDelegate <NSObject>

-(void)activityView:(NLSActivityViewHUD *)view didTapOnRetryFromMode:(NLSActivityMode)mode;

@end

@interface NLSActivityViewHUD : UIView
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lblTapToReload;
@property (weak, nonatomic) IBOutlet UIButton *btnTapToReload;
@property (weak, nonatomic) IBOutlet UIImageView *animatedIcon;

@property (weak, nonatomic)id<SWActivityDelegate> delegate;
@property(nonatomic)NLSActivityMode activityMode;


+(instancetype)activityOnView:(UIView *)view;

-(void)showLoadingWithMessage:  (NSString *)string;
-(void)showErrorWithMessage:    (NSString *)string;
-(void)showSuccussEithMessage:  (NSString *)string;
-(void)showOfflineEithMessage:  (NSString *)string;


+(instancetype)showLoadingWithMessage:(NSString *)string inView:(UIView *)view;
+(instancetype)showErrorWithMessage:(NSString *)string inView:(UIView *)view;
+(instancetype)showSuccussEithMessage:(NSString *)string inView:(UIView *)view;
+(instancetype)showOfflineEithMessage:(NSString *)string inView:(UIView *)view;

- (IBAction)handleTap:(id)sender;
-(void)dismiss;
@end
