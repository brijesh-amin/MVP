//
//  PapChatView.m
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "PapChatView.h"
#import "ReceivePap.h"
#import "StaticClass.h"
#import "PapChatCell.h"
#import "PapChat.h"
#import "PapReceiveView.h"
#import "SendPapChat.h"
#import "PapChatHomeView.h"
#import "AppDelegate.h"

@interface PapChatView ()

@end

@implementation PapChatView

//UITableView
@synthesize tblPapChat;

//NSMutableArray
@synthesize arrPapChat;
@synthesize arrSelectPap;

//UIButton
@synthesize btnDrop;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"Pap Chat Home" fontSize:18];
    
    arrSelectPap = [[NSMutableArray alloc]init];
    
    UIBarButtonItem *barBtnFilter = [[UIBarButtonItem alloc] initWithCustomView:btnDrop];
    self.navigationItem.rightBarButtonItems = @[barBtnFilter];

    arrSelectPap = [[NSMutableArray alloc] initWithObjects:@"All Pap",@"Sent Pap",@"Received Pap", nil];
    
    [self setAllPapChat:0];
}

-(void)setAllPapChat:(int)indexpath
{
    NSString *strDeviceID = [[NSUserDefaults standardUserDefaults]objectForKey:DEVICE_ID];
    NSString *strUserEmail = [[NSUserDefaults standardUserDefaults]objectForKey:USEREMAILID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    if (indexpath == 0) {
        
    }else if (indexpath == 1){
        [params setObject:@"1" forKey:@"from"];
    }else if (indexpath == 2){
        [params setObject:@"1" forKey:@"to"];
    }
    
    [params setObject:strDeviceID forKey:@"device_id"];
    [params setObject:strUserEmail forKey:@"email"];
    
    [SHARED_APPDELEGATE showLoadingView];
    
    [arrPapChat removeAllObjects];
    arrPapChat = [[NSMutableArray alloc]init];
    
    [manager POST:getPap_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"ResponceLogin %@",responseObject);
        
        NSMutableArray *arrChatPap = [[NSMutableArray alloc] initWithArray:responseObject];
        
        for (NSMutableDictionary *dict in arrChatPap) {
            
            PapChat *objPapChat = [[PapChat alloc] init];
            
            objPapChat.DtStamp = [dict objectForKey:@"DtStamp"];
            objPapChat.papID = [dict objectForKey:@"id"];
            objPapChat.img_url = [dict objectForKey:@"img_url"];
            objPapChat.item_type = [dict objectForKey:@"item_type"];
            objPapChat.msg_id = [dict objectForKey:@"msg_id"];
            objPapChat.align = [dict objectForKey:@"align"];
            objPapChat.name = [dict objectForKey:@"name"];
            objPapChat.attribute1 = [dict objectForKey:@"attribute1"];
            objPapChat.attribute2 = [dict objectForKey:@"attribute2"];
            objPapChat.attribute3 = [dict objectForKey:@"attribute3"];
            objPapChat.attribute3 = [dict objectForKey:@"attribute4"];
            objPapChat.feedbackbit = [dict objectForKey:@"feedbackbit"];
            objPapChat.attribute_count = [dict objectForKey:@"attribute_count"];
            
            [arrPapChat addObject:objPapChat];
            [tblPapChat reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"Error: %@", error);
        NSLog(@"operation %@ " , operation);
    }];
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
    return [arrPapChat count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Search";
    
    PapChat *objPap = [arrPapChat objectAtIndex:indexPath.row];
    NSString *strAlign = [NSString stringWithFormat:@"%@", objPap.align];

    if ([strAlign isEqualToString:@"0"]) {
     
        PapChatCell *cell = (PapChatCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PapChatCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([arrPapChat count] > indexPath.row) {
            [cell setPapChatData:objPap];
        }
        return cell;
    }else{
        SendPapChat *cell = (SendPapChat *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SendPapChat" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([arrPapChat count] > indexPath.row) {
            
            [cell setPapChatData:objPap];
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PapChat *objPap = [arrPapChat objectAtIndex:indexPath.row];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *strFeedback = [NSString stringWithFormat:@"%@",objPap.feedbackbit];
    
    if ([strFeedback isEqualToString:@"0"]) {
        ReceivePap *viewSend = [[ReceivePap alloc] initWithNibName:@"ReceivePap" bundle:nil];
        [userDefault setObject:objPap.msg_id forKey:MSG_ID];
        [userDefault setObject:objPap.papID forKey:PAPID];
        viewSend.strImg = objPap.img_url;
        viewSend.BeanPapChat = objPap;
        [self.navigationController pushViewController:viewSend animated:YES];
    }else{
        PapChatHomeView *viewPapChat = [[PapChatHomeView alloc] initWithNibName:@"PapChatHomeView" bundle:nil];
        viewPapChat.objPapChats = objPap;
        [[self navigationController] pushViewController:viewPapChat animated:YES];
    }
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

- (IBAction)onClickPopUpViewBtn:(UIButton *)sender {
    
    self.menuPop.menuPopoverDelegate = self;
    
    if([self.menuPop isShowMenu]){
        [self.menuPop dismissMenuPopover];
    }else{
        self.menuPop = [[MLKMenuPopover alloc] initWithFrame:CGRectMake(SHARED_APPDELEGATE.window.frame.size.width - 180, 0, 180, 132) menuItems:arrSelectPap];
        
        self.menuPop.menuPopoverDelegate = self;
        [self.menuPop showInView:self.view];
    }
}

#pragma mark -
#pragma mark MLKMenuPopoverDelegate

- (void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex
{
    if (selectedIndex == 0) {
        [self setAllPapChat:0];
    }else if (selectedIndex == 1){
        [self setAllPapChat:1];
    }else if (selectedIndex == 2){
        [self setAllPapChat:2];
    }
    [self.menuPop dismissMenuPopover];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
