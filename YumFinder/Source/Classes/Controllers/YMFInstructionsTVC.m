//
//  YMFInstructionsTVC.m
//  YumFinder
//
//  Created by Summer Green on 9/22/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFInstructionsTVC.h"

@interface YMFInstructionsTVC ()
{
//    UIButton *flaotingButton;
//    UIImage  *floatingLogo;
}
@property(nonatomic, weak) UIButton *floatingButton;
@property(nonatomic, weak) UIImageView  *floatingLogo;
@property(nonatomic, weak) UIView  *floatingView;
@property (nonatomic) CGFloat originalOrigin;
@end

@implementation YMFInstructionsTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat height = [[UIScreen mainScreen]bounds].size.height;
    self.originalOrigin = height-70.f;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGSize originalContentSize = self.tableView.contentSize;
    originalContentSize.height+=70.f;
    self.tableView.contentSize =originalContentSize;
    
    [self prepareFloatingView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Conv Methods

-(void)prepareFloatingView{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(250, 10.f, 60, 60)];
    [button addTarget:self action:@selector(handleFloatingButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"ico_arrow-white-right"] forState:UIControlStateNormal];

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10.f, 10.f, 140.f, 42.f)];
    [imageView setImage:[UIImage imageNamed:@"logo_blue"]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(0,0, [[UIScreen mainScreen]bounds].size.width, 120)];
    [v2 setBackgroundColor:[UIColor blackColor]];
    [v2 setAlpha:0.6];
    
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.originalOrigin, [[UIScreen mainScreen]bounds].size.width, 120)];

    [v1 setBackgroundColor:[UIColor clearColor]];
    [v1 addSubview:v2];
    [v1 addSubview:imageView];
    [v1 addSubview:button];
    
    [self.view addSubview:v1];
    self.floatingView = v1;
    v2= nil;
    imageView = nil;
    button = nil;
    v1 = nil;

}


#pragma mark - IBAction Methods

-(void)handleFloatingButton:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - UIScrollViewDelegate Methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect tableBounds = self.tableView.bounds;
    CGRect floatingButtonFrame = self.floatingView.frame;
    floatingButtonFrame.origin.y = tableBounds.origin.y + self.originalOrigin;
    self.floatingView.frame = floatingButtonFrame;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
