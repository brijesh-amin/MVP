//
//  NIDropUpCell.m
//  MVP
//
//  Created by Darshan on 20/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "NIDropUpCell.h"

@implementation NIDropUpCell

//UIImageview
@synthesize imgIcon;

//UILabel
@synthesize lblTitle;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
