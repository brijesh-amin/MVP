//
//  AttributView.h
//  MVP
//
//  Created by Darshan on 20/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttributView : UIViewController

//UIView
@property (nonatomic , strong) IBOutlet UIView *viewImg;
@property (nonatomic , strong) IBOutlet UIView *viewLeft;
@property (nonatomic , strong) IBOutlet UIView *viewRight;

//UITextField
@property (nonatomic , strong) IBOutlet UITextField *txtAttribute;
@property (nonatomic , strong) IBOutlet UITextField *txtAttribute1;
@property (nonatomic , strong) IBOutlet UITextField *txtAttribute2;
@property (nonatomic , strong) IBOutlet UITextField *txtAttribute3;
@property (nonatomic , strong) IBOutlet UITextField *txtAttribute4;
@property (nonatomic , strong) IBOutlet UITextField *txtAttribute5;
@property (nonatomic , strong) IBOutlet UITextField *txtAttribute6;
@property (nonatomic , strong) IBOutlet UITextField *txtAttribute7;
@property (nonatomic , strong) IBOutlet UITextField *txtAttribute8;

//UIButton
@property (nonatomic , strong) IBOutlet UIButton *btnSend;

@end
