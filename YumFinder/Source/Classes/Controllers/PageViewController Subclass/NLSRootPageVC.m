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
#import "YMFFSRestaurantVO.h"
#import "InstagramEngine.h"
#import "YMFFSquareResultManager.h"
#define kQUEUE_SIZE 3

@interface NLSRootPageVC ()
{
    NSMutableArray *pageQueue;
    UIActivityIndicatorView *activityIndicator;
}
@end
@implementation NLSRootPageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDelegate:self];
    [self setDataSource:self];
    
    self.currentIndex = 0;
    [self setBackgroundImage:[UIImage imageNamed:@"skin_square"]];
    pageQueue = [[NSMutableArray alloc]initWithCapacity:kQUEUE_SIZE];
    return;
    
//    NLSRootPageVC *__weak _weakSelf = self;
    YMFFSquareResultManager *fsManager = [YMFFSquareResultManager new];

    [self.venues enumerateObjectsUsingBlock:^(YMFFSRestaurantVO *venue, NSUInteger index, BOOL *stop){
        
        [fsManager fetchInstagramImagesForVenue:venue
                                             withCallBack:^(id result) {
                                                 venue.media = result;
//                                                 [_weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:index]];

                                             } onFailure:^(id result) {
                                                 
                                             }];
    }];

    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
-(void)__viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    NLSRootPageVC *__weak _weakSelf = self;
    NLSPageViewController *page =(NLSPageViewController *) [self viewControllerAtIndex:self.currentIndex];
    page.data = _weakSelf.venues[(self.currentIndex==NSNotFound)?0:self.currentIndex];
    [pageQueue addObject:page];
    [_weakSelf setViewControllers:@[page]
                        direction:UIPageViewControllerNavigationDirectionForward
                         animated:YES
                       completion:^(BOOL finished) {
                           NSLog(@"complete block");
                       }];
    
}
-(void)_viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NLSRootPageVC *__weak _weakSelf = self;

    [_weakSelf.venues removeAllObjects];
                       [_weakSelf.venues addObjectsFromArray:self.venues];

                       dispatch_async(dispatch_get_main_queue(), ^{
                           [activityIndicator stopAnimating];
                           [activityIndicator setHidden:YES];

                           NLSPageViewController *page = [_weakSelf.storyboard instantiateViewControllerWithIdentifier:@"NLSPageViewController"];
                           page.tag = 0;
                           page.index =0;
                           page.data = [_weakSelf.venues firstObject];
                           [pageQueue addObject:page];
                           [_weakSelf setViewControllers:@[page]
                                               direction:UIPageViewControllerNavigationDirectionForward
                                                animated:YES
                                              completion:^(BOOL finished) {
                                                  NSLog(@"complete block");
                                              }];
                       });
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Conv Methods
-(UIViewController *)viewControllerAtIndex:(NSUInteger)index{
    
    NSUInteger retIndex = index % kQUEUE_SIZE;
    
    
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
    NSLog(@"\n\n SETTING UP After VC");
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
//#pragma mark - UIPageViewControllerDelegate Methods
//-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{
//
//}
//-(void)pageViewController:(UIPageViewController *)pageViewController
//       didFinishAnimating:(BOOL)finished
//  previousViewControllers:(NSArray *)previousViewControllers
//      transitionCompleted:(BOOL)completed{
//    if (completed && finished) {
////        [(NLSPageViewController *)previousViewControllers setData:nil];
//    }
//}


#pragma mark - Network Methods
-(void) session_invokeURL:(NSString *)serviceURL
               withParams:(NSDictionary *)params
                 callback:(GKBlock)callback{
    
    //    NSLog(@"dataTask about to be killed: %@", self.dataTask);
    //    [self.dataTask cancel];
    //    self.dataTask = nil;
    
    NSLog(@"URL: %@", serviceURL);
    NSURL *url = [NSURL URLWithString:serviceURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
       [urlRequest setHTTPMethod:@"GET"];
    //    [urlRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];

    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       if(error){
                                                           callback(NO,[error userInfo][@"NSLocalizedDescription"]);
                                                           return;
                                                       }
                                                       NSMutableDictionary *responsDic = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]];
                                                           callback(YES, responsDic[@"body"]);
                                                   }];
    [task resume];
  }


@end
