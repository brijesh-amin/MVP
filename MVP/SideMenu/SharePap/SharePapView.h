//
//  SharePapView.h
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "MasterViewController.h"
#import "NIDropDown.h"

@interface SharePapView : MasterViewController<NIDropDownDelegate>

{
    NIDropDown *dropDown;
}

@property (strong , nonatomic)NSMutableArray *arrSelected;


//UITextField
@property (nonatomic , strong) IBOutlet UITextField *txtTypeUrl;

//UIView
@property (nonatomic , strong) IBOutlet UIView *viewImg;
@property (nonatomic , strong) IBOutlet UIView *viewBack;

//UIButton
@property (nonatomic , strong) IBOutlet UIButton *btnSelect;
@property (nonatomic , strong) IBOutlet UIButton *btnItem;
@property (nonatomic , strong) IBOutlet UIButton *btnCustomerName;

@end
