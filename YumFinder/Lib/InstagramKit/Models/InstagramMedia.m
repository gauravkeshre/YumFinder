//
//    Copyright (c) 2013 Shyam Bhat
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of
//    this software and associated documentation files (the "Software"), to deal in
//    the Software without restriction, including without limitation the rights to
//    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//    the Software, and to permit persons to whom the Software is furnished to do so,
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "InstagramMedia.h"
#import "InstagramUser.h"
#import "InstagramComment.h"


@interface InstagramMedia ()
{
    NSMutableArray *mLikes;
    NSMutableArray *mComments;
}
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

@implementation InstagramMedia
@synthesize likes = mLikes;
@synthesize comments = mComments;


#pragma mark - Lifecycle Methods
- (id)initWithInfo:(NSDictionary *)info
{
    self = [super initWithInfo:info];
    if (self && IKNotNull(info)) {
        
        _user = [[InstagramUser alloc] initWithInfo:info[kUser]];
        _createdDate = [[NSDate alloc] initWithTimeIntervalSince1970:[info[kCreatedDate] doubleValue]];
        _link = [[NSString alloc] initWithString:info[kLink]];
        _caption = [[InstagramComment alloc] initWithInfo:info[kCaption]];
        _likesCount = [(info[kLikes])[kCount] integerValue];
        mLikes = [[NSMutableArray alloc] init];
        for (NSDictionary *userInfo in (info[kLikes])[kData]) {
            InstagramUser *user = [[InstagramUser alloc] initWithInfo:userInfo];
            [mLikes addObject:user];
        }
        
        _commentCount = [(info[kComments])[kCount] integerValue];
        mComments = [[NSMutableArray alloc] init];
        for (NSDictionary *commentInfo in (info[kComments])[kData]) {
            InstagramComment *comment = [[InstagramComment alloc] initWithInfo:commentInfo];
            [mComments addObject:comment];
        }
        _tags = [[NSArray alloc] initWithArray:info[kTags]];
        
        if (IKNotNull(info[kLocation])) {
            _location = CLLocationCoordinate2DMake([(info[kLocation])[kLatitude] doubleValue], [(info[kLocation])[kLongitude] doubleValue]);
        }
        
        _filter = info[kFilter];
        
        [self initializeImages:info[kImages]];
        
        NSString* mediaType = info[kType];
        _isVideo = [mediaType isEqualToString:[NSString stringWithFormat:@"%@",kMediaTypeVideo]];
        if (_isVideo) {
            [self initializeVideos:info[kVideos]];
        }
    }
    return self;
}

- (void)initializeImages:(NSDictionary *)imagesInfo
{
    NSDictionary *thumbInfo = imagesInfo[kThumbnail];
    _thumbnailURL = [[NSURL alloc] initWithString:thumbInfo[kURL]];
    _thumbnailFrameSize = CGSizeMake([thumbInfo[kWidth] floatValue], [thumbInfo[kHeight] floatValue]);
    
    NSDictionary *lowResInfo = imagesInfo[kLowResolution];
    _lowResolutionImageURL = [[NSURL alloc] initWithString:lowResInfo[kURL]];
    _lowResolutionImageFrameSize = CGSizeMake([lowResInfo[kWidth] floatValue], [lowResInfo[kHeight] floatValue]);
    
    NSDictionary *standardResInfo = imagesInfo[kStandardResolution];
    _standardResolutionImageURL = [[NSURL alloc] initWithString:standardResInfo[kURL]];
    _standardResolutionImageFrameSize = CGSizeMake([standardResInfo[kWidth] floatValue], [standardResInfo[kHeight] floatValue]);
}

- (void)initializeVideos:(NSDictionary *)videosInfo
{
    NSDictionary *lowResInfo = videosInfo[kLowResolution];
    _lowResolutionVideoURL = [[NSURL alloc] initWithString:lowResInfo[kURL]];
    _lowResolutionVideoFrameSize = CGSizeMake([lowResInfo[kWidth] floatValue], [lowResInfo[kHeight] floatValue]);
    
    NSDictionary *standardResInfo = videosInfo[kStandardResolution];
    _standardResolutionVideoURL = [[NSURL alloc] initWithString:standardResInfo[kURL]];
    _standardResolutionVideoFrameSize = CGSizeMake([standardResInfo[kWidth] floatValue], [standardResInfo[kHeight] floatValue]);
}


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
    
    self.tags = [decoder decodeObjectForKey:@"tags"];
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
    [encoder encodeObject:self.tags         forKey:@"tags"];
    
    [encoder encodeObject:@(self.likesCount)    forKey:@"likesCount"];
    [encoder encodeObject:@(self.commentCount)  forKey:@"commentCount"];
    
    
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
