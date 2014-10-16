//
//  NSDictionary+YMF.m
//  YumFinder
//
//  Created by Summer Green on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "NSDictionary+YMF.h"
#import "NLS_FourSquareApiKeys.h"

@implementation NSDictionary (YMF)

-(NSString *)stringWithCommaSeperatedLatLong{
    if ([self.allKeys containsObject:@"lat"] && [self.allKeys containsObject:@"lng"]) {
        
        return [NSString stringWithFormat:@"%@,%@", self[@"lat"], self[@"lng"]];
    }
    return nil;
}

+(instancetype)foursquarParamsWithQuery:(NSString *)query andLL:(NSString *)latLng{
    return  @{
    @"client_id":FSClientID,
    @"client_secret":FSClientSecret,
    @"query":query,
    @"ll":latLng,
    @"m":@"foursquare",
    @"v":@"20140806"
    };
}


/*
 {
 "location":{
 
     "address":"164 Pearl St",
     "cc":"US",
     "city":"New York",
     "country":"United States",
     "crossStreet":"btwn Pine & Wall St.",
     "distance":920,

    "formattedAddress":[
 
         "164 Pearl St (btwn Pine & Wall St.)",
         "New York, NY 10005",
         "United States"
     ],

     "lat":"40.70606269055038",
     "lng":"-74.00742431556999",
     "postalCode":10005,
     "state":"NY"
 }
 }
 */
-(NSDictionary *)latLong{
    if ([self.allKeys containsObject:fsLOCATION]){
        return @{
                 @"lat":[self valueForKeyPath:fsLOCATION@"."fsLAT],
                 @"lng":[self valueForKeyPath:fsLOCATION@"."fsLNG]
                 };
    }else if ([self.allKeys containsObject:@"lat"] && [self.allKeys containsObject:@"lng"]) {
        return @{fsLAT:self[fsLAT], fsLNG:self[fsLAT]};
    }
        return nil;
}

-(NSString *)distance{
    NSString *d = [self valueForKeyPath:@"location.distance"];
    if (d) {
        return d;
    }
    return [self valueForKeyPath:fsDISTANCE];
}
@end
