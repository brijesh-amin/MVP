//
//  ContactListCell.h
//  MVP
//
//  Created by Darshan on 03/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactData.h"

@interface ContactListCell : UITableViewCell
{
    IBOutlet UILabel *lblTitle;
    IBOutlet UIButton *btnSelect;
}

-(void)setNormalData:(NSMutableDictionary *)data;
-(void)setSelectedData:(NSMutableDictionary *)data;


@end
