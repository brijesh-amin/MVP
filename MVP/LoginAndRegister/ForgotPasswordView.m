//
//  ForgotPasswordView.m
//  MVP
//
//  Created by Darshan on 04/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "ForgotPasswordView.h"
#import "StaticClass.h"
#import "CommonClass.h"
#import "AppDelegate.h"

@interface ForgotPasswordView ()

@end

@implementation ForgotPasswordView

@synthesize txtMail;
@synthesize btnSend;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    txtMail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Email_ID attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    txtMail.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftViewDate];
    txtMail.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftViewDate];
    txtMail.leftViewMode = UITextFieldViewModeAlways;
    txtMail.rightViewMode = UITextFieldViewModeAlways;
    txtMail.layer.cornerRadius = 20.0;
    
    btnSend.layer.cornerRadius = 20.0f;
}

#pragma mark -
#pragma mark - TEXT FILED DELEGATE

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)onClickBackBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated: YES];
}

-(BOOL)ForgotPassworValidate
{
    NSString *strEmailID  = [CommonClass trimString:txtMail.text];
    
    if ([strEmailID length] == 0) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideEmaiID delegate:self];
        return NO;
    }
    if(![CommonClass textIsValidEmailFormat:strEmailID]){
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideValidEmail delegate:self];
        return NO;
    }
    return YES;
}


- (IBAction)onClickForgotPasswordBtn:(UIButton *)sender {
    
    if ([self ForgotPassworValidate]) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        
        [params setObject:txtMail.text forKey:@"email"];
        
        [SHARED_APPDELEGATE showLoadingView];
        
        [manager POST:forgot_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [SHARED_APPDELEGATE hideLoadingView];
            NSLog(@"ResponceLogin %@",responseObject);
            
            if ([[responseObject objectForKey:@"Status"] boolValue]) {
                [CommonClass showAlertWithTitle:provideAlert andMessage:[responseObject objectForKey:@"message"] delegate:self];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
