//
//  MVPSideCell.h
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVPSideCell : UITableViewCell

//UILabel
@property (nonatomic , strong) IBOutlet UILabel *lblTitle;

//UIImageView
@property (nonatomic , strong) IBOutlet UIImageView *imgTitleIcon;

-(void)selcectedCell:(NSDictionary*)dict;
-(void)unSelectedCell:(NSDictionary*)dict;

@end
