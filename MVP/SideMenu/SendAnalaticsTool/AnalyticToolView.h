//
//  AnalyticToolView.h
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "MasterViewController.h"
#import "AnalyticToolCell.h"


@interface AnalyticToolView : MasterViewController <AnalyticToolCellDelegate>
{
    NSMutableArray *arrReceivePap;
    
}
//UITableView
@property (nonatomic , strong) IBOutlet UITableView *tblAnalytic;

//NSMutableArry
@property (nonatomic , strong) NSMutableArray *arrAnalytic;

@end
