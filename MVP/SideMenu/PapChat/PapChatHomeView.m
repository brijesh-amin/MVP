//
//  PapChatHomeView.m
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "PapChatHomeView.h"
#import "PapChatHomeCell.h"
#import "PapChat.h"
#import "AppDelegate.h"
#import "StaticClass.h"

@interface PapChatHomeView ()

@end

@implementation PapChatHomeView

//UITableView
@synthesize tblChatList;

//UIView
@synthesize viewImg;
@synthesize headerView;

//NSMutableArray
@synthesize arrChatList;

//UIButton
@synthesize btnSend;

//UITextField
@synthesize txtMsg;

//UIView
@synthesize viewFooter;

@synthesize strMsgID;
@synthesize objPapChats;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"Paps Chat Home" fontSize:18];
    
    viewImg.layer.cornerRadius = 5.0f;
    viewImg.clipsToBounds = YES;
    viewImg.layer.borderWidth = 1.0f;
    viewImg.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
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
        
    txtMsg.attributedPlaceholder = [[NSAttributedString alloc] initWithString:SendPapChatMsg attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtMsg.leftView = [SHARED_APPDELEGATE getTextFieldRightAndLeftViewDate];
    txtMsg.rightView = [SHARED_APPDELEGATE getTextFieldRightAndLeftViewDate];
    txtMsg.leftViewMode = UITextFieldViewModeAlways;
    txtMsg.rightViewMode = UITextFieldViewModeAlways;
    txtMsg.layer.cornerRadius = 17.5f;
    
    btnSend.layer.cornerRadius = 4.0f;
    
    [self setHomePapChat];
}

-(void)setHomePapChat
{
    arrChatList = [[NSMutableArray alloc] init];
    
    NSString *strUserEmail = [[NSUserDefaults standardUserDefaults]objectForKey:USEREMAILID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:objPapChats.msg_id forKey:@"msg_id"];
    [params setObject:objPapChats.papID forKey:@"id"];
    [params setObject:strUserEmail forKey:@"email"];
    
    [SHARED_APPDELEGATE showLoadingView];
    
    [manager POST:getFeedbackPap_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"ResponceLogin %@",responseObject);
        
        NSArray *arr = [[NSMutableArray alloc]initWithArray:[responseObject objectForKey:@"feedback"]];
        
        for (NSMutableDictionary *dict in arr) {
            
            PapChat *objPapChat = [[PapChat alloc] init];
            
            objPapChat.DtStamp = [dict objectForKey:@"DtStamp"];
            objPapChat.papID = [dict objectForKey:@"id"];
            objPapChat.img_url = [dict objectForKey:@"image"];
            objPapChat.email_id = [dict objectForKey:@"email_id"];
            objPapChat.name = [dict objectForKey:@"name"];
            objPapChat.feedback_message = [dict objectForKey:@"feedback_message"];
            
            [arrChatList addObject:objPapChat];
        }
        NSString *strProductImg = [responseObject objectForKey:@"productimage"];
        NSLog(@"strProductImg %@",strProductImg);
        
        NSString *imageName;
        
        if (strProductImg == nil || [strProductImg isEqualToString:@""]) {
            viewImg.image = [UIImage imageNamed:@"btnPlaceHolder.png"];
        }else{
            imageName = [NSString stringWithFormat:@"%@",strProductImg];
            [viewImg loadImageFromStringforUserimg:imageName];
        }
        
        [tblChatList reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"Error: %@", error);
        NSLog(@"operation %@ " , operation);
    }];
}
#pragma mark -
#pragma mark - Pop To View Mothod

-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return headerView.frame.size.height;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrChatList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Search";
    
    PapChatHomeCell *cell = (PapChatHomeCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PapChatHomeCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([arrChatList count] > indexPath.row) {
        
        PapChat *objPap = [arrChatList objectAtIndex:indexPath.row];
        
        [cell setPapChatHomeData:objPap];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    CategoryType *objCategory = [arrDriverReport objectAtIndex:indexPath.row];
    
    //    ProfileView *objProfile;
    //    if (isIpad) {
    //        objProfile = [[ProfileView alloc] initWithNibName:@"ProfileViewIpad" bundle:nil];
    //    }else{
    //        objProfile = [[ProfileView alloc] initWithNibName:@"ProfileView" bundle:nil];
    //    }
    //    //    objProfile.beanCategory = objCategory;
    //    [[self navigationController] pushViewController:objProfile animated:YES];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark -
#pragma mark - TEXT FILED DELEGATE

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
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
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
        self.view.frame = CGRectMake(0, self.view.frame.origin.y, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y);
    } completion:nil];
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
}
- (IBAction)onClickSendBtn:(UIButton *)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:objPapChats.msg_id forKey:@"msg_id"];
    [params setObject:objPapChats.papID forKey:@"id"];
    [params setObject:txtMsg.text forKey:@"feedback"];
    
    [SHARED_APPDELEGATE showLoadingView];
    
    [manager POST:feedbackPap_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"ResponceLogin %@",responseObject);
        
        [self setHomePapChat];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"Error: %@", error);
        NSLog(@"operation %@ " , operation);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
