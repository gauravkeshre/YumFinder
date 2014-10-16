//
//  YMFAPIManager.m
//  YumFinder
//
//  Created by Summer Green on 9/22/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFAPIManager.h"
#import "NLSLocationManager.h"
#define kTEMP_URL @"http://www.json-generator.com/api/json/get/bOGPbRQyIy?indent=2"

@interface YMFAPIManager(){
    
}
@property(nonatomic, strong)NLSLocationManager *locationManager;
@property(nonatomic,readwrite,strong) BZFoursquare *foursquare;
@property(nonatomic,strong) BZFoursquareRequest *request;

-(void)cancelRequest;
+(instancetype)sharedInstance;
+(CLLocation *)currentLocation;
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

+(CLLocation *)currentLocation{
    YMFAPIManager *__self = [YMFAPIManager sharedInstance];
        return __self.locationManager.location;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.foursquare = [[BZFoursquare alloc] initWithClientID:FSClientID callbackURL:FSRedirectURI];
        _foursquare.version = FSVersion;
        _foursquare.locale = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
        _foursquare.sessionDelegate = self;
        self.locationManager=[[NLSLocationManager alloc]initWithUpdateBlock:nil errorBlock:^(NSString *errorMessage) {
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
    [self.locationManager startMonitoringLocationWithSuccessBlock:^(BOOL success, NSDictionary *location) {
        [self.locationManager stopMonitoringLocation];
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
//
-(void)__startSearchForRestaurantsThatServe:(NSString *)cuisine
                                    within:(CGFloat)diameter
                              onCompletion:(YMF_SuccessCallback)successCallback
                                onFailure:(YMF_FailureCallback)failureCallback{
    self.successCallback = nil;
    self.failureCallback = nil;
    
    [self session_invokeURL:kTEMP_URL
                 withParams:nil
                   callback:successCallback
            failureCallback:failureCallback];
    
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
#pragma mark - NSURLSession Methods
-(void) session_invokeURL:(NSString *)serviceURL
               withParams:(NSDictionary *)params
                 callback:(YMF_SuccessCallback)callback
                 failureCallback:(YMF_FailureCallback)failureCallback{
    

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];

    NSLog(@"URL: %@", serviceURL);
    NSURL *url = [NSURL URLWithString:serviceURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    if (params) {
    NSMutableString *strParams = [[NSMutableString alloc]init];
    for (NSString *key in [params allKeys]) {
        [strParams appendFormat:@"%@=%@", key, params[key]];
        [strParams appendString:@"&"];
    }
    [strParams deleteCharactersInRange:NSMakeRange([strParams length]-1, 1)];
    [urlRequest setHTTPBody:[strParams dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest setHTTPMethod:@"POST"];
    }else{
            [urlRequest setHTTPMethod:@"GET"];
    }

    //    [urlRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    

    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       if(error){
                                                           failureCallback(@"500",[error userInfo][@"NSLocalizedDescription"]);
                                                           return;
                                                       }
                                                       NSMutableDictionary *responsDic = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]];
                                                           callback(responsDic[@"response"][@"venues"]);
                                                   }];
    [task resume];
    //    self.dataTask = task;
    //    [self.dataTask resume];
    //    NSLog(@"dataTask resumed: %@", self.dataTask);
}

@end
