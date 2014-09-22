//
//  SWBaseHTTPRequestModel.h
//  Speakle
//
//  Created by Summer Green on 6/17/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SWHTTPMethod) {
    SWHTTPMethodGET,
    SWHTTPMethodPOST
};

typedef void (^SWProgressCallback)  (CGFloat progress);
typedef void (^SWSuccessCallback)  (BOOL success, id result);
typedef void (^SWFailureCallback)  (NSString *error_code, NSString *message);

#define Is_NSURLSession_Supported (NSStringFromClass([NSURLSession class])!=nil)

@interface SWBaseHTTPRequestModel : NSObject
{
    NSURLSession *_session;

}
@property (nonatomic) SWHTTPMethod method;
@property (nonatomic, strong)NSURLSessionDataTask *dataTask;

-(void) invokeURL:(NSString *)serviceURL
       withParams:(NSDictionary *)params
         callback:(SWSuccessCallback)callback;

-(void)cancelAllServices;


@end
