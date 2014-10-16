//
//  NLSOptionsTableViewCell.h
//  GKPageControlDemo
//
//  Created by Summer Green on 9/28/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLSOptionsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

-(void)setData:(id)data;
-(void)setDistance:(unsigned long)distance;
@end
