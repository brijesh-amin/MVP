//
//  MyAccountView.m
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "MyAccountView.h"
#import "StaticClass.h"
#import "CommonClass.h"
#import "AppDelegate.h"

@interface MyAccountView ()

@end

@implementation MyAccountView

//UIScrollView
@synthesize scrollV;

//UITextField
@synthesize txtName;
@synthesize txtCreatePass;
@synthesize txtConfirmPass;
@synthesize txtDay;
@synthesize txtMonth;
@synthesize txtyear;
@synthesize txtMobile;


//Button
@synthesize btnLocation;
@synthesize btnMale;
@synthesize btnFemale;
@synthesize btnUKTop;
@synthesize btnUKBottom;
@synthesize btnChangePic;
@synthesize btnSubmit;
@synthesize btnChestSize;
@synthesize btnWaistSize;
@synthesize btnColorSize;

//UIImageView
@synthesize imgProfilePic;

//NSString
@synthesize strUKTop;
@synthesize strUKBottom;
@synthesize strChestSize;
@synthesize strWaistSize;
@synthesize strColarSize;
@synthesize strDeviceID;

//UIView
@synthesize viewMale;
@synthesize viewFemale;

//UIToolBar
@synthesize toolDone;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"MyAccount" fontSize:18];
    
    imgProfilePic.layer.cornerRadius = 65.0f;
    imgProfilePic.clipsToBounds = YES;
    
    profilePic = NO;
    
    NSString *strUserEmail = [[NSUserDefaults standardUserDefaults]objectForKey:USEREMAILID];
    strDeviceID = [[NSUserDefaults standardUserDefaults]objectForKey:DEVICE_ID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:strDeviceID forKey:@"device_id"];
    [params setObject:strUserEmail forKey:@"email"];
    
    [SHARED_APPDELEGATE showLoadingView];
    
    [manager POST:getProfile_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"ResponceLogin %@",responseObject);
        
        NSMutableArray *arrAccount = (NSMutableArray *) responseObject;
        
        NSMutableDictionary *dict = [arrAccount lastObject];
        
        NSArray *arr = [[dict objectForKey:@"Dob"] componentsSeparatedByString:@"-"];
        NSString *strDay = [arr objectAtIndex:0];
        NSString *strMonth = [arr objectAtIndex:1];
        NSString *strYear = [arr objectAtIndex:2];
        
        NSLog(@"%@",[dict objectForKey:@"Name"]);
        //NSLog(<#NSString * _Nonnull format, ...#>)
        //txtName.text = [dict objectForKey:@"User_name"];
        txtName.text = [dict objectForKey:@"Name"];
        txtDay.text = strDay;
        txtMonth.text = strMonth;
        txtyear.text = strYear;
        
        NSString *strGender = [dict objectForKey:@"Gender"];
        
        txtMobile.text = [dict objectForKey:@"mobile"];
        if ([strGender isEqualToString:@"Male"]) {
            [btnMale setSelected:YES];
            viewMale.hidden = NO;
            viewFemale.hidden = YES;
            constHeightMale.constant = 130.0f;
            constHeightFemale.constant = 0.0f;
            
            [btnFemale setEnabled:YES];
            [btnMale setEnabled:YES];
            
            [btnChestSize setTitle:[dict objectForKey:@"Chest"] forState:UIControlStateNormal];
            [btnWaistSize setTitle:[dict objectForKey:@"waist"] forState:UIControlStateNormal];
            [btnColorSize setTitle:[dict objectForKey:@"colar"] forState:UIControlStateNormal];
            
            strChestSize = [dict objectForKey:@"Chest"];
            strWaistSize = [dict objectForKey:@"waist"];
            strColarSize = [dict objectForKey:@"colar"];
            
           // scrollV.contentSize = CGSizeMake(scrollV.contentSize.width, scrollV.frame.origin.y,2000);
[scrollV setContentSize:CGSizeMake(scrollV.contentSize.width,1000)];
            
        }else{
            [btnFemale setSelected:YES];
            viewFemale.hidden = NO;
            viewMale.hidden = YES;
            constHeightFemale.constant = 82.0f;
            constHeightMale.constant = 0.0f;
            
            [btnFemale setEnabled:YES];
            [btnMale setEnabled:YES];
            
            [btnUKTop setTitle:[dict objectForKey:@"UkTop"] forState:UIControlStateNormal];
            [btnUKBottom setTitle:[dict objectForKey:@"Ukbottom"] forState:UIControlStateNormal];
            
            strUKTop = [dict objectForKey:@"UkTop"];
            strUKBottom = [dict objectForKey:@"Ukbottom"];
        }
        
        if ([[dict objectForKey:@"image_url"] isEqualToString:@""]) {
            imgProfilePic.image = [UIImage imageNamed:@"SimpleProfile"];
        }else{
            
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                
                _strImgProfilePic = [dict objectForKey:@"image_url"];
                
                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:_strImgProfilePic]];
                if ( data == nil )
                    return;
                dispatch_async(dispatch_get_main_queue(), ^{
                    // WARNING: is the cell still using the same data by this point??
                    imgProfilePic.image = [UIImage imageWithData: data];
                });
            });
        }
//        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"Error: %@", error);
        NSLog(@"operation %@ " , operation);
    }];
    
    txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Name attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtName.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtName.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtName.leftViewMode = UITextFieldViewModeAlways;
    txtName.rightViewMode = UITextFieldViewModeAlways;
    txtName.layer.cornerRadius = 15.0;
    
    txtCreatePass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:CreatePassword attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtCreatePass.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtCreatePass.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtCreatePass.leftViewMode = UITextFieldViewModeAlways;
    txtCreatePass.rightViewMode = UITextFieldViewModeAlways;
    txtCreatePass.layer.cornerRadius = 15.0;
    
    txtConfirmPass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:ConfirmPassword attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtConfirmPass.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtConfirmPass.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtConfirmPass.leftViewMode = UITextFieldViewModeAlways;
    txtConfirmPass.rightViewMode = UITextFieldViewModeAlways;
    txtConfirmPass.layer.cornerRadius = 15.0;
    
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
    txtyear.leftViewMode = UITextFieldViewModeAlways;
    txtyear.rightViewMode = UITextFieldViewModeAlways;
    txtyear.layer.cornerRadius = 15.0;
    
    txtMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    txtMobile.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtMobile.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftView];
    txtMobile.inputAccessoryView = toolDone;
    txtMobile.leftViewMode = UITextFieldViewModeAlways;
    txtMobile.rightViewMode = UITextFieldViewModeAlways;
    txtMobile.layer.cornerRadius = 15.0;

    
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
    btnChangePic.layer.cornerRadius = 20.f;
}

#pragma mark -
#pragma mark - ViewWillDisappear Method

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideallKeyBoard];
}
- (IBAction)onClickChangePicBtn:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Select Profile Picture:"
                                          message:@""
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhotoAction = [UIAlertAction
                                      actionWithTitle:@"Take Photo"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          [self TakePhotoIntoCamera];
                                          [alertController dismissViewControllerAnimated:YES completion:nil];
                                          
                                      }];
    
    UIAlertAction *galleryPhotoAction = [UIAlertAction
                                         actionWithTitle:@"Select Photo In Gallery"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             [self TakePhotoIntoGallary];
                                             [alertController dismissViewControllerAnimated:YES completion:nil];
                                             
                                         }];
    
    
    UIAlertAction *cancelAction  = [UIAlertAction
                                    actionWithTitle:provideCancel
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        [alertController dismissViewControllerAnimated:YES completion:nil];
                                        
                                    }];
    
    [alertController addAction:takePhotoAction];
    [alertController addAction:galleryPhotoAction];
    [alertController addAction:cancelAction];
    
    alertController.popoverPresentationController.sourceView = self.view;
    alertController.popoverPresentationController.sourceRect = CGRectMake((btnChangePic.frame.origin.x + btnChangePic.frame.size.width), (btnChangePic.frame.origin.y + btnChangePic.frame.size.height) + 35, 1.0, 1.0);
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)TakePhotoIntoCamera
{
    NSLog(@"TakePhotoIntoCamera");
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:provideAlert message:@"Device has no camera" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:provideOk style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
    }else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}
-(void)TakePhotoIntoGallary
{
    NSLog(@"TakePhotoIntoGallary");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    profilePic = YES;
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    imgProfilePic.image = chosenImage;
    
    NSString *path = [[AppDelegate sharedAppDelegate] applicationCacheDirectory];
    path = [path stringByAppendingPathComponent:@"profileImage.png"];
    
    NSData *imageData1 = UIImagePNGRepresentation(chosenImage);
    [imageData1 writeToFile:path atomically:YES];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    
    UIImage *compressImg = [self resizeImage:imgProfilePic.image];
    NSData *imageData = UIImageJPEGRepresentation(compressImg, 0.25);
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    
    NSString *newDateStr= [NSString stringWithFormat:@"%@.jpeg",dateString];
    
   //NSData *imageData = UIImageJPEGRepresentation(imgProfilePic.image,1.0);
    NSString *stremail = [[NSUserDefaults standardUserDefaults]objectForKey:USEREMAILID];
    [SHARED_APPDELEGATE showLoadingView];
    
    [params setObject:stremail forKey:@"email"];
    
    AFHTTPRequestOperation *op = [manager POST:profileImg_Url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:imageData name:@"image" fileName:newDateStr mimeType:@"image/jpeg"];
        //[formData appendPartWithFileData:imageData name:@"image" fileName:@"image" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
    }];
    [op start];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    profilePic = NO;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -
#pragma mark - TextField Return Keyboard Method

-(void)hideallKeyBoard
{
    if([txtName isFirstResponder]){
        [txtName resignFirstResponder];
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
    
    if (textField == txtName) {
        point = CGPointMake(0, 0);
    }else if(textField == txtCreatePass){
        point = CGPointMake(0, 80);
    }else if (textField == txtConfirmPass){
        point = CGPointMake(0, 135);
    }
//    /* make change here if require */
    else if (textField == txtMobile){
        point = CGPointMake(0, 150);
    }
    else if(textField == txtDay){
        point = CGPointMake(0, 180);
    }else if (textField == txtMonth){
        point = CGPointMake(0, 180);
    }else if(textField == txtyear){
        point = CGPointMake(0, 180);
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

-(BOOL)MyAccountUpDateValidate
{
    NSString *strUserName  = [CommonClass trimString:txtName.text];
    NSString *strPassword  = [CommonClass trimString:txtCreatePass.text];
    NSString *strConfirmPassword  = [CommonClass trimString:txtConfirmPass.text];
    NSString *strMonth  = [CommonClass trimString:txtMonth.text];
    NSString *strDay  = [CommonClass trimString:txtDay.text];
    NSString *strYear  = [CommonClass trimString:txtyear.text];
      //NSString *strmobile  = [CommonClass trimString:txtMobile.text];
    
    if ([strUserName length] == 0) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideEmaiID delegate:self];
        return NO;
    }
//    if ([strPassword length] == 0) {
//        [CommonClass showAlertWithTitle:provideAlert andMessage:provideCreatePassword delegate:self];
//        return NO;
////    }
//    if([strPassword length] < 6){
//        [CommonClass showAlertWithTitle:provideAlert andMessage:providePasswordStatus delegate:self];
//        return NO;
//    }
//    if ([strConfirmPassword length] == 0) {
//        [CommonClass showAlertWithTitle:provideAlert andMessage:provideConfirmPassword delegate:self];
//        return NO;
//    }
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
    if ([strDay length] < 2) {
        [CommonClass showAlertWithTitle:provideAlert andMessage:provideDayNumber delegate:self];
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
//        
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
        
//        if ([btnUKTop.titleLabel.text isEqualToString:@"Select"]) {
//            [CommonClass showAlertWithTitle:provideAlert andMessage:provideUKTopSize delegate:self];
//            return YES;
//        }
//        if ([btnUKBottom.titleLabel.text isEqualToString:@"Select"]){
//            [CommonClass showAlertWithTitle:provideAlert andMessage:provideUKBottomSize delegate:self];
//            return YES;
//        }
    }
    return YES;
}

- (IBAction)onClickSaveBtn:(UIButton *)sender {
    
    
    /*
     1) For male :-
     Link :-  http://mahatmainfoware.com/iphoneAppServices/updateprofile.php
     parameters :-  Name,device_id,password,location,bdate,gender,chest,waist,colar
     Response  :-   Status,email and message
     
     2) For Female :-
     Link :-  http://mahatmainfoware.com/iphoneAppServices/updateprofile.php
     parameters :-  Name,device_id,password,location,bdate,gender,top,bottom
     Response  :-   Status,email and message
     */

    if ([self MyAccountUpDateValidate]) {
        if (btnMale.isSelected == YES) {
            
            strUKTop = nil;
            strUKBottom = nil;
            
            NSString *strDate = [NSString stringWithFormat:@"%@-%@-%@",txtDay.text,txtMonth.text,txtyear.text];
            strDeviceID = [[NSUserDefaults standardUserDefaults]objectForKey:DEVICE_ID];
           NSString *stremail = [[NSUserDefaults standardUserDefaults]objectForKey:USEREMAILID];
            [SHARED_APPDELEGATE showLoadingView];
            
            UIImage *compressImg = [self resizeImage:imgProfilePic.image];
            NSData *imageData = UIImageJPEGRepresentation(compressImg, 0.25);
            
            NSDate *currDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [dateFormatter stringFromDate:currDate];
            
            NSString *newDateStr= [NSString stringWithFormat:@"%@.jpeg",dateString];
            
            NSLog(@"",imageData);
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            
            [params setObject:txtName.text forKey:@"Name"];
             [params setObject:stremail forKey:@"email"];
          //  [params setObject:strDeviceID forKey:@"device_id"];
            [params setObject:txtConfirmPass.text forKey:@"password"];
            [params setObject:txtMobile.text forKey:@"Mobile"];
            [params setObject:@"London" forKey:@"location"];
            //[params setObject:_strImgProfilePic forKey:@"image_url"];
            [params setObject:strDate forKey:@"bdate"];
            [params setObject:@"Male" forKey:@"gender"];
            [params setObject:strChestSize forKey:@"chest"];
            [params setObject:strWaistSize forKey:@"waist"];
            [params setObject:strColarSize forKey:@"colar"];
            // [params setObject:imageData forKey:@"image1"];
          
            
            
            [manager POST:updateProfile_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
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
        }else if (btnFemale.isSelected == YES){
            
                strChestSize = nil;
                strWaistSize = nil;
                strColarSize = nil;
            
                NSString *strDate = [NSString stringWithFormat:@"%@-%@-%@",txtDay.text,txtMonth.text,txtyear.text];
            /* for image upload*/
            
            UIImage *compressImg = [self resizeImage:imgProfilePic.image];
            NSData *imageData = UIImageJPEGRepresentation(compressImg, 0.25);

            NSDate *currDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [dateFormatter stringFromDate:currDate];
            
            NSString *newDateStr= [NSString stringWithFormat:@"%@.jpeg",dateString];
            
              NSString *stremail = [[NSUserDefaults standardUserDefaults]objectForKey:USEREMAILID];
            
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            
           // [params setObject:imageData withFileName:newDateStr andContentType:@"image/jpeg" forKey:@"image"];
            
                [params setObject:txtName.text forKey:@"Name"];
               [params setObject:stremail forKey:@"email"];
                [params setObject:strDeviceID forKey:@"device_id"];
                [params setObject:txtConfirmPass.text forKey:@"password"];
                [params setObject:@"Rajkot" forKey:@"location"];
                [params setObject:strDate forKey:@"bdate"];
                [params setObject:@"Female" forKey:@"gender"];
                [params setObject:strUKTop forKey:@"top"];
                [params setObject:strUKBottom forKey:@"bottom"];
               // [params setObject:imageData forKey:@"image"];
                [SHARED_APPDELEGATE showLoadingView];
                
                [manager POST:updateProfile_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
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
}
-(UIImage *)resizeImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 300.0;
    float maxWidth = 400.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.35;//35 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithData:imageData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
