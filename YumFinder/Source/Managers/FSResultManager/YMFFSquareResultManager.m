//
//  YMFFSquareResultManager.m
//  YumFinder
//
//  Created by Gaurav Keshre on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFFSquareResultManager.h"
#import "NSDictionary+YMF.h"
#import "YMFFSRestaurantVO.h"
#import "YMFFSAddressVO.h"
#import "YMFFSLocationVO.h"
#import "InstagramKit.h"

@implementation YMFFSquareResultManager

-(void)parseResultFromArray:(NSArray *)array onSuccess:(YMF_SuccessCallback)callback{
    
    NSDictionary *d1 = [array firstObject];
    NSLog(@"%@", d1);
    
    __block NSMutableArray *mArr = [[NSMutableArray alloc]init];
    __block int i=0;
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        i++;
        YMFFSRestaurantVO *venue = [YMFFSRestaurantVO initWithDictionary:obj];
        
        if (i>=5) {
            *stop = YES;
        }
        NSString *tag = [[self hashTagWithName:venue ] firstObject];
        if (tag) {
            
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            [[InstagramEngine sharedEngine] getMediaWithTagName:tag count:15 maxId:nil
                                                    withSuccess:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
                                                            venue.media = media;
                                                            dispatch_semaphore_signal(sema);
                                                    } failure:^(NSError *error) {
                                                        NSLog(@"Search Media Failed");
                                                            dispatch_semaphore_signal(sema);
                                                    }];
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        
        [mArr addObject:venue];
    }];
    if (callback) {
        callback(mArr);
    }
}

-(NSArray *)hashTagWithName:(YMFFSRestaurantVO * )venue{
    NSString *str1 = [venue.venueName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSString *str2 = [venue.venueName stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *str3 = [NSString stringWithFormat:@"%@%@",str2, venue.address.city];
    NSString *str4 = [NSString stringWithFormat:@"%@%@",str2, venue.address.state];
    NSString *str5 = [NSString stringWithFormat:@"%@%@",str2, venue.address.cc];
    
    NSSet *set = [NSSet setWithObjects:str1,str2,str3,str4,str5, nil];
    return @[str2];//[set allObjects];
}

@end
