//
//  YMFSearchLandingVC.m
//  YumFinder
//
//  Created by Summer Green on 9/23/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFSearchLandingVC.h"
#import "YMFFSRestaurantVO.h"
#import "YMFPictureCell.h"
#import "YMFFSVenueCategoryVO.h"
#import "YMFFSquareResultManager.h"

static NSString * YMFCategoryCell = @"YMFCategoryCell";
static NSString * YMFPictureCellID = @"YMFPictureCell";


@interface YMFSearchLandingVC ()
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *categoriesCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *lblHashTag;
@property(nonatomic, weak)YMFFSRestaurantVO *currentVenue;
@end

@implementation YMFSearchLandingVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.currentVenue = [self.venues firstObject];
    [self.categoriesCollectionView reloadData];
    [self.imagesCollectionView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startDownloadingInstagramImagesForVenue:(YMFFSRestaurantVO *)venueToLook{
    
}

#pragma mark - CollectionConvenience Methods
-(NSArray *)itemsForPictureArray{
    if (self.currentVenue.media) {
        return self.currentVenue.media;
    }
    return nil;
}
-(NSArray *)itemsForCategoriesArray{
    return self.currentVenue.categories;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == YMFCollectionViewPictures) {
        NSInteger count = [[self itemsForPictureArray] count];
        return (count==0)?1:count;
    }else{
        return [[self itemsForCategoriesArray] count];
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.currentVenue = self.venues[indexPath.row];
    YMFPictureCell *cell;
    if (collectionView.tag ==YMFCollectionViewPictures) {
        cell =[collectionView dequeueReusableCellWithReuseIdentifier:YMFPictureCellID forIndexPath:indexPath];
        [cell setPictureCellType:YMFPictureCellTypeInstagram];

        id media = self.currentVenue.media[indexPath.row];
        [self.lblHashTag setText:self.currentVenue.hashTag];
        [cell setData:media];
        
    }else{
        cell =[collectionView dequeueReusableCellWithReuseIdentifier:YMFCategoryCell forIndexPath:indexPath];
           [cell setPictureCellType:YMFPictureCellTypeGeneral];
        [cell setData:[(YMFFSVenueCategoryVO *)self.currentVenue.categories[indexPath.row] iconURLWithSize:64.f]];
    }
    return cell;
}


#pragma Mark Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 ||indexPath.row<3 ) return;
    
    if (indexPath.row ==3) { //see more images
        [SVProgressHUD showErrorWithStatus:@"Functionality yet to be implemented"];
    }else if (indexPath.row ==4) { //Save to favorites
        [SVProgressHUD showErrorWithStatus:@"Functionality yet to be implemented"];
    }
}

@end
