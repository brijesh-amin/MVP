//
//  SharePapView.h
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface SharePapView : UIViewController <NIDropDownDelegate>

{
    NIDropDown *dropDown;
    IBOutlet UIImageView *imgVi;
}

@property (nonatomic , strong) IBOutlet UIView *viewOther;

//UIScrollView
@property (nonatomic , strong) IBOutlet UIScrollView *scrollV;

@property (nonatomic , strong) IBOutlet UITextField *txtOther;
@property (nonatomic , strong) IBOutlet UIButton *btnOK;

//NSMutableArray
@property (strong , nonatomic)NSMutableArray *arrSelected;



@property (nonatomic , strong) NSString *stritemtype;
//UITextField
@property (nonatomic , strong) IBOutlet UITextField *txtTypeUrl;
@property (nonatomic , strong) IBOutlet UITextField *txtItem;
@property (nonatomic , strong) IBOutlet UITextField *txtCustomerName;

//UIView
@property (nonatomic , strong) IBOutlet UIView *viewImg;
@property (nonatomic , strong) IBOutlet UIView *viewBack;

//UIButton
@property (nonatomic , strong) IBOutlet UIButton *btnSelect;

@end
