//
//  RegisterView.h
//  MVP
//
//  Created by Darshan on 14/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedView.h"

@interface RegisterView : UIViewController<MJSelectPopDelegate>

{
    IBOutlet NSLayoutConstraint *constHeightFemale;
    IBOutlet NSLayoutConstraint *constHeightMale;

}
@property (strong, nonatomic) IBOutlet UILabel *lbltermcondions;

@property (strong, nonatomic) IBOutlet UIButton *btntest;


//UIScrollView
@property (nonatomic , strong) IBOutlet UIScrollView *scrollV;

//UITextField
@property (nonatomic , strong) IBOutlet UITextField *txtName;
@property (nonatomic , strong) IBOutlet UITextField *txtEmailID;
@property (nonatomic , strong) IBOutlet UITextField *txtCreatePassword;
@property (nonatomic , strong) IBOutlet UITextField *txtConfirmPassword;
@property (nonatomic , strong) IBOutlet UITextField *txtDay;
@property (nonatomic , strong) IBOutlet UITextField *txtMonth;
@property (nonatomic , strong) IBOutlet UITextField *txtyear;

@property (strong, nonatomic) IBOutlet UITextField *txtMobile;
@property (strong, nonatomic) IBOutlet UITextField *txtlastname;

@property (strong, nonatomic) IBOutlet UITextField *txtcountrycode;



//Button



@property (nonatomic , strong) IBOutlet UIButton *btnLocation;
@property (nonatomic , strong) IBOutlet UIButton *btnMale;
@property (nonatomic , strong) IBOutlet UIButton *btnFemale;
@property (nonatomic , strong) IBOutlet UIButton *btnUKTop;
@property (nonatomic , strong) IBOutlet UIButton *btnUKBottom;
@property (nonatomic , strong) IBOutlet UIButton *btnCheckMark;
@property (nonatomic , strong) IBOutlet UIButton *btnTerms;
@property (nonatomic , strong) IBOutlet UIButton *btnSubmit;
@property (nonatomic , strong) IBOutlet UIButton *btnCancel;
@property (nonatomic , strong) IBOutlet UIButton *btnChestSize;
@property (nonatomic , strong) IBOutlet UIButton *btnWaistSize;
@property (nonatomic , strong) IBOutlet UIButton *btnColorSize;

//UIView
@property (nonatomic , strong) IBOutlet UIView *viewMale;
@property (nonatomic , strong) IBOutlet UIView *viewFemale;

//NSString
@property (nonatomic , strong) NSString *strUKTop;
@property (nonatomic , strong) NSString *strUKBottom;
@property (nonatomic , strong) NSString *strChestSize;
@property (nonatomic , strong) NSString *strWaistSize;
@property (nonatomic , strong) NSString *strColarSize;

//UIToolBar
@property (nonnull , strong) IBOutlet UIToolbar *toolDone;


- (void) btnClick;
@end
