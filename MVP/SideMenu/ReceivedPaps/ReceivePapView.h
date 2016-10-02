//
//  ReceivePapView.h
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "MasterViewController.h"

@interface ReceivePapView : MasterViewController

//UITableView
@property (nonatomic , strong) IBOutlet UITableView *tblReceivePap;

//NSMutableArray
@property (nonatomic , strong) NSMutableArray *arrReceivePap;

@end
