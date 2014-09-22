//
//  YMFHomeViewController.m
//  YumFinder
//
//  Created by Summer Green on 9/22/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFHomeViewController.h"

@interface YMFHomeViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnLeftArrow;
- (IBAction)handleLeftArrow:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtCuisine;
@property (weak, nonatomic) IBOutlet UITextField *txtRange;
@property (weak, nonatomic) IBOutlet UIButton *btnRightArrow;
- (IBAction)handleRightArrow:(id)sender;
- (IBAction)handleLeftSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)handleRightSwipe:(UISwipeGestureRecognizer *)sender;

@end

@implementation YMFHomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    leftView.backgroundColor = [UIColor clearColor];
    
    self.txtCuisine.leftViewMode = UITextFieldViewModeAlways;
    self.txtRange.leftViewMode = UITextFieldViewModeAlways;
    
//    self.txtCuisine.leftView =leftView;
    self.txtRange.leftView = leftView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITextFieldDelegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Conv Methods{

-(BOOL)validateInputeAndReact:(BOOL)shouldReact{
    BOOL flag = NO;
    
    
    if (shouldReact && !flag) {
        //
        [self.txtCuisine shake];
        [self.txtRange shake];
    }
    return flag;
}

#pragma mark - Action Methods

-(void)searchAction:(id)sender{
    BOOL isVAlid = [self validateInputeAndReact:YES];
}


#pragma mark - IBAction Methods
- (IBAction)handleLeftArrow:(id)sender {
}
- (IBAction)handleRightArrow:(id)sender {
        [self searchAction:sender];
}

- (IBAction)handleLeftSwipe:(UISwipeGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"segue_push_Instructions" sender:nil];
}

- (IBAction)handleRightSwipe:(UISwipeGestureRecognizer *)sender {
    [self searchAction:sender];
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
