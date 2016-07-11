//
//  SharePapView.m
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "SharePapView.h"
#import "AttributView.h"

#define TypeUrl @"Type url.. Here"
#define ItemType @"Item Type"
#define CustomerName @"Customer Name"
#define provideAlert @"Alert !"
#define provideFailed @"Failed !"
#define provideCancel @"Cancel"
#define provideOk @"Ok"
#define SELECTFAMILY @"SelectFamily"
#define ITEMTYPE @"ItemType"
#define URLTYPE @"urlType"
#define PRODUCTTITLE @"productTitle"
//#define SHARED_APPDELEGATE [AppDelegate sharedAppDelegate]

@interface SharePapView ()

@end

@implementation SharePapView

@synthesize arrSelected;
@synthesize stritemtype;
//UITExtField
@synthesize txtTypeUrl;
@synthesize txtItem;
@synthesize txtCustomerName;

//UIView
@synthesize viewImg;
@synthesize viewBack;
@synthesize viewOther;

@synthesize txtOther;

//UIButton
@synthesize btnSelect;
@synthesize btnOK;

//UIScrollView
@synthesize scrollV;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getNavigationWithTitle:@"Share Pap" fontSize:18];
    
    txtTypeUrl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:TypeUrl attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtTypeUrl.leftView = [self getTextFieldRightAndLeftView];
    txtTypeUrl.rightView = [self getTextFieldRightAndLeftView];
    txtTypeUrl.leftViewMode = UITextFieldViewModeAlways;
    txtTypeUrl.rightViewMode = UITextFieldViewModeAlways;
    txtTypeUrl.layer.cornerRadius = 15.0;
    
    txtItem.attributedPlaceholder = [[NSAttributedString alloc] initWithString:ItemType attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtItem.leftView = [self getTextFieldRightAndLeftView];
    txtItem.rightView = [self getTextFieldRightAndLeftView];
    txtItem.leftViewMode = UITextFieldViewModeAlways;
    txtItem.rightViewMode = UITextFieldViewModeAlways;
    txtItem.layer.cornerRadius = 13.0;

    txtOther.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Other" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtOther.leftView = [self getTextFieldRightAndLeftView];
    txtOther.rightView = [self getTextFieldRightAndLeftView];
    txtOther.leftViewMode = UITextFieldViewModeAlways;
    txtOther.rightViewMode = UITextFieldViewModeAlways;
    txtOther.layer.cornerRadius = 13.0;
    
//    txtCustomerName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:CustomerName attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtCustomerName.leftView = [self getTextFieldRightAndLeftView];
    txtCustomerName.rightView = [self getTextFieldRightAndLeftView];
    txtCustomerName.leftViewMode = UITextFieldViewModeAlways;
    txtCustomerName.rightViewMode = UITextFieldViewModeAlways;
    txtCustomerName.layer.cornerRadius = 13.0;

    NSString *strProductTitle = [[NSUserDefaults standardUserDefaults]objectForKey:PRODUCTTITLE];
    
    NSString *string = strProductTitle;
    //NSString *string = @"Men Jacket";
    NSLog(@"keyword",string);
    //[@"Men" rangeOfString:string options:NSCaseInsensitiveSearch];
    if ([string rangeOfString:@"Men" options:NSCaseInsensitiveSearch].location != NSNotFound) {
        
        if ([string rangeOfString:@"jacket" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            if([string rangeOfString:@"leather" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                stritemtype=@"Men's Leather Jacket";
            }
            else
            {
                stritemtype=@"Mens Jacket";
            }
            
        }
        if([string rangeOfString:@"overcoat" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"coat" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Men's Overcoat";
        }
        if([string rangeOfString:@"Raincoat" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Mac" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Macintosh" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Mens Raincoat";
           // temparr = arr1;
        }
        if([string rangeOfString:@"Hoodie" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Hoodie";
        }
        if([string rangeOfString:@"Sweatshirt" options:NSCaseInsensitiveSearch].location != NSNotFound )
        {
            stritemtype=@"Sweatshirt";
        }
        if([string rangeOfString:@"Sweater" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Mens Sweater";
        }
        if([string rangeOfString:@"Cardigan" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Mens Cardigan";
        }
        if([string rangeOfString:@"pullover" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"jumper" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Mens Pullover";//temparr=arr3;
        }
        
        if([string rangeOfString:@"jeans" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Mens Jeans";//temparr=arr5;
        }
        if([string rangeOfString:@"trousers" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Mens Trousers";//temparr=arr6;
        }
        if([string rangeOfString:@"Waistcoat" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Waistcoat";//temparr=arr8;
        }
        if([string rangeOfString:@"T-shirt" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Mens T-Shirt";
        }
        if([string rangeOfString:@"Polo" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"shirt" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
           stritemtype=@"Mens Polo Shirt";// temparr=arr11;
        }
        if([string rangeOfString:@"Formal" options:NSCaseInsensitiveSearch].location != NSNotFound )
        {
            stritemtype=@"Mens Formal Shirt";
        }
        if([string rangeOfString:@"Casual" options:NSCaseInsensitiveSearch].location != NSNotFound )
        {
            stritemtype=@"Mens Casual Shirt";//temparr=arr17;
        }
    }else if ([string rangeOfString:@"shirt" options:NSCaseInsensitiveSearch].location != NSNotFound){
        
      if ([string rangeOfString:@"Polo" options:NSCaseInsensitiveSearch].location != NSNotFound){
            
            stritemtype=@"Mens Polo Shirt";//temparr=arr17;
            
        }
        if ([string rangeOfString:@"Formal" options:NSCaseInsensitiveSearch].location != NSNotFound){
            
            stritemtype=@"Mens Formal Shirt";//temparr=arr17;
            
        }if ([string rangeOfString:@"Evening" options:NSCaseInsensitiveSearch].location != NSNotFound){
            
            stritemtype=@"Mens Evening Shirt";//temparr=arr17;
            
        }if ([string rangeOfString:@"Casual" options:NSCaseInsensitiveSearch].location != NSNotFound){
            
            stritemtype=@"Mens Casual Shirt";//temparr=arr17;
            
        }else{
             stritemtype=@"Mens Shirt";
        }
        
    }
    else if ([string rangeOfString:@"T-shirt" options:NSCaseInsensitiveSearch].location != NSNotFound){
        
         stritemtype=@"Mens T-shirt";//temparr=arr17;
        
    }
    else if ([string rangeOfString:@"jacket" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Mens" options:NSCaseInsensitiveSearch].location != NSNotFound){
        
        stritemtype=@"Mens Jacket";//temparr=arr17;
        
    }
    else if([string rangeOfString:@"Ladies" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        
        if ([string rangeOfString:@"jacket" options:NSCaseInsensitiveSearch].location != NSNotFound )
        {
            if([string rangeOfString:@"leather" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                stritemtype=@"Ladies Leather Jacket";
            }
            else
            {
                stritemtype=@"Ladies Jacket";
            }
        }
        if([string rangeOfString:@"overcoat" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"coat" options:NSCaseInsensitiveSearch].location != NSNotFound )
        {
            stritemtype=@"Ladies Overcoat";
        }
        if([string rangeOfString:@"Raincoat" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Mac" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Macintosh" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Ladies Raincoat";//temparr = arr1;
        }
        if([string rangeOfString:@"wedding" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Dress" options:NSCaseInsensitiveSearch].location != NSNotFound )
        {
            stritemtype=@"Wedding Dresses";
        }
        if([string rangeOfString:@"Maxi" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Dress" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Maxi Dresses";
        }
        if([string rangeOfString:@"Mini" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Dress" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Mini Dresses";
        }
        if([string rangeOfString:@"Workwear" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Dress" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"WorkWear Dresses";//temparr=arr2;
        }
        if([string rangeOfString:@"Hoodie" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Hoodie";
        }
        if([string rangeOfString:@"Sweatshirt" options:NSCaseInsensitiveSearch].location != NSNotFound )
        {
            stritemtype=@"Sweatshirt";
        }
        if([string rangeOfString:@"Sweater" options:NSCaseInsensitiveSearch].location != NSNotFound )
        {
            stritemtype=@"Sweater";
        }
        if([string rangeOfString:@"Cardigan" options:NSCaseInsensitiveSearch].location != NSNotFound )
        {
            stritemtype=@"Ladies Cardigan";//temparr=arr3;
        }
        if([string rangeOfString:@"jeans" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Ladies Jeans";//temparr=arr5;
        }
        if([string rangeOfString:@"Leggings" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Ladies Leggings";//temparr=arr6;
        }
        if([string rangeOfString:@"T-shirt" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Ladies T-shirt";//temparr=arr11;
        }
        if([string rangeOfString:@"Blouse" options:NSCaseInsensitiveSearch].location != NSNotFound )
        {
            stritemtype=@"Ladies Formal Blouse";
        }
        if([string rangeOfString:@"Top" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            if([string rangeOfString:@"Crop" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                stritemtype=@"Ladies Crop Top";
            }
            if([string rangeOfString:@"Evening" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                stritemtype=@"Ladies Evening Top";
            }
        }
        if([string rangeOfString:@"Shirt" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            stritemtype=@"Ladies Formal Shirt";//temparr=arr17;
        }
    }
    else{
        stritemtype=@"";//temparr=arr11;
    }
    
    txtItem.text = stritemtype;
    viewBack.layer.cornerRadius = 4.0f;
    viewBack.clipsToBounds = YES;
    
    viewImg.layer.cornerRadius = 4.0f;
    viewImg.layer.borderWidth = 1.0f;
    viewImg.layer.borderColor = [UIColor grayColor].CGColor;
    
//    viewOther.layer.cornerRadius = 4.0f;
//    viewOther.layer.borderWidth = 1.0f;
//    viewOther.layer.borderColor = [UIColor grayColor].CGColor;
//    viewOther.clipsToBounds = YES;
    
    btnSelect.layer.cornerRadius = 12.0f;
    btnOK.layer.cornerRadius = 4.0f;
    
    if([arrSelected count]>  0){
        
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            
            NSString *imgUrl =[arrSelected objectAtIndex:0];
            
            txtTypeUrl.text = [NSString stringWithFormat:@"%@",imgUrl];
            
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:imgUrl]];
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                // WARNING: is the cell still using the same data by this point??
                imgVi.image = [UIImage imageWithData: data];
            });
            
        });
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark -
#pragma mark - TextField Return Keyboard Method

-(void)hideallKeyBoard
{
    if([txtTypeUrl isFirstResponder]){
        [txtTypeUrl resignFirstResponder];
    }if([txtItem isFirstResponder]){
        [txtItem resignFirstResponder];
    }if([txtCustomerName isFirstResponder]){
        [txtCustomerName resignFirstResponder];
    }if ([txtOther isFirstResponder]) {
        [txtOther resignFirstResponder];
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
        [scrollV setContentOffset:CGPointMake(0,0) animated:YES];
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
//    CGPoint point;
//    
//    if (textField == txtTypeUrl) {
//        point = CGPointMake(0, 50);
//    }else if (textField == txtItem){
//        point = CGPointMake(0, 120);
//    }else if (textField == txtCustomerName){
//        point = CGPointMake(0, 120);
//    }else if (textField == txtOther){
//        point = CGPointMake(0, 200);
//    }
//    [scrollV setContentOffset:point animated:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

#pragma mark -
#pragma mark - KEYBOARD NOTIFICATION

- (void)keyboardWillShow:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGRect keyboardFrameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrameEnd = [self.view convertRect:keyboardFrameEnd fromView:nil];
    
    CGPoint point;
    
    if ([txtItem isFirstResponder]) {
        point = CGPointMake(0, keyboardFrameEnd.size.height + 50);
    }else if ([txtCustomerName isFirstResponder]){
        point = CGPointMake(0, keyboardFrameEnd.size.height + 50);
    }else if ([txtOther isFirstResponder]){
        point = CGPointMake(0, keyboardFrameEnd.size.height + 50);
    }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
        self.view.frame = CGRectMake(0, self.view.frame.origin.y, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y);
    } completion:nil];
    
    [scrollV setContentOffset:point animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    
    
    CGRect keyboardFrameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrameEnd = [self.view convertRect:keyboardFrameEnd fromView:nil];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
        self.view.frame = CGRectMake(0, self.view.frame.origin.y, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y);
    } completion:nil];
    
    [scrollV setContentOffset:CGPointMake(0,0) animated:YES];
}


- (IBAction)onClickSelectBtn:(UIButton *)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSMutableArray arrayWithObjects:@"Me", @"Dad", @"Uncle", @"Brother", @"Sister", @"Mother", @"Aunt", @"Grandad", @"Grandma", @"Cousion Male",@"Cousion Female",@"Other",nil];
    if(dropDown == nil) {
        CGFloat f = 240;
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
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
//    NSString *strOther = [[NSUserDefaults standardUserDefaults]objectForKey:SELECTFAMILY];
    
    if ([btnSelect.titleLabel.text isEqualToString:@"Other"]) {
        viewOther.hidden = NO;
    }else{
        viewOther.hidden = YES;
        [userDefault setObject:btnSelect.titleLabel.text forKey:SELECTFAMILY];
    }
    NSLog(@"Hi %@", btnSelect.titleLabel.text);
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}
//- (IBAction)onClickOkBtn:(UIButton *)sender {
//    
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    
//    [userDefault setObject:txtOther.text forKey:SELECTFAMILY];
//
//    [btnSelect setTitle:txtOther.text forState:UIControlStateNormal];
//    viewOther.hidden = YES;
//}

-(BOOL)shareImageValidate
{
    if ([txtItem.text length] == 0) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:provideAlert
                                      message:@"Please Enter Image Type"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:provideOk
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    if ([txtCustomerName.text length] == 0) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:provideAlert
                                      message:@"Please Enter Customer Name"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:provideOk
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    if ([btnSelect.titleLabel.text isEqualToString:@"Select"]) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:provideAlert
                                      message:@"Please Select Family Person"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:provideOk
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    return YES;
}
- (IBAction)OnClickNextBtn:(UIButton *)sender {

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:txtTypeUrl.text forKey:URLTYPE];
    
    if ([self shareImageValidate]) {
        
        AttributView *viewAttribut = [[AttributView alloc] initWithNibName:@"AttributView" bundle:nil];
        
        
        [userDefault setObject:txtItem.text forKey:ITEMTYPE];
        
        if (![txtOther.text isEqualToString:@""]) {
            viewAttribut.strOther = txtOther.text;
        }
        
        viewAttribut.arrSelected = arrSelected;
        [self presentViewController:viewAttribut animated:YES completion:nil];
    }
}
- (IBAction)onClickBackBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView*)getTextFieldLeftAndRightView
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    return paddingView;
}

#pragma mark -
#pragma mark - TextField Padding Method

-(UIView*)getTextFieldRightAndLeftView
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    return paddingView;
}







@end
