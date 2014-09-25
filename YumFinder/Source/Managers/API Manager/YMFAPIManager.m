//
//  YMFAPIManager.m
//  YumFinder
//
//  Created by Gaurav Keshre on 9/22/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFAPIManager.h"
#import "NLSLocationManager.h"

@interface YMFAPIManager(){
    NLSLocationManager *locationManager;
}

@property(nonatomic,readwrite,strong) BZFoursquare *foursquare;
@property(nonatomic,strong) BZFoursquareRequest *request;

-(void)cancelRequest;
+(instancetype)sharedInstance;
@end

@implementation YMFAPIManager

- (void)dealloc {
    _foursquare.sessionDelegate = nil;
    [self cancelRequest];
}

+(instancetype)sharedInstance{
    static dispatch_once_t token;
    static YMFAPIManager *sharedInstance;
    dispatch_once(&token, ^{
        sharedInstance = [[YMFAPIManager alloc]init];
    });
    return sharedInstance;
}


-(instancetype)init{
    self = [super init];
    if (self) {
        self.foursquare = [[BZFoursquare alloc] initWithClientID:FSClientID callbackURL:FSRedirectURI];
        _foursquare.version = FSVersion;
        _foursquare.locale = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
        _foursquare.sessionDelegate = self;
        locationManager=[[NLSLocationManager alloc]initWithUpdateBlock:nil errorBlock:^(NSString *errorMessage) {
            NSLog(@"%@", errorMessage);
        }];
    }
    return self;
    
}

- (void)cancelRequest {
    if (_request) {
        _request.delegate = nil;
        [_request cancel];
        self.request = nil;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

#pragma mark - Private Methods
-(void)startSearchForRestaurantsThatServe:(NSString *)cuisine
                                   within:(CGFloat)diameter
                             onCompletion:(YMF_SuccessCallback)successCallback
                                onFailure:(YMF_FailureCallback)failureCallback{

    self.successCallback = successCallback;
    self.failureCallback = failureCallback;
    
    YMFAPIManager *__weak _weakSelf = self;
    [locationManager startMonitoringLocationWithSuccessBlock:^(BOOL success, NSDictionary *location) {
        [locationManager stopMonitoringLocation];
        NSLog(@"%@", location);
        
        NSString *latLng = [location stringWithCommaSeperatedLatLong]; //category method
        NSDictionary *params = [NSDictionary foursquarParamsWithQuery:cuisine andLL:latLng]; //category method
        BZFoursquareRequest *request =  [_weakSelf.foursquare userlessRequestWithPath:@"venues/search"
                                                                      HTTPMethod:@"POST"
                                                                      parameters:params
                                                                        delegate:_weakSelf];
        [request start];
    }];
}


#pragma mark - Public Methods
+(void)startSearchForRestaurantsThatServe:(NSString *)cuisine
                                   within:(CGFloat)diameter
                             onCompletion:(YMF_SuccessCallback)successCallback
                                onFailure:(YMF_FailureCallback)failureCallback{
    [[YMFAPIManager sharedInstance] startSearchForRestaurantsThatServe:cuisine
                                                                within:diameter
                                                          onCompletion:successCallback
                                                             onFailure:failureCallback];
}

#pragma mark - BZFoursquareSessionDelegate

- (void)foursquareDidAuthorize:(BZFoursquare *)foursquare {
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, foursquare);
}

- (void)foursquareDidNotAuthorize:(BZFoursquare *)foursquare error:(NSDictionary *)errorInfo {

    NSLog(@"%s: %@", __PRETTY_FUNCTION__, errorInfo);
}

#pragma mark - BZFoursquareRequestDelegate

- (void)requestDidStartLoading:(BZFoursquareRequest *)request{
    NSLog(@"requestDidStartLoading");
}
- (void)requestDidFinishLoading:(BZFoursquareRequest *)request{
    NSLog(@"requestDidFinishLoading");
    if (self.successCallback) {
        self.successCallback([request response][fsVENUES]);
    }
}
- (void)request:(BZFoursquareRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError : %@", error);
    if (self.failureCallback) {
         NSString *strCode = [NSString stringWithFormat:@"%li", (long)error.code];
        self.failureCallback(strCode, error.localizedDescription);
    }
}

@end
