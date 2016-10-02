//
//  ContactListCell.m
//  MVP
//
//  Created by Darshan on 03/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "ContactListCell.h"

@implementation ContactListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setNormalData:(NSMutableDictionary *)data
{
    lblTitle.text = [NSString stringWithFormat:@"%@ %@", [data objectForKey:@"firstName"] , [data objectForKey:@"lastName"]];
    [btnSelect setSelected:NO];
}

-(void)setSelectedData:(NSMutableDictionary *)data
{
    lblTitle.text = [NSString stringWithFormat:@"%@ %@", [data objectForKey:@"firstName"] , [data objectForKey:@"lastName"]];
    [btnSelect setSelected:YES];
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
