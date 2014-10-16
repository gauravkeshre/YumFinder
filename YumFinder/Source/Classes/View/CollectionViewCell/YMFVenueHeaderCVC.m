//
//  YMFVenueHeaderCVC.m
//  GKColelctionViewDemo
//
//  Created by Summer Green on 10/2/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFVenueHeaderCVC.h"

@implementation YMFVenueHeaderCVC

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (IBAction)handleButtonTap:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(venueHeader:didSelectAtIndex:)]) {
        [self.delegate venueHeader:self didSelectAtIndex:self.indexPath];
    }
}

@end
