//
//  InstagramMedia+NSCoding.m
//  YumFinder
//
//  Created by Green Summer on 10/15/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "InstagramMedia+NSCoding.h"
@interface InstagramMedia ()


@end

@implementation InstagramMedia (NSCoding)
#pragma mark - NSCoding Methods
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    CLLocationDegrees latitude = (CLLocationDegrees)[(NSNumber*)[decoder decodeObjectForKey:@"latitude"] doubleValue];
    CLLocationDegrees longitude = (CLLocationDegrees)[(NSNumber*)[decoder decodeObjectForKey:@"longitude"] doubleValue];
    CLLocationCoordinate2D decodedLocation= (CLLocationCoordinate2D) { latitude, longitude };
    self.location = decodedLocation;
    
    self.createdDate = [decoder decodeObjectForKey:@"createdDate"];
    self.link = [decoder decodeObjectForKey:@"link"];
    self.likes = [decoder decodeObjectForKey:@"likes"];
    self.likesCount = [[decoder decodeObjectForKey:@"likesCount"] integerValue];
    self.commentCount = [[decoder decodeObjectForKey:@"commentCount"] integerValue];
    self.comments = [decoder decodeObjectForKey:@"comments"];
    
    self.tags = [decoder decodeObjectForKey:@"comments"];
    self.filter = [decoder decodeObjectForKey:@"filter"];
    self.images = [decoder decodeObjectForKey:@"images"];
    
    self.thumbnailURL = [decoder decodeObjectForKey:@"thumbnailURL"];
    self.thumbnailFrameSize = CGSizeFromString([decoder decodeObjectForKey:@"thumbnailFrameSize"]);
    self.lowResolutionImageFrameSize = CGSizeFromString([decoder decodeObjectForKey:@"lowResolutionImageFrameSize"]);
    
    self.standardResolutionImageFrameSize = CGSizeFromString([decoder decodeObjectForKey:@"standardResolutionImageFrameSize"]);
    
    self.lowResolutionImageURL = [decoder decodeObjectForKey:@"lowResolutionImageURL"];
    self.standardResolutionImageURL = [decoder decodeObjectForKey:@"standardResolutionImageURL"];
    
    self.user =[decoder decodeObjectForKey:@"user"];
    self.caption =[decoder decodeObjectForKey:@"caption"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    NSNumber *latitude = [NSNumber numberWithDouble:self.location.latitude];
    NSNumber *longitude = [NSNumber numberWithDouble:self.location.longitude];
    [encoder encodeObject:latitude forKey:@"latitude"];
    [encoder encodeObject:longitude forKey:@"longitude"];
    
    [encoder encodeObject:self.createdDate forKey:@"createdDate"];
    
    [encoder encodeObject:self.link         forKey:@"link"];
    [encoder encodeObject:self.likes        forKey:@"likes"];
    [encoder encodeObject:self.comments     forKey:@"comments"];
    [encoder encodeObject:self.tags         forKey:@"comments"];
    
    [encoder encodeObject:@(self.likesCount)    forKey:@"likesCount"];
    [encoder encodeObject:@(self.commentCount)  forKey:@"commentCount"];
    
    
    [encoder encodeObject:self.tags forKey:@"comments"];
    [encoder encodeObject:self.filter forKey:@"filter"];
    [encoder encodeObject:self.images forKey:@"images"];
    
    [encoder encodeObject:self.thumbnailURL forKey:@"thumbnailURL"];
    [encoder encodeObject:self.lowResolutionImageURL forKey:@"lowResolutionImageURL"];
    [encoder encodeObject:self.standardResolutionImageURL forKey:@"standardResolutionImageURL"];
    
    
    [encoder encodeObject:NSStringFromCGSize(self.thumbnailFrameSize)
                   forKey:@"thumbnailFrameSize"];
    
    [encoder encodeObject:NSStringFromCGSize(self.lowResolutionImageFrameSize)
                   forKey:@"lowResolutionImageFrameSize"];
    
    [encoder encodeObject:NSStringFromCGSize(self.standardResolutionImageFrameSize)
                   forKey:@"standardResolutionImageFrameSize"];
    
    [encoder encodeObject:self.user forKey:@"user"];
    [encoder encodeObject:self.caption forKey:@"caption"];
    
}

@end
