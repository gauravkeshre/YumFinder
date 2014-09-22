//
//  UITableView+pullToRefresh.h
//  DiamondOffshore
//
//  Created by Hemanth on 7/21/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (pullToRefresh)

-(UIRefreshControl *)pullToRefreshWithTarget:(id)target onAction:(SEL)action;

@end
