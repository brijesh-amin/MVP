//
//  MyAccountView.h
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "MasterViewController.h"
#import "SelectedView.h"


@interface MyAccountView : MasterViewController<MJSelectPopDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    IBOutlet NSLayoutConstraint *constHeightFemale;
    IBOutlet NSLayoutConstraint *constHeightMale;
    
    BOOL profilePic;
}

//UIScrollView
@property (nonatomic , strong) IBOutlet UIScrollView *scrollV;

//UITextField
@property (nonatomic , strong) IBOutlet UITextField *txtName;
@property (nonatomic , strong) IBOutlet UITextField *txtCreatePass;
@property (nonatomic , strong) IBOutlet UITextField *txtConfirmPass;
@property (nonatomic , strong) IBOutlet UITextField *txtDay;
@property (nonatomic , strong) IBOutlet UITextField *txtMonth;
@property (nonatomic , strong) IBOutlet UITextField *txtyear;

@property (strong, nonatomic) IBOutlet UITextField *txtMobile;


//Button
@property (nonatomic , strong) IBOutlet UIButton *btnLocation;
@property (nonatomic , strong) IBOutlet UIButton *btnMale;
@property (nonatomic , strong) IBOutlet UIButton *btnFemale;
@property (nonatomic , strong) IBOutlet UIButton *btnUKTop;
@property (nonatomic , strong) IBOutlet UIButton *btnUKBottom;
@property (nonatomic , strong) IBOutlet UIButton *btnChangePic;
@property (nonatomic , strong) IBOutlet UIButton *btnSubmit;
@property (nonatomic , strong) IBOutlet UIButton *btnChestSize;
@property (nonatomic , strong) IBOutlet UIButton *btnWaistSize;
@property (nonatomic , strong) IBOutlet UIButton *btnColorSize;

//UIImageView
@property (nonatomic , strong) IBOutlet UIImageView *imgProfilePic;

//UIView
@property (nonatomic , strong) IBOutlet UIView *viewMale;
@property (nonatomic , strong) IBOutlet UIView *viewFemale;

//NSString
@property (nonatomic , strong) NSString *strUKTop;
@property (nonatomic , strong) NSString *strUKBottom;
@property (nonatomic , strong) NSString *strChestSize;
@property (nonatomic , strong) NSString *strWaistSize;
@property (nonatomic , strong) NSString *strColarSize;
@property (nonatomic , strong) NSString *strDeviceID;
@property (nonatomic , strong) NSString *strImgProfilePic;

//UIToolBar
@property (nonnull , strong) IBOutlet UIToolbar *toolDone;

@end
