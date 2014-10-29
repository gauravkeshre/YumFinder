//
//  NLSOptionsTableViewCell.m
//  GKPageControlDemo
//
//  Created by Summer Green on 9/28/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import "NLSOptionsTableViewCell.h"

@implementation NLSOptionsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(id)data{
    
}

-(void)setDistance:(NSNumber *)d{
    unsigned long distance = [d unsignedLongValue];
    NSString *unit ;
    if (distance==1) {
        unit = @"meter";
    }else if (distance<1000) {
        unit = @"meters";
    }else if(distance==1000){
        distance = distance/1000;
        unit = @"kilometer";
    }else if (distance>1000){
        distance = distance/1000;
        unit = @"kilometers";
    }
    
     NSString *strFinal = [NSString stringWithFormat:@"%lu %@ %@", distance, unit, @"from here."];
    [self.lblTitle setText:strFinal];
}
@end
