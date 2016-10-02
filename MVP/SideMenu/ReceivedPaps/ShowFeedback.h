//
//  ShowFeedback.h
//  MVP
//
//  Created by Bhavik Panchal on 7/29/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

@interface ShowFeedback : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    IBOutlet UIView *segView;
    IBOutlet UITableView *tvListData;
    IBOutlet UILabel *lblAttribute;
    IBOutlet UILabel *lblNoofYes;
    IBOutlet UILabel *lbNoOfNo;
    NSMutableArray *arradata;
}

@property (nonatomic,retain) NSString *strMessageId;



@end
