//
//  PapChatHomeCell.m
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "PapChatHomeLeftCell.h"
#import "StaticClass.h"

@implementation PapChatHomeLeftCell

@synthesize imgAsync;
@synthesize lblUserCommentTime;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    imgAsync.layer.cornerRadius = 30.0f;
    imgAsync.clipsToBounds = YES;

}

-(void)setPapChatHomeData:(PapChat*)objPap
{
    NSString *imageName;
    
    if (objPap.img_url == nil || [objPap.img_url isEqualToString:@""]) {
        imgAsync.image = [UIImage imageNamed:@"btnPlaceHolder.png"];
    }else{
        imageName = [NSString stringWithFormat:@"%@",objPap.img_url];
        [imgAsync loadImageFromStringforUserimg:imageName];
    }
    
    _lblFeedbackMessage.text = objPap.feedback_message;
    
    NSArray *components = [objPap.DtStamp componentsSeparatedByString:@" "];
    NSString *time = components[1];
    
    NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
    [dateF setDateFormat:@"HH:mm:ss"];
    NSDate *date = [dateF dateFromString:time];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    
    NSString *strTime = [dateFormat stringFromDate:date];
    
    NSArray *timeComponent = [strTime componentsSeparatedByString:@":"];
    NSString *hour = timeComponent[0];
    
    int value = [hour intValue];
    
    if (value > 12) {
        lblUserCommentTime.text = [NSString stringWithFormat:@"%@ PM",strTime];
    }else{
        lblUserCommentTime.text = [NSString stringWithFormat:@"%@ AM",strTime];
    }
    
//    NSString *strDeviceID = [[NSUserDefaults standardUserDefaults]objectForKey:NAME];
    _lblUserName.text = objPap.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
