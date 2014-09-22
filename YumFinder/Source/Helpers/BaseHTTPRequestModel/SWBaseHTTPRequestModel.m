//
//  SWBaseHTTPRequestModel.m
//  Speakle
//
//  Created by Summer Green on 6/17/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "SWBaseHTTPRequestModel.h"
#import "APIConstants.h"
@interface SWBaseHTTPRequestModel (private)
{
    
}
//-(void)GETWithURL:(NSString *)serviceURL
// requestSignature:(NSString *)signature
//  completionBlock:(SWSuccessCallback)success_callback
//     failureBlock:(SWFailureCallback)failure_callback;
//
//-(void)POSTWithData:(NSDictionary *)_data atURL:(NSString *)postURL delegate:(id)delegate
//   progressCallback:(SWProgressCallback)progress_calback
//    completionBlock:(SWSuccessCallback)success_callback
//       failureBlock:(SWFailureCallback)failure_callback;
//
//@property (nonatomic,strong)NSURLConnection *urlConnection; //only for iOS 6
@end

@implementation SWBaseHTTPRequestModel

-(void)dealloc{
    [self.dataTask cancel];
    [[self session] finishTasksAndInvalidate];
    self.dataTask = nil;
//    [self.urlConnection cancel];
//    self.urlConnection= nil;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = SWHTTPMethodPOST;
    }
    return self;
}

#pragma mark - Session Getter Methods
- (NSURLSession *)session{
    if (_session==nil) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return _session;
}


#pragma mark - Public Methods
-(void) invokeURL:(NSString *)serviceURL
       withParams:(NSDictionary *)params
         callback:(SWSuccessCallback)callback{
    
    if (Is_NSURLSession_Supported) {
        //do it with session
        [self session_invokeURL:serviceURL
                     withParams:params callback:^(BOOL success, id result) {
                         [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
                         callback(success,result);
                     }];
    }else{
        //do it with ConnectionURL
        [self connection_invokeURL:serviceURL
                        withParams:params callback:callback];
        
    }
}

#pragma mark - NSURLSession Methods

-(void) session_invokeURL:(NSString *)serviceURL
               withParams:(NSDictionary *)params
                 callback:(SWSuccessCallback)callback{
    
//    NSLog(@"dataTask about to be killed: %@", self.dataTask);
//    [self.dataTask cancel];
//    self.dataTask = nil;
    
    NSLog(@"URL: %@", serviceURL);
    NSURL *url = [NSURL URLWithString:serviceURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSMutableString *strParams = [[NSMutableString alloc]init];
    for (NSString *key in [params allKeys]) {
        [strParams appendFormat:@"%@=%@", key, params[key]];
        [strParams appendString:@"&"];
    }
    [strParams deleteCharactersInRange:NSMakeRange([strParams length]-1, 1)];
    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [urlRequest setHTTPBody:[strParams dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDataTask *task = [[self session] dataTaskWithRequest:urlRequest
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       if(error){
                                                           callback(NO,@{kMESSAGE:[error userInfo][@"NSLocalizedDescription"]});
                                                           return;
                                                       }
                                                       NSMutableDictionary *responsDic = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]];
                                                       
                                                       if (!IS_NULL(responsDic) && !IS_NULL(responsDic[kSTATUS])) {
                                                           callback([responsDic[kSTATUS] boolValue], responsDic);
                                                       }else{
                                                           
                                                           callback(NO, nil);
                                                       }
                                                       
                                                   }];
    [task resume];
//    self.dataTask = task;
//    [self.dataTask resume];
//    NSLog(@"dataTask resumed: %@", self.dataTask);
}


#pragma mark - NSURLConnection Methods
-(void) connection_invokeURL:(NSString *)serviceURL
                  withParams:(NSDictionary *)params
                    callback:(SWSuccessCallback)callback{
    
    
    NSURL *url = [NSURL URLWithString:serviceURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSMutableString *strParams = [[NSMutableString alloc]init];
    for (NSString *key in [params allKeys]) {
        [strParams appendFormat:@"%@=%@", key, params[key]];
        [strParams appendString:@"&"];
    }
    [strParams deleteCharactersInRange:NSMakeRange(strParams.length-1, 1)]; //remove trailiing "&"
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[strParams dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error) {
                               if(error!=nil){
                                   callback(NO,@{kMESSAGE:[error userInfo][@"NSLocalizedDescription"]});
                                   return;
                               }
                               NSMutableDictionary *responsDic = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]];
                               
                               if (!IS_NULL(responsDic) && !IS_NULL(responsDic[kSTATUS])) {
                                   callback([responsDic[kSTATUS] boolValue], responsDic);
                               }else{
                                   
                                   callback(NO, nil);
                               }
                           }];
    
}

-(void)cancelAllServices{
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    if (Is_NSURLSession_Supported) {
        //do it with session
        [self.dataTask cancel];
        [[self session] finishTasksAndInvalidate];
    }else{
        
    }
    
}
@end
