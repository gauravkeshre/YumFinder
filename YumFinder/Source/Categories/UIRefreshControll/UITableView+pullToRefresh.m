//
//  UITableView+pullToRefresh.m
//  DiamondOffshore
//
//  Created by Hemanth on 7/21/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "UITableView+pullToRefresh.h"

@implementation UITableView (pullToRefresh)


-(UIRefreshControl *)pullToRefreshWithTarget:(id)target onAction:(SEL)action;{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    [self addSubview:refreshControl];
    return refreshControl;
}
@end
