//
//  LoginView.h
//  MVP
//
//  Created by Darshan on 14/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"

@interface LoginView : UIViewController

//UIScrollView
@property (nonatomic , strong) IBOutlet UIScrollView *scrollV;

//Button
@property (nonatomic , strong) IBOutlet UIButton *btnSignIn;
@property (nonatomic , strong) IBOutlet UIButton *btnFb;
@property (nonatomic , strong) IBOutlet UIButton *btnForgotPassword;
@property (nonatomic , strong) IBOutlet UIButton *btnRegister;
@property (nonatomic , strong) IBOutlet UIButton *btnTerms;

//UITextField
@property (nonatomic , strong) IBOutlet UITextField *txtUserName;
@property (nonatomic , strong) IBOutlet UITextField *txtPassword;

@end
