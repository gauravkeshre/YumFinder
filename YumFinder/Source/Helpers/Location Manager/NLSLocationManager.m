//
//  NLSLocationManager.m
//  Restaurage
//
//  Created by Summer Green on 9/19/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import "NLSLocationManager.h"
#pragma mark---
@interface NLSLocationManager()
{
    CLLocationManager *locationManager;
}

@property (readonly) CLLocationCoordinate2D currentCoordinate;
@property (nonatomic,retain) NSString *currentCity;



// current location
- (void)startUpdatingCurrentLocation;
- (void)stopUpdatingCurrentLocation;


@end

@implementation NLSLocationManager
@synthesize currentCoordinate;
@synthesize currentCity;


#pragma mark - init Methods



- (id)initWithUpdateBlock:(NLS_SuccessBlock)successBlock errorBlock:(NLS_ErrorBlock)errorBlock{
	self = [super init];
	if (self) {
        self.successCallBack = successBlock;
        self.errorCallBack = errorBlock;
       }
	return self;
}

+ (BOOL)locationServicesEnabled
{
    return  NO;
}

-(void)dealloc
{
    locationManager= nil;
    currentCity= nil;
}


#pragma mark -
#pragma mark Class Methods Private Methods

-(void)prepareLocationManager{
    currentCity = nil;
    currentCoordinate = kCLLocationCoordinate2DInvalid;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager allowDeferredLocationUpdatesUntilTraveled:200.f timeout:15];
}

// current location
- (void)startUpdatingCurrentLocation
{
    
    if (![CLLocationManager locationServicesEnabled]) {
        currentCity = nil;
        if(self.errorCallBack)
            self.errorCallBack(msgLocationServivceDisabledWithSettingMessage);
        return;
        
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied ||
              [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted)
    {
        currentCity = nil;
        if(self.errorCallBack)
            self.errorCallBack(msgLocationManagerServiceDisabled);
        return;
        
    }
    
    // if locationManager does not currently exist, create it.
    if (locationManager !=nil)
    {
        locationManager = nil;
    }
    [self prepareLocationManager];
}

- (void)stopUpdatingCurrentLocation
{
    if (locationManager !=nil) {
        [locationManager stopUpdatingLocation];
        [locationManager stopMonitoringSignificantLocationChanges];
        locationManager.delegate = nil;
    }
    
}



#pragma mark - CLLocationManagerDelegate - Location updates

/**
 *  Tells the delegate that new location data is available.
 

 *
 *  @param manager   The location manager object that generated the update event.

 *  @param locations An array of CLLocation objects containing the location data. This array always contains at least one object representing the current location. If updates were deferred or if multiple locations arrived before they could be delivered, the array may contain additional entries. The objects in the array are organized in the order in which they occurred. Therefore, the most recent location update is at the end of the array.
 */

- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations{    
    [locationManager stopMonitoringSignificantLocationChanges];
    self.location = [locations lastObject];
    if (self.successCallBack) {
        self.successCallBack(YES, @{@"lat": @(self.location.coordinate.latitude), @"lng": @(self.location.coordinate.longitude)});
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", [error localizedFailureReason]);

    // stop updating
    [self stopUpdatingCurrentLocation];
    currentCoordinate = kCLLocationCoordinate2DInvalid;
    currentCity = nil;
    
    NSLog(@"error%@",error);
    NSString *errorMessage = nil;
    switch([error code])
    {
        case kCLErrorNetwork:
            errorMessage=msgErrorNetwork;
            break;
        case kCLErrorDenied:
            errorMessage=msgErrorDenied;
            break;
        case kCLErrorHeadingFailure:
            errorMessage=msgErrorHeadingFailure;
            break;
        case kCLErrorLocationUnknown:
            errorMessage=@"Unable to find User location.";
            break;
        default:
            errorMessage=@"Unknown network error.";
            break;
    }
    if (self.errorCallBack) {
		self.errorCallBack(errorMessage);
    }
    
}

-(void)startMonitoringLocation{
    [self startMonitoringLocationWithSuccessBlock:nil];
}

-(void)startMonitoringLocationWithSuccessBlock:(NLS_SuccessBlock)successBlock{
    if (successBlock) {
        self.successCallBack = successBlock;
    }
    if (![CLLocationManager locationServicesEnabled]) {
        currentCity = nil;
        if(self.errorCallBack)
            self.errorCallBack(msgLocationServivceDisabledWithSettingMessage);
        return;
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied ||
              [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
        currentCity = nil;
        if(self.errorCallBack)
            self.errorCallBack(msgLocationManagerServiceDisabled);
        return;
        
    }

    if (locationManager ==nil) {
        [self prepareLocationManager];
    }
    [locationManager startMonitoringSignificantLocationChanges];
}
-(void)stopMonitoringLocation{
    [locationManager stopMonitoringSignificantLocationChanges];
}

@end
