//
//  MVPSideMenu.m
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "MVPSideMenu.h"
#import "StaticClass.h"
#import "NewsFeedView.h"
#import "MyAccountView.h"
#import "PapChatView.h"
#import "ReceivePapView.h"
#import "AnalyticToolView.h"
#import "SharePapView.h"
#import "MVPSideCell.h"
#import "MFSideMenu.h"
#import "SendPapView.h"
#import "AppDelegate.h"
#import "ShowFeedback.h"

@interface MVPSideMenu ()

@end

@implementation MVPSideMenu

//TableView
@synthesize tblSideMenu;

//UIView
@synthesize headerView;

//UILabel
@synthesize lblEmailID;

//NSMutableArray
@synthesize arrSideMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    arrSideMenu = [[NSMutableArray alloc] init];
    
    [arrSideMenu addObject:[self getDictfromTitle:@"News Feed" andImageIco:@"UserName"]];
    [arrSideMenu addObject:[self getDictfromTitle:@"My Profile" andImageIco:@"UserName"]];
    [arrSideMenu addObject:[self getDictfromTitle:@"Paps Chat" andImageIco:@"UserName"]];
    [arrSideMenu addObject:[self getDictfromTitle:@"Received Paps" andImageIco:@"UserName"]];
    [arrSideMenu addObject:[self getDictfromTitle:@"Sent Paps" andImageIco:@"UserName"]];
    [arrSideMenu addObject:[self getDictfromTitle:@"Analytics Tool" andImageIco:@"UserName"]];
    [arrSideMenu addObject:[self getDictfromTitle:@"LogOut" andImageIco:@"UserName"]];
    
    //[arrSideMenu addObject:[self getDictfromTitle:@"Analutic Feedback" andImageIco:@"UserName"]];
    
    tblSideMenu.tableFooterView  = [[UIView alloc]initWithFrame:CGRectZero];
    lblEmailID.text = [[NSUserDefaults standardUserDefaults]objectForKey:USEREMAILID];
    lblEmailID.textAlignment = NSTextAlignmentCenter;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return headerView.frame.size.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrSideMenu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdenti = @"ChatImageCell";
    
    MVPSideCell *cell = (MVPSideCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdenti];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MVPSideCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    if (SHARED_APPDELEGATE.selectedIndex == indexPath.row) {
        [cell selcectedCell:[arrSideMenu objectAtIndex:indexPath.row]];
    }else{
        [cell unSelectedCell:[arrSideMenu objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = appColor;
    
    SHARED_APPDELEGATE.selectedIndex = indexPath.row;
    
    if (indexPath.row == 0) {
        NewsFeedView *objNewsFeed = [[NewsFeedView alloc] initWithNibName:@"NewsFeedView" bundle:nil];
        NSArray *controllers = [NSArray arrayWithObject:objNewsFeed];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        navigationController.viewControllers = controllers;
    }else if (indexPath.row == 1){
        MyAccountView *objMyAccount = [[MyAccountView alloc] initWithNibName:@"MyAccountView" bundle:nil];;
        NSArray *controllers = [NSArray arrayWithObject:objMyAccount];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        navigationController.viewControllers = controllers;
    }else if (indexPath.row == 2){
        PapChatView *objPapChat = [[PapChatView alloc] initWithNibName:@"PapChatView" bundle:nil];
        NSArray *controllers = [NSArray arrayWithObject:objPapChat];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        navigationController.viewControllers = controllers;
    }
    else if (indexPath.row == 3){
        ReceivePapView *objReceivePap = [[ReceivePapView alloc] initWithNibName:@"ReceivePapView" bundle:nil];
        NSArray *controllers = [NSArray arrayWithObject:objReceivePap];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        navigationController.viewControllers = controllers;
    }
    else if (indexPath.row == 4){
        SendPapView *objSendPap = [[SendPapView alloc] initWithNibName:@"SendPapView" bundle:nil];
        NSArray *controllers = [NSArray arrayWithObject:objSendPap];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        navigationController.viewControllers = controllers;
    }
    else if (indexPath.row == 5){
        AnalyticToolView *objAnalytic = [[AnalyticToolView alloc] initWithNibName:@"AnalyticToolView" bundle:nil];
        NSArray *controllers = [NSArray arrayWithObject:objAnalytic];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        navigationController.viewControllers = controllers;
    }
    else if (indexPath.row == 6){
        [SHARED_APPDELEGATE MVPLogOut];
    }
    
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    [tblSideMenu reloadData];
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

#pragma mark -
#pragma mark - SideMenu Icon And Title Dict Method

-(NSMutableDictionary *)getDictfromTitle:(NSString *)title andImageIco:(NSString *)img
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:title forKey:@"title"];
    [dict setObject:img forKey:@"image"];
    return dict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
