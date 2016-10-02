//
//  SendPapView.m
//  MVP
//
//  Created by Darshan on 27/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "SendPapView.h"
#import "SendPapCell.h"
#import "PapChat.h"
#import "StaticClass.h"
#import "AppDelegate.h"
#import "sendList_MsgId.h"

@interface SendPapView ()

@end

@implementation SendPapView

@synthesize arrSendPapList;
@synthesize tblSendPap;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"Sent Paps" fontSize:18];
    
    NSString *strDeviceID = [[NSUserDefaults standardUserDefaults]objectForKey:DEVICE_ID];
    NSString *strUserEmail = [[NSUserDefaults standardUserDefaults]objectForKey:USEREMAILID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:@"1" forKey:@"from"];
    [params setObject:strDeviceID forKey:@"device_id"];
    [params setObject:strUserEmail forKey:@"email"];
    
    [SHARED_APPDELEGATE showLoadingView];
    
    arrSendPapList = [[NSMutableArray alloc] init];
    
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
            objPapChat.attribute_count = [dict objectForKey:@"attribute_count"];
            
            [arrSendPapList addObject:objPapChat];
            [tblSendPap reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"Error: %@", error);
        NSLog(@"operation %@ " , operation);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrSendPapList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdenti = @"ChatImageCell";
    
    SendPapCell *cell = (SendPapCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdenti];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SendPapCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    PapChat *objPap = [arrSendPapList objectAtIndex:indexPath.row];
    
    if ([arrSendPapList count] > indexPath.row) {
        [cell setPapChatData:objPap];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //PapChatHomeView *viewPapChat = [[PapChatHomeView alloc] initWithNibName:@"PapChatHomeView" bundle:nil];
    //viewPapChat.objPapChats = objPap;
    //[[self navigationController] pushViewController:viewPapChat animated:YES];
    //objPapChat.msg_id
    //viewPapChat.objPapChats = objPap;
    
    PapChat *objPap = [arrSendPapList objectAtIndex:indexPath.row];
    sendList_MsgId *viewPapChat = [[sendList_MsgId alloc] initWithNibName:@"sendList_MsgId" bundle:nil];
    viewPapChat.nextMsgId = objPap.msg_id;
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
