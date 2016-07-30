//
//  sendList_MsgId.h
//  MVP
//
//  Created by Happy on 7/14/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MasterViewController.h"
#import "AsyncImage.h"

@interface sendList_MsgId : MasterViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) IBOutlet UITableView *tblSendPap;

//NSMutableArray
@property (nonatomic , strong) NSMutableArray *arrSendPapList2;
@property (nonatomic , strong) NSString *nextMsgId;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet AsyncImage *imgAsync;

@end
