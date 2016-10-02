//
//  MVPSideCell.m
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "MVPSideCell.h"
#import "StaticClass.h"

@implementation MVPSideCell

//UILabel
@synthesize lblTitle;

//UIImageView
@synthesize imgTitleIcon;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)selcectedCell:(NSDictionary*)dict
{
    lblTitle.text = [dict objectForKey:@"title"];
    imgTitleIcon.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    self.contentView.backgroundColor = sideMenuSelectColor;
}
-(void)unSelectedCell:(NSDictionary*)dict
{
    lblTitle.text = [dict objectForKey:@"title"];
    imgTitleIcon.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
