//
//  SendFeedBackView.m
//  MVP
//
//  Created by Darshan on 18/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "SendFeedBackView.h"
#import "CommonClass.h"
#import "StaticClass.h"
#import "AppDelegate.h"

@interface SendFeedBackView ()

@end

@implementation SendFeedBackView

//UIView
@synthesize viewBack;
@synthesize viewCustomer;

//UIScrollView
@synthesize scrollV;

//TextView
@synthesize txvFeedback;

//Button
@synthesize btnSend;

//UILabel
@synthesize lblName;
@synthesize arrValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"FeedBack" fontSize:18];
    
    UIImage *backButtonImage = [UIImage imageNamed:@"Back"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:backButtonImage
                forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    
    [backButton addTarget:self
                   action:@selector(popViewController)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    NSString *strName = [[NSUserDefaults standardUserDefaults]objectForKey:SENDER_NAME];
    lblName.text = strName;
        NSLog(@"Name %@",strName);
    //TextView
    txvFeedback.layer.sublayerTransform = CATransform3DMakeTranslation(0, 0, 0);
    txvFeedback.autocorrectionType = UITextAutocorrectionTypeNo;
    [txvFeedback setText:provideFeedbackMsg];
    [txvFeedback setTextColor:[UIColor blackColor]];
    txvFeedback.layer.borderWidth= 1.0f;
    txvFeedback.layer.cornerRadius = 5.0;

    viewBack.layer.cornerRadius = 4.0f;
    viewBack.clipsToBounds = YES;
    
    viewCustomer.layer.cornerRadius = 17.5f;
    viewCustomer.layer.borderWidth = 4.0f;
    viewCustomer.layer.borderColor = [UIColor grayColor].CGColor;
    viewCustomer.clipsToBounds = YES;
    
    txvFeedback.layer.cornerRadius = 5.0f;

    btnSend.layer.cornerRadius = 15.0f;
    

    
}

#pragma mark -
#pragma mark - Pop To View Mothod

-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - TEXT VIEW DELEGATE

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    CGPoint point;
    if ([txvFeedback.text isEqualToString:provideFeedbackMsg]) {
        txvFeedback.text = @"";
    }
    point = CGPointMake(0,textView.frame.origin.y - 150);
    
    [scrollV setContentOffset:point animated:YES];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (txvFeedback.text.length == 0) {
        [txvFeedback setFont:[UIFont systemFontOfSize:12]];
        txvFeedback.text = provideFeedbackMsg;
    }
    [scrollV setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [scrollV setContentOffset:CGPointMake(0,0) animated:YES];
        return NO;
    }
    return YES;
}
- (IBAction)onClickSendBtn:(UIButton *)sender {
    
    NSString *strEmailID = [[NSUserDefaults standardUserDefaults]objectForKey:USEREMAILID];
    NSString *strMsgID = [[NSUserDefaults standardUserDefaults]objectForKey:MSG_ID];
   NSString *strPapID = [[NSUserDefaults standardUserDefaults]objectForKey:PAPID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        
    [params setObject:strEmailID forKey:@"email_id"];
    [params setObject:strMsgID forKey:@"msg_id"];
    
    SHARED_APPDELEGATE.arrSavedAttributes;
    
//    NSString *strLikes;
//    for(int i=0; i < [SHARED_APPDELEGATE.arrSavedAttributes count] ; i++){
//        
//        if(i==0 ){
//            strLikes =[NSString stringWithFormat:@"%@",[SHARED_APPDELEGATE.arrSavedAttributes objectAtIndex:i]];
//        }else{
//            strLikes =[NSString stringWithFormat:@",%@",[SHARED_APPDELEGATE.arrSavedAttributes objectAtIndex:i]];
//        }
//    }
    NSString *strLikes;
    NSString *temp;
    for(int i=0; i < [SHARED_APPDELEGATE.arrSavedAttributes count] ; i++){
        
        if(i==0 ){
            strLikes =[NSString stringWithFormat:@"%@",[SHARED_APPDELEGATE.arrSavedAttributes objectAtIndex:i]];
        }else{
            
            temp =[NSString stringWithFormat:@",%@",[SHARED_APPDELEGATE.arrSavedAttributes objectAtIndex:i]];
            strLikes=[strLikes stringByAppendingString:temp];
        }
    }

    
    
    [params setObject:strLikes forKey:@"att_feedback"];
    [params setObject:strPapID forKey:@"id"];
    [params setObject:@"0" forKey:@"checkbit"];
    [params setObject:txvFeedback.text forKey:@"feedback"];
    
    [SHARED_APPDELEGATE showLoadingView];
    
    [manager POST:feedbackPap_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"ResponceLogin %@",responseObject);
        
//        [CommonClass showAlertWithTitle:provideAlert andMessage:@"Success Fully Send FeedBack" delegate:self];
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:provideAlert
                                      message:@"Success Fully Send FeedBack"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:provideOk
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self setSendFeedback];
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"Error: %@", error);
        NSLog(@"operation %@ " , operation);
    }];

}
- (void)setSendFeedback
{
    [[AppDelegate sharedAppDelegate] createAccountOrLogin];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
