//
//  SWTimeLabel.h
//  SWTimeLabelDemo
//
//  Created by Summer Green on 3/9/13.
//  Copyright (c) 2013 Nimar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLSTimeLabel : UIButton
{
    UIControlContentHorizontalAlignment textAlignment;
}
@property (nonatomic, copy) NSString* fontName;

-(void)setTextHorizontalAlignment:(UIControlContentHorizontalAlignment)alignment;
-(void)startTimerWithIntialDate:(NSString *)date;
-(void)stopTimer;
-(void)displayDate;
@end
