//
//  YMFMoreOptionsVC.m
//  YumFinder
//
//  Created by Gaurav Keshre on 10/6/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFMoreOptionsVC.h"

@interface YMFMoreOptionsVC ()
- (IBAction)handleBackButton:(id)sender;
@end

@implementation YMFMoreOptionsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - IBAction
- (IBAction)handleBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
