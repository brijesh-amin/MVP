//
//  NewsFeedView.h
//  MVP
//
//  Created by Darshan on 15/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface NewsFeedView : MasterViewController <UITableViewDelegate , UITableViewDataSource>

{
    NSMutableArray *arrSites;
    NSUserDefaults *sharedUserDefaults;
}

//UITableView
@property (nonatomic , strong) IBOutlet UITableView *tblNewsFeed;

//NSMutableArry
@property (nonatomic , strong) NSMutableArray *arrNewsFeed;

@end
