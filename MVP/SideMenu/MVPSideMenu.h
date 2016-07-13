//
//  MVPSideMenu.h
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVPSideMenu : UIViewController

//TableView
@property (nonatomic , strong) IBOutlet UITableView *tblSideMenu;

//UIView
@property (nonatomic , strong) IBOutlet UIView *headerView;

//UILabel
@property (nonatomic , strong) IBOutlet UILabel *lblEmailID;

//NSMutableArray
@property (nonatomic , strong) NSMutableArray *arrSideMenu;

@end
