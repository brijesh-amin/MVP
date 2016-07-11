//
//  AttributView.m
//  MVP
//
//  Created by Darshan on 20/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "AttributView.h"
#import "StaticClass.h"
#import "AppDelegate.h"

@interface AttributView ()

@end

@implementation AttributView

//UIView
@synthesize viewImg;
@synthesize viewLeft;
@synthesize viewRight;

//UITextField
@synthesize txtAttribute;
@synthesize txtAttribute1;
@synthesize txtAttribute2;
@synthesize txtAttribute3;
@synthesize txtAttribute4;
@synthesize txtAttribute5;
@synthesize txtAttribute6;
@synthesize txtAttribute7;
@synthesize txtAttribute8;

//UIButton
@synthesize btnSend;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"Attribut" fontSize:18];
    
    UIImage *backButtonImage = [UIImage imageNamed:@"Back"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:backButtonImage
                forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    
    [backButton addTarget:self
                   action:@selector(popViewController)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    btnSend.layer.cornerRadius = 15.0f;
    UIBarButtonItem *barBtnFilter = [[UIBarButtonItem alloc] initWithCustomView:btnSend];
    self.navigationItem.rightBarButtonItems = @[barBtnFilter];
    
    txtAttribute1.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Attribute1 attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtAttribute1.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute1.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute1.leftViewMode = UITextFieldViewModeAlways;
    txtAttribute1.rightViewMode = UITextFieldViewModeAlways;
    txtAttribute1.layer.cornerRadius = 5.0f;
    
    txtAttribute2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Attribute2 attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtAttribute2.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute2.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute2.leftViewMode = UITextFieldViewModeAlways;
    txtAttribute2.rightViewMode = UITextFieldViewModeAlways;
    txtAttribute2.layer.cornerRadius = 5.0f;
    
    txtAttribute3.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Attribute3 attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtAttribute3.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute3.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute3.leftViewMode = UITextFieldViewModeAlways;
    txtAttribute3.rightViewMode = UITextFieldViewModeAlways;
    txtAttribute3.layer.cornerRadius = 5.0f;
    
    txtAttribute4.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Attribute4 attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtAttribute4.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute4.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute4.leftViewMode = UITextFieldViewModeAlways;
    txtAttribute4.rightViewMode = UITextFieldViewModeAlways;
    txtAttribute4.layer.cornerRadius = 5.0f;
    
    txtAttribute5.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Attribute5 attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtAttribute5.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute5.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute5.leftViewMode = UITextFieldViewModeAlways;
    txtAttribute5.rightViewMode = UITextFieldViewModeAlways;
    txtAttribute5.layer.cornerRadius = 5.0f;
    
    txtAttribute6.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtAttribute6.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute6.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute6.leftViewMode = UITextFieldViewModeAlways;
    txtAttribute6.rightViewMode = UITextFieldViewModeAlways;
    txtAttribute6.layer.cornerRadius = 5.0f;
    
    txtAttribute7.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtAttribute7.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute7.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute7.leftViewMode = UITextFieldViewModeAlways;
    txtAttribute7.rightViewMode = UITextFieldViewModeAlways;
    txtAttribute7.layer.cornerRadius = 5.0f;
    
    txtAttribute8.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtAttribute8.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute8.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute8.leftViewMode = UITextFieldViewModeAlways;
    txtAttribute8.rightViewMode = UITextFieldViewModeAlways;
    txtAttribute8.layer.cornerRadius = 5.0f;
    
    txtAttribute.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtAttribute.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtAttribute.leftViewMode = UITextFieldViewModeAlways;
    txtAttribute.rightViewMode = UITextFieldViewModeAlways;
    txtAttribute.layer.cornerRadius = 5.0f;
    
    
    viewImg.layer.cornerRadius = 4.0f;
    viewImg.layer.borderWidth = 2.0f;
    viewImg.layer.borderColor = [UIColor whiteColor].CGColor;
    
    viewLeft.layer.cornerRadius = 4.0f;
    viewLeft.layer.borderWidth = 1.0f;
    viewLeft.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    viewRight.layer.cornerRadius = 4.0f;
    viewRight.layer.borderWidth = 1.0f;
    viewRight.layer.borderColor = [UIColor darkGrayColor].CGColor;

}

#pragma mark -
#pragma mark - Pop To View Mothod

-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
