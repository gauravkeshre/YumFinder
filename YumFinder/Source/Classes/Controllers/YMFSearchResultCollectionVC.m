//
//  YMFSearchResultCollectionVC.m
//  GKColelctionViewDemo
//
//  Created by Summer Green on 10/2/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFSearchResultCollectionVC.h"
#import "NLSPictureCVCell.h"
#import "YMFVenueHeaderCVC.h"
#import "NLSFSVenueVO.h"
#import "YMFFSRestaurantVO.h"
#import "YMFImagesFromHashtagOperation.h"
#import "YMFFSquareResultManager.h"
#import "UIImageView+AFNetworking.h"
#import "InstagramMedia.h"
#import "NLSRootPageVC.h"
@interface YMFSearchResultCollectionVC ()<YMFVenueHeaderDelegate>

@property (nonatomic) CGFloat originalOrigin;
@property (nonatomic, weak)UIView *floatingView;
@property (nonatomic, strong)YMFFSquareResultManager *fsManager;
@end


@implementation YMFSearchResultCollectionVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat height = [[UIScreen mainScreen]bounds].size.height;
    
    self.originalOrigin = height-70.f;
    [self fetchImageURLsFromInstagram];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGSize originalContentSize = self.collectionView.contentSize;
    //    originalContentSize.height+=200.f;
    self.collectionView.contentSize =originalContentSize;
    
    [self prepareFloatingView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Synthesize Methods
-(YMFFSquareResultManager *)fsManager{
    if (_fsManager==nil) {
        _fsManager = [YMFFSquareResultManager new];
    }
    return _fsManager;
}
#pragma mark - FetchInstagramimages Methods
-(void)fetchImageURLsFromInstagram{
    if (self.foursquareArray==nil || self.foursquareArray.count<1) {
        return;
    }
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue setName:@"hashTagQueue"];
    [queue setMaxConcurrentOperationCount:5];
    
    
    /*
     *         YMFImagesFromHashtagOperation *op = [[YMFImagesFromHashtagOperation alloc]initWithHashTag:venue.hashTag andVenueID:venue.venueID];
     
     [op setObservationInfo:(__bridge void *)(venue.venueID)];
     
     NSLog(@"______");
     NSLog(@"Venue hashTag: #%@", venue.hashTag);
     NSLog(@"Venue Venue ID: %@", venue.venueID);
     NSLog(@"_");
     [queue addOperation:op];
     op = nil;
     }];
     
     */
    YMFSearchResultCollectionVC *__weak _weakSelf = self;
    [self.foursquareArray enumerateObjectsUsingBlock:^(YMFFSRestaurantVO *venue,
                                                       NSUInteger index,
                                                       
                                                       BOOL *stop){
        
        [_weakSelf.fsManager fetchInstagramImagesForVenue:venue
                                             withCallBack:^(id result) {
                                                     venue.media = result;
                                                  [_weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:index]];
                                             } onFailure:^(id result) {
                                                 
                                             }];
    }];
}

#pragma mark - Network Methods
-(void) local_session_invokeURL:(NSString *)serviceURL
                     withParams:(NSDictionary *)params
                       callback:(GKBlock)callback{
    //    NSData *data = [[NSData alloc]initWithContentsOfFile:@"sample.json"];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"sample" ofType:@"json"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:path
                                                 options:kNilOptions
                                                   error:nil];
    NSMutableDictionary *responsDic = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]];
    callback(YES, responsDic[@"body"]);
    
}
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
    //    self.dataTask = task;
    //    [self.dataTask resume];
    //    NSLog(@"dataTask resumed: %@", self.dataTask);
    
}

#pragma mark - FloatingView Methods
-(void)prepareFloatingView{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10.f, 10.f, 60, 60)];
    [button addTarget:self action:@selector(handleFloatingButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"ico_arrow-white-left"] forState:UIControlStateNormal];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(170.f, 10.f,140.f, 42.f)];
    [imageView setImage:[UIImage imageNamed:@"logo_blue"]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(0,0, [[UIScreen mainScreen]bounds].size.width, 120)];
    [v2 setBackgroundColor:[UIColor blackColor]];
    [v2 setAlpha:0.6];
    
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.originalOrigin, [[UIScreen mainScreen]bounds].size.width, 120)];
    
    [v1 setBackgroundColor:[UIColor clearColor]];
    [v1 addSubview:v2];
    [v1 addSubview:imageView];
    [v1 addSubview:button];
    
    [self.view addSubview:v1];
    self.floatingView = v1;
    v2= nil;
    imageView = nil;
    button = nil;
    v1 = nil;
    
    [self.collectionView reloadData];

}

#pragma mark - IBAction Methods
-(void)handleFloatingButton:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIScrollViewDelegate Methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    return;
    CGRect tableBounds = scrollView.bounds;
    CGRect floatingButtonFrame = self.floatingView.frame;
    floatingButtonFrame.origin.y = tableBounds.origin.y + self.originalOrigin;
    self.floatingView.frame = floatingButtonFrame;
}


#pragma mark - Collectionview Methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //    return self.fsArray.count;
    return (self.foursquareArray.count >0)?self.foursquareArray.count+1:0;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return (section ==self.foursquareArray.count)?1: fmin(4, [[(YMFFSRestaurantVO *)self.foursquareArray[section]media] count]);
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    __block NLSPictureCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NLSPictureCVCell" forIndexPath:indexPath];
    
    if (indexPath.section ==self.foursquareArray.count) {
        [cell.imageView setHidden:YES];
        return cell;
    }
    [cell.imageView setHidden:NO];
    InstagramMedia *media = (InstagramMedia*)[(YMFFSRestaurantVO *)self.foursquareArray[indexPath.section] media][indexPath.row];
    
//    [cell.imageView setImageWithURL:media.thumbnailURL placeholderImage:[UIImage imageNamed:@"placeholder_texture_brown"]];
    NSURLRequest *req = [NSURLRequest requestWithURL:media.thumbnailURL];
    
    [cell.imageView setImageWithURLRequest:req
                          placeholderImage:[UIImage imageNamed:@"placeholder_texture_brown"]
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       cell.imageView.image = image;
                                   } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                      cell.imageView.image = [UIImage imageNamed:@"error_y"];
                                   }];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    
    
    if (kind == UICollectionElementKindSectionHeader) {
        YMFVenueHeaderCVC *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YMFVenueHeaderCVC" forIndexPath:indexPath];
        
        
        if (indexPath.section ==self.foursquareArray.count) {
            [headerView.button setTitle:@"" forState:UIControlStateNormal];
        }else{
            YMFFSRestaurantVO *venue = (YMFFSRestaurantVO *)self.foursquareArray[indexPath.section];
            NSString *finalTitle = [NSString stringWithFormat:@"%li. #%@", indexPath.section+1, venue.hashTag];
            [headerView.button setTitle:finalTitle forState:UIControlStateNormal];
            [headerView setIndexPath:indexPath];
            [headerView setDelegate:self];
            
        }
        reusableview = headerView;
    }
    return reusableview;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"did select called");
}

- (NSArray *)laysadasdasoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [NSMutableArray new];
    
    NSIndexPath *decorationIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    UICollectionViewLayoutAttributes *decorationAttributes =
    
    [UICollectionViewLayoutAttributes
     layoutAttributesForDecorationViewOfKind:@"BackgroundView"
     withIndexPath:decorationIndexPath];
    
    decorationAttributes.frame = CGRectMake(0.0f,
                                            0.0f,
                                            self.collectionView.contentSize.width,
                                            self.collectionView.contentSize.height);
    
    //    [allAttributes addObject:decorationAttributes];
    
    
    return attributes;
}
- (CGSize)collectionViewContentSize
{
    
    CGSize size = self.collectionView.contentSize;
    size.height+=70;
    return size;
    //
    //    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    //    NSInteger pages = ceil(itemCount / 16.0);
    //
    //    return CGSizeMake(320 * pages, self.collectionView.frame.size.height);
}

#pragma mark - YMFVenueHeaderDelegate Methods
-(void)venueHeader:(YMFVenueHeaderCVC *)header didSelectAtIndex:(NSIndexPath *)indexPath{
    NSLog(@"did select header at index: %@ \n\n--------\n %@", indexPath, self.foursquareArray[indexPath.section]);
    
    [self performSegueWithIdentifier:@"push_segue_search_detailresult" sender:@(indexPath.section)];
    
}
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     NLSRootPageVC *pageRes = (NLSRootPageVC *)segue.destinationViewController;
     pageRes.venues = [self.foursquareArray mutableCopy];
     pageRes.currentIndex = [sender integerValue];
 }


@end
