//
//  SendPapCell.h
//  MVP
//
//  Created by Darshan on 27/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PapChat.h"
#import "AsyncImage.h"

@interface SendPapCell : UITableViewCell

//UIView
@property (nonatomic , strong) IBOutlet UIView *backView;

//UILabel
@property (nonatomic , strong) IBOutlet UILabel *lblUserName;
@property (nonatomic , strong) IBOutlet UILabel *lblUserComment;
@property (nonatomic , strong) IBOutlet UILabel *lblUserCommentTime;

//AsyncImage
@property (nonatomic , strong) IBOutlet AsyncImage *imgAsync;

-(void)setPapChatData:(PapChat*)objPap;

@end
