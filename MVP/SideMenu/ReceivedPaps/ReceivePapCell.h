//
//  ReceivePapCell.h
//  MVP
//
//  Created by Darshan on 27/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImage.h"
#import "PapChat.h"

@interface ReceivePapCell : UITableViewCell

//UIView
@property (nonatomic , strong) IBOutlet UIView *backView;

//UILabel
@property (nonatomic , strong) IBOutlet UILabel *lblUserName;
@property (nonatomic , strong) IBOutlet UILabel *lblUserComment;
@property (nonatomic , strong) IBOutlet UILabel *lblUserCommentTime;
@property (strong, nonatomic) IBOutlet UIImageView *ivChat;
@property (strong, nonatomic) IBOutlet UIImageView *ivTick;

//AsyncImage
@property (nonatomic , strong) IBOutlet AsyncImage *imgAsync;

-(void)setReceivePapChatData:(PapChat*)objPap;

@end
