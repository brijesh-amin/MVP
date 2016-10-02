//
//  SharePapView.m
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "SharePapView.h"
#import "AttributView.h"
#import "AppDelegate.h"
#import "StaticClass.h"

@interface SharePapView ()

@end

@implementation SharePapView

@synthesize arrSelected;

//UITExtField
@synthesize txtTypeUrl;

//UIView
@synthesize viewImg;
@synthesize viewBack;

//UIButton
@synthesize btnSelect;
@synthesize btnItem;
@synthesize btnCustomerName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"Share Pap" fontSize:18];
    
    txtTypeUrl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:TypeUrl attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtTypeUrl.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtTypeUrl.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtTypeUrl.leftViewMode = UITextFieldViewModeAlways;
    txtTypeUrl.rightViewMode = UITextFieldViewModeAlways;
    txtTypeUrl.layer.cornerRadius = 15.0;

    viewBack.layer.cornerRadius = 4.0f;
    viewBack.clipsToBounds = YES;
    
    viewImg.layer.cornerRadius = 4.0f;
    viewImg.layer.borderWidth = 1.0f;
    viewImg.layer.borderColor = [UIColor grayColor].CGColor;
    
    btnSelect.layer.cornerRadius = 12.0f;
    btnItem.layer.cornerRadius = 12.0f;
    btnCustomerName.layer.cornerRadius = 12.0f;
}

#pragma mark -
#pragma mark - TextField Return Keyboard Method

-(void)hideallKeyBoard
{
    if([txtTypeUrl isFirstResponder]){
        [txtTypeUrl resignFirstResponder];
    }
}

#pragma mark -
#pragma mark - TEXT FILED DELEGATE

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hideallKeyBoard];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint point;
    
    if (textField == txtTypeUrl) {
        point = CGPointMake(0, 0);
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
- (IBAction)onClickSelectBtn:(UIButton *)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSMutableArray arrayWithObjects:@"Me", @"Dad", @"Uncle", @"Brother", @"Sister", @"Mother", @"Aunt", @"Grandad", @"Grandma", @"Cousion Male",@"Cousion Female",nil];
    if(dropDown == nil) {
        CGFloat f = 220;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"up"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
    NSLog(@"%@", btnSelect.titleLabel.text);
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}

- (IBAction)onClickItemBtn:(UIButton *)sender {
    
}

- (IBAction)onClickCustomerNameBtn:(UIButton *)sender {
    
    AttributView *viewAttribut = [[AttributView alloc] initWithNibName:@"AttributView" bundle:nil];
    [self.navigationController pushViewController:viewAttribut animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
