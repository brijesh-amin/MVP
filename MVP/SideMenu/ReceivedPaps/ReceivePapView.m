//
//  ReceivePapView.m
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "ReceivePapView.h"
#import "PapReceiveView.h"
#import "PapChat.h"
#import "ReceivePapCell.h"
#import "StaticClass.h"
#import "ReceivePap.h"
#import "PapChatHomeView.h"
#import "AppDelegate.h"

@interface ReceivePapView ()

@end

@implementation ReceivePapView

//UITableView
@synthesize tblReceivePap;

//NSMutableArray
@synthesize arrReceivePap;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"Received Paps" fontSize:18];
    
    NSString *strDeviceID = [[NSUserDefaults standardUserDefaults]objectForKey:DEVICE_ID];
    NSString *strUserEmail = [[NSUserDefaults standardUserDefaults]objectForKey:USEREMAILID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:@"1" forKey:@"to"];
    [params setObject:strDeviceID forKey:@"device_id"];
    [params setObject:strUserEmail forKey:@"email"];
    
    [SHARED_APPDELEGATE showLoadingView];
    
    arrReceivePap = [[NSMutableArray alloc] init];
    
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
            objPapChat.attribute4 = [dict objectForKey:@"attribute4"];
            objPapChat.feedbackbit = [dict objectForKey:@"feedbackbit"];
            objPapChat.attribute_count = [dict objectForKey:@"attribute_count"];
            
            [arrReceivePap addObject:objPapChat];
            [tblReceivePap reloadData];
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
    return [arrReceivePap count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdenti = @"ChatImageCell";
    
    ReceivePapCell *cell = (ReceivePapCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdenti];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReceivePapCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    PapChat *objPap = [arrReceivePap objectAtIndex:indexPath.row];
    
    if ([arrReceivePap count] > indexPath.row) {
        [cell setReceivePapChatData:objPap];
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PapChat *objPap = [arrReceivePap objectAtIndex:indexPath.row];
    NSString *strFeedback = [NSString stringWithFormat:@"%@",objPap.feedbackbit];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
