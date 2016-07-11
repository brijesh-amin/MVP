//
//  ContactCell.m
//  MVP
//
//  Created by Darshan on 03/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.contentView.layer.borderWidth = 1.0f;
//    self.contentView.layer.borderColor =[UIColor whiteColor].CGColor;
    
    CALayer *upperBorder = [CALayer layer];
    upperBorder.backgroundColor = [[UIColor whiteColor] CGColor];
    upperBorder.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 1.0f);
    [self.layer addSublayer:upperBorder];

}


-(void)setContacts:(NSMutableDictionary *)data
{   
    lblFname.text = [data objectForKey:@"firstName"];
    lblLname.text =[data objectForKey:@"lastName"];
    
    if ([data objectForKey:@"ProfileImage"] != nil) {
       imgProfile.image = [data objectForKey:@"ProfileImage"];
    }else{
        imgProfile.image = [UIImage imageNamed:@"ProfilePic"];
    }
}


-(void)setSelectedContact:(NSMutableDictionary *)data
{
    lblFname.text = [data objectForKey:@"firstName"];
    lblLname.text =[data objectForKey:@"lastName"];
    
    if ([data objectForKey:@"ProfileImage"] != nil) {
        imgProfile.image = [data objectForKey:@"ProfileImage"];
    }else{
        imgProfile.image = [UIImage imageNamed:@"ProfilePic"];
    }
    [btnSelected setSelected:YES];
}


-(void)setNormalContact:(NSMutableDictionary *)data
{
    lblFname.text = [data objectForKey:@"firstName"];
    lblLname.text =[data objectForKey:@"lastName"];
    
    if ([data objectForKey:@"ProfileImage"] != nil) {
        imgProfile.image = [data objectForKey:@"ProfileImage"];
    }else{
        imgProfile.image = [UIImage imageNamed:@"ProfilePic"];
    }
    [btnSelected setSelected:NO];
}


@end
