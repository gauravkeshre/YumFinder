//
//  NLSActivityViewHUD.m
//  Restaurage
//
//  Created by Summer Green on 9/20/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import "NLSActivityViewHUD.h"

#define kIMG_ERROR      @"ico_exclamation"
#define kIMG_OFFLINE    @"ico_offline"
#define kIMG_SUCCESS    @"ico_succes"
#define kHUD_TEXT_COLOR [UIColor colorWithRed:155.0/255.0 green:156.0/255.0 blue:156.0/255.0 alpha:1.0]

#define kTOTAL_FRAMES kNumberOfBubbleFrames
@interface NLSActivityViewHUD()
{
    NSTimer *timer;
    NSInteger delay;
    BOOL initialScrollEnabled;
}
@end
@implementation NLSActivityViewHUD
-(void)dealloc{
    self.titleLabel = nil;
    self.lblTapToReload = nil;
    self.icon = nil;
    [timer invalidate];
    timer = nil;
}

+(instancetype)activityOnView:(UIView *)view{
    NSString *nibName = NSStringFromClass([self class]);
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    for (UIView *subv in view.subviews) {
        if ([subv isKindOfClass:[self class]]) {
            [subv removeFromSuperview];
        }
    }
    NLSActivityViewHUD *hhud = (NLSActivityViewHUD *)[subviewArray objectAtIndex:0];
    
    if ([view respondsToSelector:@selector(setScrollEnabled:)]) {
        hhud->initialScrollEnabled =  [(UIScrollView *)view isScrollEnabled];
        [(UIScrollView *)view setScrollEnabled:NO];
    }
    hhud->delay = 0;
    
    hhud.alpha =0.0;
    [view addSubview:hhud];
    [hhud setFrame:view.bounds];//CGRectInset(view.bounds, 0, 100)];
    UIResponder* nextResponder = [view nextResponder];
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0") && ![[(UIViewController *)nextResponder parentViewController] isKindOfClass:[UIPageViewController class]] && hhud.frame.origin.y == 0){
        hhud.center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds)-64.f);
    }
    [UIView animateWithDuration:0.24
                     animations:^{
                         hhud.alpha = 1;
                     } completion:nil];
    return hhud;
}
#pragma mark - Public instance Methods

-(void)showMessage:(NSString *)string Icon:(NSString *)iconname mode:(NLSActivityMode)mode{
    CGRect frame = self.titleLabel.frame;
    CGSize sz = [string sizeWithFont:self.titleLabel.font forWidth:frame.size.width lineBreakMode:NSLineBreakByWordWrapping];
    frame.size.height = sz.height;
    [self.titleLabel setFrame:frame];
    self.titleLabel.text = string;
    self.icon.image = [UIImage imageNamed:iconname];
    [self setActivityMode:mode];
}


-(void)showErrorWithMessage:    (NSString *)string;{
    [self showMessage:string Icon:kIMG_ERROR mode:NLSActivityModeOnlyIconWithMessage];
}

-(void)showSuccussEithMessage:(NSString *)string
{
    [self showMessage:string Icon:kIMG_SUCCESS mode:NLSActivityModeOnlyIconWithMessage];
}
-(void)showOfflineEithMessage:(NSString *)string
{
    [self showMessage:string Icon:kIMG_OFFLINE mode:NLSActivityModeOnlyIconWithMessage];
}

-(void)showLoadingWithMessage:(NSString *)string
{
    [self showMessage:string Icon:kIMG_SUCCESS mode:NLSActivityModeLoading];
}

#pragma mark - Public static Methods
+(instancetype)showLoadingWithMessage:(NSString *)string inView:(UIView *)view
{
    NLSActivityViewHUD *hhud =[NLSActivityViewHUD activityOnView:view];
    [hhud showLoadingWithMessage:string];
    return hhud;
}
+(instancetype)showErrorWithMessage:(NSString *)string inView:(UIView *)view
{
    NLSActivityViewHUD *hhud =[NLSActivityViewHUD activityOnView:view];
    [hhud showErrorWithMessage:string];
    return hhud;
}
+(instancetype)showSuccussEithMessage:(NSString *)string inView:(UIView *)view
{
    NLSActivityViewHUD *hhud =[NLSActivityViewHUD activityOnView:view];
    [hhud showSuccussEithMessage:string];
    return hhud;
}
+(instancetype)showOfflineEithMessage:(NSString *)string inView:(UIView *)view
{
    NLSActivityViewHUD *hhud =[NLSActivityViewHUD activityOnView:view];
    [hhud showOfflineEithMessage:string];
    return hhud;
}
#pragma mark - Custom Setter Methods
-(void)setActivityMode:(NLSActivityMode)activityMode{
    
    [self.lblTapToReload  setHidden:NO];
    [self.titleLabel setHidden:NO];
    [self.titleLabel setTextColor:kHUD_TEXT_COLOR];
    [self.btnTapToReload setHidden:NO];
    [self.icon setHidden:NO];
    [self.animatedIcon setHidden:NO];
    [self.animatedIcon stopAnimating];
    switch (activityMode) {
        case NLSActivityModeLoading:{
            [self.animatedIcon setAnimationImages:[self imagesForAnimation]];
            [self.animatedIcon setAnimationDuration:2];
            [self.animatedIcon setAnimationRepeatCount:0];
            [self.animatedIcon startAnimating];
            [self.lblTapToReload  setHidden:YES];
            [self.btnTapToReload setHidden:YES];
            [self.titleLabel setTextColor:[UIColor appYellowColor]];
            [self.icon setHidden:YES];
            [self.titleLabel setHidden:YES];
        }
            break;
        case NLSActivityModeOnlyMessge:{
            [self.icon setHidden:YES];
        }
            break;
        case NLSActivityModeOnlyIcon:
        {
            [self.titleLabel setHidden:YES];
        }
            break;
        case NLSActivityModeOnlyIconWithMessage:
        {
            [self.animatedIcon setHidden:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - IBAction Methods
- (IBAction)handleTap:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(activityView:didTapOnRetryFromMode:)]) {
        [self.delegate activityView:self didTapOnRetryFromMode:self.activityMode];
    }
}

#pragma mark - Convenience Methods
-(NSArray *)imagesForAnimation{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:kTOTAL_FRAMES];
    for (NSInteger i=1; i<=kTOTAL_FRAMES; i++) {
//        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"speakle-load-%li.png", (long)i]]];
    }
    return arr;
}
-(void)tik:(NSTimer *)sender{
}

-(void)startLoagingTextAnimation{
    
    [timer invalidate];
    timer= nil;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(tik:) userInfo:nil repeats:YES];
}
-(void)stopLoagingTextAnimation{
    delay =0;
    [timer invalidate];
    timer = nil;
    //[self.titleLabel setText:@"Loading..."];
}

-(void)dismiss{
    // [self.wobbleView stopAnimation];
    if ([self.superview respondsToSelector:@selector(setScrollEnabled:)]) {
        [(UIScrollView *)self.superview setScrollEnabled:YES];
    }
    [UIView animateWithDuration:0.24
                     animations:^{
                         self.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         if (finished) {
                             [self removeFromSuperview];
                         }
                     }];
}

@end