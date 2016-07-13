//
//  PapChatHomeView.h
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImage.h"
#import "PapChat.h"

@interface PapChatHomeView : UIViewController

//UITableView
@property (nonatomic , strong) IBOutlet UITableView *tblChatList;

//NSMutableArray
@property (nonatomic , strong) NSMutableArray *arrChatList;

//UIView
@property (nonatomic , strong) IBOutlet AsyncImage *viewImg;
@property (nonatomic , strong) IBOutlet UIView *headerView;

//UITextField
@property (nonatomic , strong) IBOutlet UITextField *txtMsg;

//UIButton
@property (nonatomic , strong) IBOutlet UIButton *btnSend;

//UIView
@property (nonatomic , strong) IBOutlet UIView *viewFooter;

//NSString
@property (nonatomic , strong) NSString *strMsgID;

@property (nonatomic , strong) PapChat *objPapChats;

@end
