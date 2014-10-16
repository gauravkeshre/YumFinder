//
//  YMFFavoriteCollectionVC.m
//  YumFinder
//
//  Created by Gaurav Keshre on 10/15/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFFavoriteCollectionVC.h"
#import "Venue.h"
#import "YMFVenueHeaderCVC.h"
#import "NLSPictureCVCell.h"
#import "VenueInstagramMedia.h"
#import "UIImageView+AFNetworking.h"
#import "NLSRootPageVC.h"
#import "InstagramMedia.h"
@interface YMFFavoriteCollectionVC ()<UICollectionViewDataSource, UICollectionViewDelegate, YMFVenueHeaderDelegate>

@property (nonatomic) CGFloat originalOrigin;

@property (nonatomic, weak)UIView *floatingView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong)NSMutableArray *mArray;

@end

@implementation YMFFavoriteCollectionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat height = [[UIScreen mainScreen]bounds].size.height;
    
    self.originalOrigin = height-70.f;
    [self fetchAllFavs];
    [self.collectionView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGSize originalContentSize = self.collectionView.contentSize;
    self.collectionView.contentSize =originalContentSize;
    
    [self prepareFloatingView];
}
#pragma mark - Data Methods
- (void)fetchAllFavs {
	// Determine if sort key is
	self.mArray = [[Venue findAllSortedBy:nil ascending:YES] mutableCopy];
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
        return self.mArray.count;
    return (self.mArray.count >0)?self.mArray.count+1:0;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    Venue *mVenue = (Venue *)self.mArray[section];
    NSUInteger mediaCount = [[mVenue instagramMediaArray] count];
    return (section ==self.mArray.count)?1: fmin(4,mediaCount); //max 4 icons
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    __block NLSPictureCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NLSPictureCVCell" forIndexPath:indexPath];
    
    if (indexPath.section ==self.mArray.count) {
        [cell.imageView setHidden:YES];
        return cell;
    }
    [cell.imageView setHidden:NO];
    
    Venue *mVenue = (Venue *)self.mArray[indexPath.section];
    InstagramMedia *media = (InstagramMedia*)[mVenue instagramMediaArray][indexPath.row];
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
        
        
        if (indexPath.section ==self.mArray.count) {
            [headerView.button setTitle:@"" forState:UIControlStateNormal];
        }else{
            Venue *venue = (Venue *)self.mArray[indexPath.section];
            
            NSString *finalTitle = [NSString stringWithFormat:@"%li. #%@", indexPath.section+1, venue.venueName];
            [headerView.button setTitle:finalTitle forState:UIControlStateNormal];
            [headerView setIndexPath:indexPath];
            [headerView setDelegate:self];
            
        }
        reusableview = headerView;
    }else if(kind == UICollectionElementKindSectionFooter && indexPath.section == self.mArray.count){
        UICollectionViewCell *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                       withReuseIdentifier:@"YMFVenueFooter"
                                                                              forIndexPath:indexPath];
        reusableview = footer;
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
    
    return attributes;
}
- (CGSize)collectionViewContentSize
{
    CGSize size = self.collectionView.contentSize;
    size.height+=70;
    return size;
 }

#pragma mark - YMFVenueHeaderDelegate Methods
-(void)venueHeader:(YMFVenueHeaderCVC *)header didSelectAtIndex:(NSIndexPath *)indexPath{
    NSLog(@"did select header at index: %@ \n\n--------\n %@", indexPath, self.mArray[indexPath.section]);
    [self performSegueWithIdentifier:@"push_segue_search_detailresult" sender:@(indexPath.section)];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NLSRootPageVC *pageRes = (NLSRootPageVC *)segue.destinationViewController;
//    pageRes.venues = [self.mArray mutableCopy];
//    pageRes.currentIndex = [sender integerValue];
}

@end
