//
//  RegisterView.m
//  MVP
//
//  Created by Darshan on 14/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "RegisterView.h"
#import "StaticClass.h"
#import "CommonClass.h"
#import "AppDelegate.h"

@interface RegisterView ()

@end

@implementation RegisterView

//UIScrollView
@synthesize scrollV;

//UITextField
@synthesize txtName;
@synthesize txtEmailID;
@synthesize txtCreatePassword;
@synthesize txtConfirmPassword;
@synthesize txtDay;
@synthesize txtMonth;
@synthesize txtyear;
@synthesize txtMobile;

@synthesize txtlastname;
@synthesize txtcountrycode;




//Button
@synthesize btnLocation;
@synthesize btnMale;
@synthesize btnFemale;
@synthesize btnUKTop;
@synthesize btnUKBottom;
@synthesize btnCheckMark;
@synthesize btnTerms;
@synthesize btnSubmit;
@synthesize btnCancel;
@synthesize btnChestSize;
@synthesize btnWaistSize;
@synthesize btnColorSize;

//NSString
@synthesize strUKTop;
@synthesize strUKBottom;
@synthesize strChestSize;
@synthesize strWaistSize;
@synthesize strColarSize;

//UIView
@synthesize viewMale;
@synthesize viewFemale;

//UIToolBar
@synthesize toolDone;

AppDelegate *appDelegateRegister;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Firstname" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtName.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtName.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtName.leftViewMode = UITextFieldViewModeAlways;
    txtName.rightViewMode = UITextFieldViewModeAlways;
    txtName.layer.cornerRadius = 15.0;
    
    
    txtlastname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Lastname" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtlastname.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtlastname.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtlastname.leftViewMode = UITextFieldViewModeAlways;
    txtlastname.rightViewMode = UITextFieldViewModeAlways;
    txtlastname.layer.cornerRadius = 15.0;

    
    txtEmailID.attributedPlaceholder = [[NSAttributedString alloc] initWithString:EMailID attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtEmailID.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtEmailID.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtEmailID.leftViewMode = UITextFieldViewModeAlways;
    txtEmailID.rightViewMode = UITextFieldViewModeAlways;
    txtEmailID.layer.cornerRadius = 15.0;

    txtCreatePassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:CreatePassword attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtCreatePassword.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtCreatePassword.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtCreatePassword.leftViewMode = UITextFieldViewModeAlways;
    txtCreatePassword.rightViewMode = UITextFieldViewModeAlways;
    txtCreatePassword.layer.cornerRadius = 15.0;
    
    txtConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:ConfirmPassword attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtConfirmPassword.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtConfirmPassword.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtConfirmPassword.leftViewMode = UITextFieldViewModeAlways;
    txtConfirmPassword.rightViewMode = UITextFieldViewModeAlways;
    txtConfirmPassword.layer.cornerRadius = 15.0;
    
    txtMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtMobile.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtMobile.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtMobile.leftViewMode = UITextFieldViewModeAlways;
    txtMobile.rightViewMode = UITextFieldViewModeAlways;
    txtMobile.layer.cornerRadius = 15.0;

    
    txtcountrycode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"CC" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtcountrycode.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtcountrycode.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtcountrycode.leftViewMode = UITextFieldViewModeAlways;
    txtcountrycode.rightViewMode = UITextFieldViewModeAlways;
    txtcountrycode.layer.cornerRadius = 15.0;
    
    txtMonth.attributedPlaceholder = [[NSAttributedString alloc] initWithString:MM attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtMonth.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtMonth.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtMonth.inputAccessoryView = toolDone;
    txtMonth.leftViewMode = UITextFieldViewModeAlways;
    txtMonth.rightViewMode = UITextFieldViewModeAlways;
    txtMonth.layer.cornerRadius = 15.0;
    
    txtDay.attributedPlaceholder = [[NSAttributedString alloc] initWithString:DD attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtDay.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtDay.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtDay.inputAccessoryView = toolDone;
    txtDay.leftViewMode = UITextFieldViewModeAlways;
    txtDay.rightViewMode = UITextFieldViewModeAlways;
    txtDay.layer.cornerRadius = 15.0;
    
    txtyear.attributedPlaceholder = [[NSAttributedString alloc] initWithString:YYYY attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtyear.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftViewDate];
    txtyear.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftViewDate];
    txtyear.inputAccessoryView = toolDone;
    txtyear.leftViewMode = UITextFieldViewModeAlways;
    txtyear.rightViewMode = UITextFieldViewModeAlways;
    txtyear.layer.cornerRadius = 15.0;

    
    toolDone.translucent = YES;
    toolDone.barTintColor = appColor;
    
    btnLocation.layer.cornerRadius = 15.0f;
    btnLocation.layer.borderWidth = 1.0f;
    btnLocation.layer.borderColor = [UIColor grayColor].CGColor;
    
    btnUKTop.layer.cornerRadius = 15.0f;
    btnUKTop.layer.borderWidth = 1.0f;
    btnUKTop.layer.borderColor = [UIColor grayColor].CGColor;
    
    btnUKBottom.layer.cornerRadius = 15.0f;
    btnUKBottom.layer.borderWidth = 1.0f;
    btnUKBottom.layer.borderColor = [UIColor grayColor].CGColor;
    
    btnChestSize.layer.cornerRadius = 15.0f;
    btnChestSize.layer.borderWidth = 1.0f;
    btnChestSize.layer.borderColor = [UIColor grayColor].CGColor;
    
    btnWaistSize.layer.cornerRadius = 15.0f;
    btnWaistSize.layer.borderWidth = 1.0f;
    btnWaistSize.layer.borderColor = [UIColor grayColor].CGColor;
    
    btnColorSize.layer.cornerRadius = 15.0f;
    btnColorSize.layer.borderWidth = 1.0f;
    btnColorSize.layer.borderColor = [UIColor grayColor].CGColor;
    
    btnSubmit.layer.cornerRadius = 15.0f;
    btnCancel.layer.cornerRadius = 15.0f;
    
    constHeightMale.constant = 0.0f;
    constHeightFemale.constant = 0.0f;
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
    if([txtEmailID isFirstResponder]){
        [txtEmailID resignFirstResponder];
    }
    if([txtCreatePassword isFirstResponder]){
        [txtCreatePassword resignFirstResponder];
    }
    if([txtConfirmPassword isFirstResponder]){
        [txtConfirmPassword resignFirstResponder];
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
        
    if (textField == txtEmailID) {
        point = CGPointMake(0, 0);
    }else if(textField == txtCreatePassword){
        point = CGPointMake(0, 0);
    }else if (textField == txtConfirmPassword){
        point = CGPointMake(0, 100);
    }else if (textField == txtMobile){
        point = CGPointMake(0, 135);
    }
    else if(textField == txtDay){
        point = CGPointMake(0, 170);
    }else if (textField == txtMonth){
        point = CGPointMake(0, 170);
    }else if(textField == txtyear){
        point = CGPointMake(0, 170);
    }
    [scrollV setContentOffset:point animated:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(IBAction)onClickDoneWithNumberPad:(id)sender{
    
    [txtDay resignFirstResponder];
    [txtMonth resignFirstResponder];
    [txtyear resignFirstResponder];
    
    [scrollV setContentOffset:CGPointMake(0,0) animated:YES];
}


- (IBAction)onClickSelectLocationBtn:(UIButton *)sender {
    
}

- (IBAction)onClickMaleBtn:(UIButton *)sender {
    
    [btnUKTop setTitle:@"Select" forState:UIControlStateNormal];
    [btnUKBottom setTitle:@"Select" forState:UIControlStateNormal];
    
    [btnMale setSelected:YES];
    [btnFemale setSelected:NO];
    
    constHeightFemale.constant = 0.0f;
    viewFemale.hidden = YES;
    
    if (constHeightMale.constant != 130) {
        viewMale.hidden = NO;
        constHeightMale.constant = 130.0f;
    }else{
        viewMale.hidden = YES;
        constHeightMale.constant = 0.0f;
    }
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];

}

- (IBAction)onClickFemalBtn:(UIButton *)sender {
    
    [btnChestSize setTitle:@"Select" forState:UIControlStateNormal];
    [btnWaistSize setTitle:@"Select" forState:UIControlStateNormal];
    [btnColorSize setTitle:@"Select" forState:UIControlStateNormal];
    
    constHeightMale.constant = 0.0f;
    viewMale.hidden = YES;
    
    [btnFemale setSelected:YES];
    [btnMale setSelected:NO];
    
    if (constHeightFemale.constant != 82) {
        viewFemale.hidden = NO;
        constHeightFemale.constant = 82.0f;
    }else{
        viewFemale.hidden = YES;
        constHeightFemale.constant = 0.0f;
    }
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}

- (IBAction)onClickUKTopBtn:(UIButton *)sender {
    
    SelectedView *viewSelect  = [[SelectedView alloc]initWithNibName:@"SelectedView" bundle:nil];
    viewSelect.sizeDelegate = self;
    viewSelect.strSelect = @"UKTop";
    [self presentPopupViewController:viewSelect animationType:MJPopupViewAnimationFade];
    
}

- (IBAction)onClickUKBottomBtn:(UIButton *)sender {
    
    SelectedView *viewSelect  = [[SelectedView alloc]initWithNibName:@"SelectedView" bundle:nil];
    viewSelect.sizeDelegate = self;
    viewSelect.strSelect = @"UKBottom";
    [self presentPopupViewController:viewSelect animationType:MJPopupViewAnimationFade];
    
}
- (IBAction)onClickChestSizeBtn:(UIButton *)sender {
    
    SelectedView *viewSelect  = [[SelectedView alloc]initWithNibName:@"SelectedView" bundle:nil];
    viewSelect.sizeDelegate = self;
    viewSelect.strSelect = @"ChestSize";
    [self presentPopupViewController:viewSelect animationType:MJPopupViewAnimationFade];
    
}

- (IBAction)onClickWaistSizeBtn:(UIButton *)sender {
    
    SelectedView *viewSelect  = [[SelectedView alloc]initWithNibName:@"SelectedView" bundle:nil];
    viewSelect.sizeDelegate = self;
    viewSelect.strSelect = @"WaistSize";
    [self presentPopupViewController:viewSelect animationType:MJPopupViewAnimationFade];
    
}

- (IBAction)onClickColorSizeBtn:(UIButton *)sender {
    
    SelectedView *viewSelect  = [[SelectedView alloc]initWithNibName:@"SelectedView" bundle:nil];
    viewSelect.sizeDelegate = self;
    viewSelect.strSelect = @"ColarSize";
    [self presentPopupViewController:viewSelect animationType:MJPopupViewAnimationFade];
    
}

- (IBAction)onClickCheckBtn:(UIButton *)sender {
    
    if ([btnCheckMark isSelected]) {
        [btnCheckMark setSelected:NO];
    }else{
        [btnCheckMark setSelected:YES];
    }
}

-(void)selectSizePopUp:(NSString *)strSize andReturnType:(NSString *)strType
{
    
    if ([strType isEqualToString:@"UKTop"]) {
       [btnUKTop setTitle:strSize forState:UIControlStateNormal];
        strUKTop = strSize;
    }else if ([strType isEqualToString:@"UKBottom"]){
       [btnUKBottom setTitle:strSize forState:UIControlStateNormal];
        strUKBottom = strSize;
    }else if ([strType isEqualToString:@"ChestSize"]){
        [btnChestSize setTitle:strSize forState:UIControlStateNormal];
        strChestSize = strSize;
    }else if ([strType isEqualToString:@"WaistSize"]){
        [btnWaistSize setTitle:strSize forState:UIControlStateNormal];
        strWaistSize = strSize;
    }else if ([strType isEqualToString:@"ColarSize"]){
        [btnColorSize setTitle:strSize forState:UIControlStateNormal];
        strColarSize = strSize;
    }
    NSLog(@"strType>>> %@",strType);
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

-(BOOL)RegisterValidate
{
    NSString *strName  = [CommonClass trimString:txtName.text];
    NSString *strEmailID  = [CommonClass trimString:txtEmailID.text];
    NSString *strPassword  = [CommonClass trimString:txtCreatePassword.text];
    NSString *strConfirmPassword  = [CommonClass trimString:txtConfirmPassword.text];
    NSString *strMonth  = [CommonClass trimString:txtMonth.text];
    NSString *strDay  = [CommonClass trimString:txtDay.text];
    NSString *strYear  = [CommonClass trimString:txtyear.text];
    NSString *strMobile  = [CommonClass trimString:txtMobile.text];
    
    NSInteger monthInt = [strMonth integerValue];
    NSInteger dayInt = [strDay integerValue];
    
    if ([strName length] == 0) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideUserName delegate:self];
        return NO;
    }
    if ([strEmailID length] == 0) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideEmaiID delegate:self];
        return NO;
    }
    if(![CommonClass textIsValidEmailFormat:strEmailID]){
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideValidEmail delegate:self];
        return NO;
    }
    if ([strPassword length] == 0) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideCreatePassword delegate:self];
        return NO;
    }
    
    
//    if([strPassword length] < 6){
//        [CommonClass showAlertWithTitle:provideAlert andMessage:providePasswordStatus delegate:self];
//        return NO;
//    }
    if ([strConfirmPassword length] == 0) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideConfirmPassword delegate:self];
        return NO;
    }
    if(![strPassword isEqualToString:strConfirmPassword]){
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideBothSame delegate:self];
        return NO;
    }
    
    if(![strPassword isEqualToString:strConfirmPassword]){
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideBothSame delegate:self];
        return NO;
    }
    if ([strDay length] == 0) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideDay delegate:self];
        return NO;
    }
    if ([strDay length] > 2) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideDayNumber delegate:self];
        return NO;
    }
    if (dayInt > 31) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideValidDay delegate:self];
        return NO;
    }
    if ([strMobile length] < 10) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:@"Please enter mobile no." delegate:self];
        return NO;
    }
    if ([strMonth length] == 0) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideMonth delegate:self];
        return NO;
    }
    if ([strMonth length] > 2) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideMonthNumber delegate:self];
        return NO;
    }
    if (monthInt > 12) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideValidMonth delegate:self];
        return NO;
    }
    if ([strMonth length] < 2) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideMonthNumber delegate:self];
        return NO;
    }
    if ([strYear length] == 0) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideYear delegate:self];
        return NO;
    }
    if ([strYear length] > 4) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideYearNumber delegate:self];
        return NO;
    }
    if ([strYear length] < 4) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideYearNumber delegate:self];
        return NO;
    }
    if (btnMale.isSelected == NO && btnFemale.isSelected == NO) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideGender delegate:self];
        return NO;
    }
    if (btnMale.isSelected) {
        /* I HAVE CHNAGED THIS BECUASE OF IT IS NOT COMPULSORY AS PER CHANGES*/
//        if ([btnChestSize.titleLabel.text isEqualToString:@"Select"]) {
//            [CommonClass showAlertWithTitle:provideAlert andMessage:provideChestSize delegate:self];
//            return YES;
//        }
//        if ([btnWaistSize.titleLabel.text isEqualToString:@"Select"]){
//            [CommonClass showAlertWithTitle:provideAlert andMessage:provideWaistSize delegate:self];
//            return YES;
//        }
//        if ([btnColorSize.titleLabel.text isEqualToString:@"Select"]){
//            [CommonClass showAlertWithTitle:provideAlert andMessage:provideColarSize delegate:self];
//            return YES;
//        }
    }
    if (btnFemale.isSelected) {
//          /* I HAVE CHNAGED THIS BECUASE OF IT IS NOT COMPULSORY AS PER CHANGES*/
//        if ([btnUKTop.titleLabel.text isEqualToString:@"Select"]) {
//            [CommonClass showAlertWithTitle:provideAlert andMessage:provideUKTopSize delegate:self];
//            return YES;
//        }
//        if ([btnUKBottom.titleLabel.text isEqualToString:@"Select"]){
//            [CommonClass showAlertWithTitle:provideAlert andMessage:provideUKBottomSize delegate:self];
//            return YES;
//        }
    }
    if (!btnCheckMark.isSelected) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideTermsAndCodition delegate:self];
        return NO;
    }
    return YES;
}

- (IBAction)onClickSubmitBtn:(UIButton *)sender {
    
    /*
     Register Service
     
     1) For male :-
     Link :-  http://mahatmainfoware.com/iphoneAppServices/registeruser.php
     parameters :-  email,password,location,bdate,gender,chest,waist,colar
     Response  :-   Status,email and message
     
     2) For Female :-
     Link :-  http://mahatmainfoware.com/iphoneAppServices/registeruser.php
     parameters :-  email,password,location,bdate,gender,top,bottom
     Response  :-   Status,email and message
     */
    
    if ([self RegisterValidate]) {
        if (btnMale.isSelected == YES) {
            
            strUKTop = nil;
            strUKBottom = nil;
            
            NSString *strDate = [NSString stringWithFormat:@"%@-%@-%@",txtDay.text,txtMonth.text,txtyear.text];
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            
            if (strChestSize  == nil) {
                strChestSize = @"";
            }if (strWaistSize  == nil) {
                strWaistSize = @"";
            }
            if (strColarSize  == nil) {
                strColarSize = @"";
            }
            
            [params setObject:txtName.text forKey:@"user_name"];
            [params setObject:txtlastname.text forKey:@"lname"];
            [params setObject:txtEmailID.text forKey:@"email"];
            [params setObject:txtConfirmPassword.text forKey:@"password"];
            
            [params setObject:txtcountrycode.text forKey:@"cc"];
            [params setObject:txtMobile.text forKey:@"Mobile"];
            [params setObject:@"London" forKey:@"location"];
            [params setObject:strDate forKey:@"bdate"];
            [params setObject:@"Male" forKey:@"gender"];
            [params setObject:strChestSize forKey:@"chest"];
            [params setObject:strWaistSize forKey:@"waist"];
            [params setObject:strColarSize forKey:@"colar"];
            
            [SHARED_APPDELEGATE showLoadingView];
            
            [manager POST:register_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                [SHARED_APPDELEGATE hideLoadingView];
                NSLog(@"ResponceLogin %@",responseObject);
                
                if ([[responseObject objectForKey:@"Status"] boolValue]) {
                    [CommonClass showAlertWithTitle:provideAlert andMessage:[responseObject objectForKey:@"message"] delegate:self];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [CommonClass showAlertWithTitle:provideAlert andMessage:@"SomeThings is Wrong" delegate:self];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [SHARED_APPDELEGATE hideLoadingView];
                NSLog(@"Error: %@", error);
                NSLog(@"operation %@ " , operation);
            }];
            
        }else if (btnFemale.isSelected == YES){
            
            strChestSize = nil;
            strWaistSize = nil;
            strColarSize = nil;
            
            NSString *strDate = [NSString stringWithFormat:@"%@-%@-%@",txtDay.text,txtMonth.text,txtyear.text];
            
            if (strUKTop == nil) {
                strUKTop = @"";
            } if (strUKBottom == nil) {
                strUKBottom = @"";
            }
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            
            [params setObject:txtName.text forKey:@"user_name"];
             [params setObject:txtlastname.text forKey:@"lname"];
            [params setObject:txtEmailID.text forKey:@"email"];
            
            [params setObject:txtConfirmPassword.text forKey:@"password"];
            [params setObject:txtcountrycode.text forKey:@"cc"];
            [params setObject:txtMobile.text forKey:@"Mobile"];
            
            [params setObject:@"Rajkot" forKey:@"location"];
            [params setObject:strDate forKey:@"bdate"];
            [params setObject:@"Female" forKey:@"gender"];
            [params setObject:strUKTop forKey:@"top"];
            [params setObject:strUKBottom forKey:@"bottom"];
            
            [SHARED_APPDELEGATE showLoadingView];
            
            [manager POST:register_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                [SHARED_APPDELEGATE hideLoadingView];
                NSLog(@"ResponceLogin %@",responseObject);
                [self.navigationController popViewControllerAnimated:YES];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [SHARED_APPDELEGATE hideLoadingView];
                NSLog(@"Error: %@", error);
                NSLog(@"operation %@ " , operation);
            }];
            
        }
    }
}

- (IBAction)onClickCancelBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
