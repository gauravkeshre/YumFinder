//
//  InstagramMedia+NSCoding.h
//  YumFinder
//
//  Created by Gaurav Keshre on 10/15/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "InstagramMedia.h"

@interface InstagramMedia (NSCoding)<NSCoding>
@property (nonatomic, readwrite) InstagramUser* user;
@property (nonatomic, readwrite) InstagramComment* caption;

@property (nonatomic, readwrite) NSDate *createdDate;
@property (nonatomic, readwrite) NSString* link;

@property (nonatomic, readwrite) NSInteger likesCount;
@property (nonatomic, readwrite) NSArray *likes;
@property (nonatomic, readwrite) NSInteger commentCount;
@property (nonatomic, readwrite) NSArray *comments;
@property (nonatomic, readwrite) NSArray *tags;
@property (nonatomic, readwrite) CLLocationCoordinate2D location;
@property (nonatomic, readwrite) NSString* filter;
@property (nonatomic, readwrite) NSDictionary* images;

@property (nonatomic, readwrite) NSURL *thumbnailURL;
@property (nonatomic, readwrite) CGSize thumbnailFrameSize;
@property (nonatomic, readwrite) NSURL *lowResolutionImageURL;
@property (nonatomic, readwrite) CGSize lowResolutionImageFrameSize;
@property (nonatomic, readwrite) NSURL *standardResolutionImageURL;
@property (nonatomic, readwrite) CGSize standardResolutionImageFrameSize;

@property (nonatomic, readwrite) BOOL isVideo;
@property (nonatomic, readwrite) NSURL *lowResolutionVideoURL;
@property (nonatomic, readwrite) CGSize lowResolutionVideoFrameSize;
@property (nonatomic, readwrite) NSURL *standardResolutionVideoURL;
@property (nonatomic, readwrite) CGSize standardResolutionVideoFrameSize;
@end
