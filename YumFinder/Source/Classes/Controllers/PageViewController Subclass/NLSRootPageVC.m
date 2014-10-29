//
//  NLSRootPageVC.m
//  GKPageControlDemo
//
//  Created by Green Summer on 9/27/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import "NLSRootPageVC.h"
#import "NLSPageViewController.h"
#import "UIViewController+Additions.h"
#import "InstagramEngine.h"
#import "YMFFSquareResultManager.h"
#import "Venue.h"

#define kQUEUE_SIZE 3

@interface NLSRootPageVC ()<NLSActivityDelegate>
{
    NSMutableArray *pageQueue;
    UIActivityIndicatorView *activityIndicator;
}
@property (nonatomic, strong)NLSActivityViewHUD * activity;
@property BOOL forceReloadNextPage;
@end
@implementation NLSRootPageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDelegate:self];
    [self setDataSource:self];
    [self setBackgroundImage:[UIImage imageNamed:@"skin_square"]];

    self.venues = [Venue findAllSortedBy:nil ascending:YES];
    
    if (self.venues ==nil || self.venues.count<1) {
        
        NLSActivityViewHUD * activity = [NLSActivityViewHUD activityOnView:self.view];
        [activity showErrorWithMessage:@"No Venues Found !!"];
        [activity setDelegate:self];
        
        return;
    }
    self.currentIndex = (self.currentIndex != NSNotFound)?self.currentIndex:0;
    pageQueue = [[NSMutableArray alloc]initWithCapacity:kQUEUE_SIZE];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.venues ==nil || self.venues.count<1) {
        NSLog(@"Error: No venues found");
        return;
    }
    
    NLSRootPageVC *__weak _weakSelf = self;
    NLSPageViewController *page =(NLSPageViewController *) [self viewControllerAtIndex:self.currentIndex];
    page.data = [_weakSelf.venues firstObject];
    [pageQueue addObject:page];
    [_weakSelf setViewControllers:@[page]
                        direction:UIPageViewControllerNavigationDirectionForward
                         animated:YES
                       completion:^(BOOL finished) {
                           NSLog(@"complete block");
                       }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Data Methods

-(void)preloadResults{
    	self.venues = [[Venue findAllSortedBy:nil ascending:YES] mutableCopy];
}

#pragma mark - Conv Methods
-(void)touchStatusBar:(NSNotification *)aNotif{
    NSLog(@"Scroll To top");
    [self scrollToPage:0 animated:YES];
   
}

- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated
{
    if (page != self.currentIndex) {
        [self setViewControllers:@[[self viewControllerAtIndex:page]]
                       direction:(page > self.currentIndex ?
                                  UIPageViewControllerNavigationDirectionForward :
                                  UIPageViewControllerNavigationDirectionReverse)
                        animated:animated
                      completion:nil];
        self.currentIndex = page;
        self.forceReloadNextPage = YES; // to override view controller automatic page cache
    }
}
-(UIViewController *)viewControllerAtIndex:(NSUInteger)index{
    
    NSUInteger retIndex = index % kQUEUE_SIZE;
    self.currentIndex=index;
    NSLog(@"looking for: %lu presented : %lu", (unsigned long)index, (unsigned long)retIndex);
    NLSPageViewController *pageVC = [[pageQueue filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NLSPageViewController *vc, NSDictionary *bindings) {
            return (vc.tag == retIndex);
        }]] firstObject];
    
    if (pageVC)return pageVC;
    
        NSLog(@"Page fault for index: %lu, retIndex: %lu", (unsigned long)index, (unsigned long)retIndex);
    
    /*
     * create new object with that tag and return;
     */
    NLSPageViewController *page = [self.storyboard instantiateViewControllerWithIdentifier:@"NLSPageViewController"];
    page.tag = retIndex;
    [page setIndex:index];
    [pageQueue addObject:page];
    return page;

}

#pragma mark - UIPageViewControllerDataSource Methods
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.venues.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

//AFTER
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = [(NLSPageViewController *)viewController index];
    if (index>= self.venues.count-1) return nil;
        index++;

    NLSPageViewController * __weak page = (NLSPageViewController * )  [self viewControllerAtIndex:index];
    [page setIndex:index];
    [page setData:self.venues[index]];
    return page;
}

//BEFORE
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{

    NSLog(@"\n\n SETTING UP BEFORE VC");
    NSUInteger index = [(NLSPageViewController *)viewController index];
    if (index == 0) {
        return nil;
    }
    index--;

    NLSPageViewController * page = (NLSPageViewController * )  [self viewControllerAtIndex:index];
    [page setIndex:index];
    [page setData:self.venues[index]];
    return page;
}

-(void)pageViewController:(UIPageViewController *)pageViewController
       didFinishAnimating:(BOOL)finished
  previousViewControllers:(NSArray *)previousViewControllers
      transitionCompleted:(BOOL)completed{
    NSLog(@"pageViewController - previousViewControllers");
}

#pragma mark - NLSActivityDelegate
-(void)activityView:(NLSActivityViewHUD *)view didTapOnRetryFromMode:(NLSActivityMode)mode{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
