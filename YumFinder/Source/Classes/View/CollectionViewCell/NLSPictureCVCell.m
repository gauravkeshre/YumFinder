//
//  NLSPictureCVCell.m
//  GKPageControlDemo
//
//  Created by Summer Green on 9/28/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import "NLSPictureCVCell.h"
#import "InstagramMedia.h"
#import "UIImageView+AFNetworking.h"
#define kPlaceholderURL @"http://placehold.it/360x360"
#define KPLACEHOLDER_IMAGE [UIImage imageNamed:@"bg_circuitboard"]
@implementation NLSPictureCVCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)resetImages{
    [self.imageView setImage:KPLACEHOLDER_IMAGE];
}

#pragma mark - NLSDataReceiverDelegate
-(void)setData:(InstagramMedia *)media{
    NSURL *url = (media!=nil)?media.standardResolutionImageURL:[NSURL URLWithString:kPlaceholderURL];
    NSLog(@"Location: %f, %f", media.location.latitude, media.location.longitude);
    NLSPictureCVCell *__weak _weakSelf = self;

    [self.imageView setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        long long progress = totalBytesRead/totalBytesExpectedToRead;
        NSLog(@"Progress: %lld", progress);
        [_weakSelf.activityIndicator setProgress:progress];
    }];
    [self.activityIndicator setHidden:NO];
    [self.imageView setImageWithURL:url placeholderImage:KPLACEHOLDER_IMAGE];
}
@end
