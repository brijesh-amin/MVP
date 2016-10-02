//
//  PapChatHomeCell.h
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PapChat.h"
#import "AsyncImage.h"

@interface PapChatHomeLeftCell : UITableViewCell

//UILabel
@property (nonatomic , strong) IBOutlet UILabel *lblUserName;
@property (nonatomic , strong) IBOutlet UILabel *lblFeedbackMessage;
@property (nonatomic , strong) IBOutlet UILabel *lblUserCommentTime;

//AsyncImage
@property (nonatomic , strong) IBOutlet AsyncImage *imgAsync;

-(void)setPapChatHomeData:(PapChat*)objPap;

@end
