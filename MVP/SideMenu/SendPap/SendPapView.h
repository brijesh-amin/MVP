//
//  SendPapView.h
//  MVP
//
//  Created by Darshan on 27/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface SendPapView : MasterViewController

//UITableView
@property (nonatomic , strong) IBOutlet UITableView *tblSendPap;

//NSMutableArray
@property (nonatomic , strong) NSMutableArray *arrSendPapList;

@end
