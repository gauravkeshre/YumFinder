//
//  YMFHomeViewController.m
//  YumFinder
//
//  Created by Summer Green on 9/22/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFHomeViewController.h"
#import "YMFSearchLandingVC.h"
#import "YMFFSquareResultManager.h"

@interface YMFHomeViewController ()<UITextFieldDelegate>
{
}
@property (weak, nonatomic) IBOutlet UIButton *btnLeftArrow;
@property (weak, nonatomic) IBOutlet UITextField *txtCuisine;
@property (weak, nonatomic) IBOutlet UITextField *txtRange;
@property (weak, nonatomic) IBOutlet UIButton *btnRightArrow;
@property (strong, nonatomic)YMFFSquareResultManager *fsResultManager;
- (IBAction)handleLeftArrow:(id)sender;
- (IBAction)handleRightArrow:(id)sender;
- (IBAction)handleLeftSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)handleRightSwipe:(UISwipeGestureRecognizer *)sender;

@end

@implementation YMFHomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view.
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    leftView.backgroundColor = [UIColor clearColor];
    
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    leftView2.backgroundColor = [UIColor clearColor];
    
    self.txtCuisine.leftViewMode = UITextFieldViewModeAlways;
    self.txtRange.leftViewMode = UITextFieldViewModeAlways;
    
    self.txtCuisine.leftView =leftView;
    self.txtRange.leftView = leftView2;
    leftView = nil;
    leftView2= nil;
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
    BOOL isValid = YES;
    
    isValid &= [self.txtCuisine.text length]>0;
    isValid &= [self.txtRange.text length]>0;
    if (shouldReact && !isValid) {
        //
        [self.txtCuisine shake];
        [self.txtRange shake];
    }
    return isValid;
}

#pragma mark - Action Methods

-(void)searchAction:(id)sender{
    if (![self validateInputeAndReact:YES]) return;
    
    YMFHomeViewController *__weak _weakSelf = self;
    [SVProgressHUD showWithStatus:msgPleaseWait maskType:SVProgressHUDMaskTypeGradient];
    
    
    if (self.fsResultManager ==nil) {
        self.fsResultManager = [YMFFSquareResultManager new];
    }
    
    [YMFAPIManager startSearchForRestaurantsThatServe:self.txtCuisine.text
                                               within:[self.txtRange.text floatValue]
                                         onCompletion:^(id result) {
                                             [SVProgressHUD showSuccessWithStatus:@"Got a list of restaurants"];
                                             [SVProgressHUD showSuccessWithStatus:@"Parsing the list"];

                                             [_weakSelf.fsResultManager parseResultFromArray:result onSuccess:^(id result) {
                                                 NSLog(@"%@",result);
                                                 
                                                 
                                                 
                                                 
                                             }];
                                             
                                             NSLog(@"%@", result);
                                         } onFailure:^(NSString *error_code, NSString *message) {
                                             [SVProgressHUD showErrorWithStatus:message];
                                             NSLog(@"Error: %@", message);
                                         }];
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


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([segue.identifier isEqualToString:@"push_segue_searchresult"]) {
         YMFSearchLandingVC *srvc = (YMFSearchLandingVC *)segue.destinationViewController;
         [srvc setSearchResults:sender];
         
     }
 }

@end
