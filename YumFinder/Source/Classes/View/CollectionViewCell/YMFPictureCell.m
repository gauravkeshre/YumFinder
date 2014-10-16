//
//  YMFPictureCell.m
//  YumFinder
//
//  Created by Summer Green on 9/26/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFPictureCell.h"
#import "UIImageView+AFNetworking.h"
#import "InstagramMedia.h"


@implementation YMFPictureCell


-(void)setData:(id)data{
    NSURL *url;// = [NSURL URLWithString:urlString];
    
    if ([data isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:data];
    }else if ([data isKindOfClass:[InstagramMedia class]]){
        url = [(InstagramMedia *)data standardResolutionImageURL];
    }else{
        return;
    }
    
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    if (self.progressBar) {
        [self.progressBar setHidden:NO];
        [self.imageView setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            long long progress  = totalBytesRead/totalBytesExpectedToRead ;
            [self.progressBar setProgress:progress];
        }];
    }
    
    YMFPictureCell *__weak _weakSelf = self;
    [self.imageView setImageWithURLRequest:request
                          placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       _weakSelf.imageView.image = image;
                                       [_weakSelf setNeedsLayout];
                                        [self.progressBar setHidden:YES];
                                   } failure:nil];
    
}
@end
