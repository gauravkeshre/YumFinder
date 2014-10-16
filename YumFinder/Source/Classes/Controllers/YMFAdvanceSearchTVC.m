//
//  YMFAdvanceSearchTVC.m
//  YumFinder
//
//  Created by Summer Green on 10/2/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFAdvanceSearchTVC.h"
#import "NSString+Validator.h"
#import "UITextView+Additions.h"

@interface YMFAdvanceSearchTVC ()
@property (weak, nonatomic) IBOutlet UITextField *txtCuisine;
@property (weak, nonatomic) IBOutlet UITextField *txtDistance;
@property (weak, nonatomic) IBOutlet UITextField *txtRating;
@property (weak, nonatomic) IBOutlet UITextField *txtPrice;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;

- (IBAction)handleSearchButton:(id)sender;
- (IBAction)handleBackButton:(id)sender;
- (IBAction)handleExclaimation:(UIButton *)sender;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *exclaimationButtons;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;
@property (strong, nonatomic) NSMutableArray *mArrInvalidFields;

@property (strong, nonatomic) NSArray *errorMessages;

@end

@implementation YMFAdvanceSearchTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    for (UIButton *btn in self.exclaimationButtons) {
        [btn setHidden:YES];
    }
    
    for (NSInteger i=0; i<self.textFields.count; i++) {
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
        leftView.backgroundColor = [UIColor clearColor];
        UITextField *__weak tf = (UITextField *)self.textFields[i];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView =leftView;
        leftView =nil;
        [tf setDelegate:self];
        
        [(UIButton *)self.exclaimationButtons[i] setHidden:YES];
        
    }
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"flat_blue_square"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Conv Methods
-(BOOL)validateSearchInputs{
    BOOL flag = YES;
    if (self.mArrInvalidFields==nil) {
        self.mArrInvalidFields = [[NSMutableArray alloc]init];
    }
    [self.mArrInvalidFields removeAllObjects];

    for (UITextField *tf in self.textFields) {
        switch (tf.tag) {
            case YMFSearchParamTypeDistnce:
            case YMFSearchParamTypeRating:
            case YMFSearchParamTypePrice:{
                BOOL b = ([tf.text isValidNumeric] && ![tf isEmpty]);
                if (!b) {
                    [self.mArrInvalidFields addObject:@(tf.tag)];
                    [tf shake];
                }
                flag &=b;
            }
                break;
            case YMFSearchParamTypeCuisine:
            case YMFSearchParamTypeAddress:
            {
                BOOL b = ![tf isEmpty];
                if (!b) {
                    [self.mArrInvalidFields addObject:@(tf.tag)];
                    [tf shake];
                }
                flag &=b;
            }
                break;
        }
    }
    return flag;
}


-(void)updateViewForInvalidInputs{
    
    for (UIButton *btn in self.exclaimationButtons) {
        [btn setHidden:![self.mArrInvalidFields containsObject:@(btn.tag)]];
    }
}

#pragma mark - Search Methods

-(void)searchAction{
    
}


#pragma mark - IBAction Methods
- (IBAction)handleSearchButton:(id)sender {
    if (![self validateSearchInputs]) {
        [self updateViewForInvalidInputs];
    }else{
        [self searchAction];
    }
    
}

- (IBAction)handleBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)handleExclaimation:(UIButton *)sender {
    
}
#pragma mark - UITextFieldDelegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSUInteger indexOfSource =textField.tag-100;
    NSUInteger indexOfDestin = indexOfSource+1%self.textFields.count;
    
    if (indexOfDestin == 0 || indexOfDestin >=self.textFields.count) {
        [textField resignFirstResponder];
    }else{
    UITextField *__weak tDestin = self.textFields[indexOfDestin];
        [tDestin becomeFirstResponder];
    }
    
    return YES;
}
@end
