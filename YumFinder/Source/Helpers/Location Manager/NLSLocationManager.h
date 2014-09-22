//
//  NLSLocationManager.h
//  Restaurage
//
//  Created by Summer Green on 9/19/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^NLS_SuccessBlock)(BOOL success, NSDictionary *location);
typedef void (^NLS_ErrorBlock)(NSString *errorMessage);

@interface NLSLocationManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic,copy) NLS_SuccessBlock successCallBack;
@property (nonatomic,copy) NLS_ErrorBlock errorCallBack;
@property (nonatomic, strong)CLLocation *location;

- (id)initWithUpdateBlock:(NLS_SuccessBlock)successBlock
               errorBlock:(NLS_ErrorBlock)errorBlock;

-(void)startMonitoringLocation;
-(void)stopMonitoringLocation;
-(void)startMonitoringLocationWithSuccessBlock:(NLS_SuccessBlock)successBlock;
@end
