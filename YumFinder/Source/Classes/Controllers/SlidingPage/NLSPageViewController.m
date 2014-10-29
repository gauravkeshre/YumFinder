//
//  NLSPageViewController.m
//  GKPageControlDemo
//
//  Created by Green Summer on 9/27/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "NLSPageViewController.h"
#import "NLSOptionsTableViewCell.h"
#import "NLSPictureCVCell.h"
#import "NLSRootPageVC.h"

#import "UIImageView+AFNetworking.h"
#import "InstagramMedia.h"

#import "YMFFSquareResultManager.h"
#import "NLSLocationManager.h"
#import "YMFAPIManager.h"

#import "Venue.h"
#import "FavoriteVenue.h"
#import "VenueCategory.h"
#import "Address.h"
#import "Location.h"
#import "VenueInstagramMedia.h"

@interface NLSPageViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic)Venue *venueData;
@property (strong, nonatomic) NSMutableArray *instagramImagesArray;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *imgCategoryIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblVenueName;
@property (weak, nonatomic) IBOutlet UIView *categoryContainerView;

- (IBAction)handleBackButton:(id)sender;
@end

@implementation NLSPageViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.instagramImagesArray = [NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    /*
     * Add border to collectionView
     */
    self.collectionView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.collectionView.layer.borderWidth = 2.f;
    self.collectionView.layer.cornerRadius = 12.f;
    
    /*
     * Reload Options TanleView
     */
    [self.tableView reloadData];
    [self.collectionView reloadData];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_circle"]];
    [self.tableView setBackgroundView:imageView];
    imageView = nil;
    
    /*
     * Add Category icon
     */
    
    VenueCategory *category = (VenueCategory *)[[self.venueData categories] anyObject];
    if (category) {
        [self.categoryContainerView setHidden:NO];
        [self.imgCategoryIcon setImageWithURL:[NSURL URLWithString:[category iconURLWithSize:64]] placeholderImage:[UIImage imageNamed:@"quote"]];
    }else{
        [self.categoryContainerView setHidden:YES];
    }
    
    /*
     * Get the Images from instagram
     */
    NSArray *mediaArray = [self.venueData instagramMediaArray];
    if (mediaArray.count<1) {
        
        NLSPageViewController *__weak _weakSelf = self;
        YMFFSquareResultManager *manager = [YMFFSquareResultManager new];
        
        [manager fetchInstagramImagesForVenue:self.venueData
                                 withCallBack:^(NSArray *result) {
                                     
                                     [_weakSelf.venueData.instagramMedia setMediaArray:result];
                                     [_weakSelf.instagramImagesArray removeAllObjects];
                                     [_weakSelf.instagramImagesArray addObjectsFromArray:result];
                                     [_weakSelf.collectionView reloadData];
                                     
                                 } onFailure:nil];
    }else{
        [self.instagramImagesArray removeAllObjects];
        [self.instagramImagesArray addObjectsFromArray:mediaArray];
        [self.collectionView reloadData];
    }
    self.lblVenueName.text = self.venueData.venueName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(NSString *)description{
    NSString *tagStr = [NSString stringWithFormat:@"%@ -- %lu", [super description], (unsigned long)self.tag];
    return tagStr;
}
#pragma mark - Conv Methods
-(void)saveToFavorites{
    
    BOOL alreadyFav = [self.venueData.isFavorite boolValue];
    [self.venueData setIsFavorite:@(!alreadyFav)];
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        NSLog(@"Favorite toggled!");
        [self.tableView reloadData];
    }];

    
}

#pragma mark - NLSDataReceiverDelegate
-(void)setData:(Venue *)_data{
    [self.instagramImagesArray removeAllObjects];
    self.venueData = _data;
    
}

#pragma mark - TableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"s%lir%li",(long)indexPath.section, (long)indexPath.row];
    
    NLSOptionsTableViewCell *cell = (NLSOptionsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    switch (indexPath.row) {
        case 0:{
            BOOL alreadyFav = [self.venueData.isFavorite boolValue];
            NSString *strFav = (alreadyFav)? @"Remove from Favorites":@"Save to Favorites" ;
            [cell.lblTitle setText:strFav];
        }
            break;
        case 1:{ //DISTANCE
            [cell setDistance:self.venueData.location.distance];
        }
            break;
        case 2:{ //WEBSITE
             NSString *strHereNow = [NSString stringWithFormat:@"%lu people are here now...", [self.venueData.countHereNow integerValue]];
            [cell.lblTitle setText:strHereNow];
        }
            break;
        default:
            break;
    }
    
    UIImageView *selectedImageView = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
    [selectedImageView setImage:[UIImage imageNamed:@"bg_cell_underline"]];
    [cell setSelectedBackgroundView:selectedImageView];
    
    return cell;
}

#pragma Mark Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: // Save to favorite
            [self saveToFavorites];
            break;
        case 1:{
            CLLocationCoordinate2D l2D = [[YMFAPIManager currentLocation] coordinate];
            CLLocationCoordinate2D to2D = CLLocationCoordinate2DMake([self.venueData.location.lat doubleValue], [self.venueData.location.lng doubleValue]);
            NSString* url = [NSString stringWithFormat:@"http://maps.apple.com?saddr=%f,%f&daddr=%f,%f",l2D.latitude, l2D.longitude, to2D.latitude, to2D.longitude];
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];

        }
            break;
        case 300: //route
        {
            CLLocationCoordinate2D l2D = [[YMFAPIManager currentLocation] coordinate];
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:l2D
                                                           addressDictionary:nil];
            MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark] ;

            [mapItem setName:@"Current Location"];
//            [mapItem openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
            
            CLLocation* fromLocation = [YMFAPIManager currentLocation];
            // Create a region centered on the starting point with a 10km span
            MKCoordinateRegion region =
            MKCoordinateRegionMakeWithDistance(fromLocation.coordinate, 10000, 10000);
            // Open the item in Maps, specifying the map region to display.
            [MKMapItem openMapsWithItems:[NSArray arrayWithObject:mapItem]
                           launchOptions:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [NSValue valueWithMKCoordinate:region.center],
                                          MKLaunchOptionsMapCenterKey,
                                          [NSValue valueWithMKCoordinateSpan:region.span],
                                          MKLaunchOptionsMapSpanKey, nil]];
        }
            break;
        case 2: //view Website
        {
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.instagramImagesArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    __block NLSPictureCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NLSPictureCVCell" forIndexPath:indexPath];
    InstagramMedia *media = (InstagramMedia *) self.instagramImagesArray[indexPath.row];
    [cell setData:media];
    return cell;
}
#pragma mark - UICollectionViewDataSource

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

- (IBAction)handleBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
