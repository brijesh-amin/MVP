//
//  sendList_MsgId.m
//  MVP
//
//  Created by Happy on 7/14/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "sendList_MsgId.h"
#import "sendListWithMsgId.h"
#import "PapChat.h"
#import "PapChatHomeView.h"
#import "StaticClass.h"
#import "AppDelegate.h"

@interface sendList_MsgId ()

@end

@implementation sendList_MsgId
@synthesize arrSendPapList2;
@synthesize tblSendPap,nextMsgId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"Pap list" fontSize:18];
    self.navigationItem.backBarButtonItem.image = [UIImage imageNamed:@"back.png"];
    tblSendPap.dataSource = self;
    tblSendPap.delegate = self;
    
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
    
    NSString *strUserEmail = [[NSUserDefaults standardUserDefaults]objectForKey:USEREMAILID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    //[params setObject:@"1" forKey:@"from"];
    [params setObject:nextMsgId forKey:@"msg_id"];
    [params setObject:strUserEmail forKey:@"email"];
    
    [SHARED_APPDELEGATE showLoadingView];
    
    arrSendPapList2 = [[NSMutableArray alloc] init];
    //http://mahatmainfoware.com/iphoneAppServices/getpapbygroup.php
    //getPapGroup_Url
    
    [manager POST:@"http://mahatmainfoware.com/iphoneAppServices/getpapbygroup.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
            objPapChat.attribute_count = [dict objectForKey:@"attribute_count"];
            
            [arrSendPapList2 addObject:objPapChat];
            [tblSendPap reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"Error: %@", error);
        NSLog(@"operation %@ " , operation);
    }];
}

-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrSendPapList2 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdenti = @"ChatImageCell";
    
    sendListWithMsgId *cell = (sendListWithMsgId *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdenti];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"sendListWithMsgId" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    PapChat *objPap = [arrSendPapList2 objectAtIndex:indexPath.row];
    
    if ([arrSendPapList2 count] > indexPath.row) {
        [cell setPapChatData:objPap];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PapChat *objPap = [arrSendPapList2 objectAtIndex:indexPath.row];
    
    PapChatHomeView *viewPapChat = [[PapChatHomeView alloc] initWithNibName:@"PapChatHomeView" bundle:nil];
    viewPapChat.objPapChats = objPap;
    [[self navigationController] pushViewController:viewPapChat animated:YES];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
