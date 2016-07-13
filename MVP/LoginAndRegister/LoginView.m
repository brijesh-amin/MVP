//
//  LoginView.m
//  MVP
//
//  Created by Darshan on 14/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "LoginView.h"
#import "StaticClass.h"
#import "CommonClass.h"
#import "RegisterView.h"
#import "NewsFeedView.h"
#import "ForgotPasswordView.h"
#import "AppDelegate.h"

@interface LoginView ()

@end

@implementation LoginView

//UIScrollView
@synthesize  scrollV;

//Button
@synthesize btnSignIn;
@synthesize btnFb;
@synthesize btnForgotPassword;
@synthesize btnRegister;
@synthesize btnTerms;

//UITextField
@synthesize txtUserName;
@synthesize txtPassword;

AppDelegate *appDelegateLogin;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
//    txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:UserName attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Neue" size:12]}];
    
    txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Email_ID attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    txtUserName.leftView = [SHARED_APPDELEGATE getTextFieldLeftAndRightView];
    txtUserName.rightView = [SHARED_APPDELEGATE getTextFieldLeftAndRightView];
    txtUserName.leftViewMode = UITextFieldViewModeAlways;
    txtUserName.rightViewMode = UITextFieldViewModeAlways;
    txtUserName.layer.cornerRadius = 20.0;
    
//    txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Password attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Neue" size:12]}];
    txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Password attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    txtPassword.leftView = [SHARED_APPDELEGATE getTextFieldLeftAndRightView];
    txtPassword.rightView = [SHARED_APPDELEGATE getTextFieldLeftAndRightView];
    txtPassword.leftViewMode = UITextFieldViewModeAlways;
    txtPassword.rightViewMode = UITextFieldViewModeAlways;
    txtPassword.layer.cornerRadius = 20.0;

    
    btnSignIn.layer.cornerRadius = 20.0f;
    btnSignIn.layer.borderWidth = 1.0f;
    btnSignIn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    btnFb.layer.cornerRadius = 20.0f;
    btnRegister.layer.cornerRadius = 20.0f;
}

#pragma mark -
#pragma mark - ViewWillDisappear Method

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideallKeyBoard];
}

#pragma mark -
#pragma mark - TextField Return Keyboard Method

-(void)hideallKeyBoard
{
    if([txtUserName isFirstResponder]){
        [txtUserName resignFirstResponder];
    }
    if([txtPassword isFirstResponder]){
        [txtPassword resignFirstResponder];
    }
}

#pragma mark -
#pragma mark - TEXT FILED DELEGATE

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag;
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag+1];
    
    if (nextResponder)
    {
        [scrollV setContentOffset:CGPointMake(0,textField.center.y-100) animated:YES];
        [nextResponder becomeFirstResponder];
    }
    else
    {
        [scrollV setContentOffset:CGPointMake(0,0) animated:YES];
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint point;
    
    if (textField == txtUserName) {
        point = CGPointMake(0, 0);
    }
    else if(textField == txtPassword){
        point = CGPointMake(0, 0);
    }
    [scrollV setContentOffset:point animated:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

#pragma mark -
#pragma mark - TextField Login Validation Method

-(BOOL)LoginValidate
{
    NSString *strUserName  = [CommonClass trimString:txtUserName.text];
    NSString *strPassword  = [CommonClass trimString:txtPassword.text];
    
    if ([strUserName length] == 0) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideUserName delegate:self];
        return NO;
    }
    if ([strPassword length] == 0) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:providePassword delegate:self];
        return NO;
    }
    
    return YES;
}

- (IBAction)onClickSignInBtn:(UIButton *)sender {
    
    if ([self LoginValidate]) {
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        NSString *strDeviceID = nil;
        
#if TARGET_OS_SIMULATOR
        
        strDeviceID = [NSString stringWithFormat:@" "];
        
#else
        
        strDeviceID = [[NSUserDefaults standardUserDefaults]objectForKey:DEVICE_ID];
        
#endif
         strDeviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        NSLog(@"uniqueIdentifier %@",strDeviceID);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        
        [params setObject:txtUserName.text forKey:@"email"];
        [params setObject:txtPassword.text forKey:@"password"];
        [params setObject:strDeviceID forKey:@"device_id"];
        
        [userDefault setObject:strDeviceID forKey:DEVICE_ID];
        [userDefault setObject:txtUserName.text forKey:USEREMAILID];
        
        [userDefault synchronize];
        
        [SHARED_APPDELEGATE showLoadingView];
        
        [manager POST:login_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [SHARED_APPDELEGATE hideLoadingView];
            NSLog(@"ResponceLogin %@",responseObject);
            
            if ([[responseObject objectForKey:@"Status"] boolValue]) {
                [userDefault setObject:[responseObject objectForKey:@"name"] forKey:NAME];
                [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"ISLOGIN"];
                [[AppDelegate sharedAppDelegate] createAccountOrLogin];
            }else{
                [CommonClass showAlertWithTitle:provideAlert andMessage:[responseObject objectForKey:@"message"] delegate:self];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [SHARED_APPDELEGATE hideLoadingView];
            NSLog(@"Error: %@", error);
            NSLog(@"operation %@ " , operation);
        }];
    }
}

- (IBAction)onClickFbButton:(UIButton *)sender {
    
}

- (IBAction)onClickForgotPasswordBtn:(UIButton *)sender {
    
    ForgotPasswordView *viewForgot = [[ForgotPasswordView alloc] initWithNibName:@"ForgotPasswordView" bundle:nil];
    [self.navigationController pushViewController:viewForgot animated:YES];
}

- (IBAction)onClickRegisterBtn:(UIButton *)sender {
 
    RegisterView *viewRegister = [[RegisterView alloc] initWithNibName:@"RegisterView" bundle:nil];
    [self.navigationController pushViewController:viewRegister animated:YES];
}

- (IBAction)onClickTermsAndCondition:(UIButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
