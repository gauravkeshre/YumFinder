//
//  UIViewController+Additions.m
//  YumFinder
//
//  Created by Green Summer on 10/8/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "UIViewController+Additions.h"

@implementation UIViewController (Additions)

-(void)setBackgroundImage:(UIImage *)image{
//    UIImage *image = [UIImage imageNamed:@"skin_square"];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    image = [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeTile];
    UIImageView *bg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [bg setImage:image];
    [self.view addSubview:bg];
    [self.view sendSubviewToBack:bg];
    bg = nil;

}
@end
