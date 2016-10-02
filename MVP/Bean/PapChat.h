//
//  PapChat.h
//  MVP
//
//  Created by Darshan on 27/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PapChat : NSObject


@property (nonatomic , strong) NSString *DtStamp;
@property (nonatomic , strong) NSString *papID;
@property (nonatomic , strong) NSString *img_url;
@property (nonatomic , strong) NSString *item_type;
@property (nonatomic , strong) NSString *msg_id;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *email_id;
@property (nonatomic , strong) NSString *feedback_message;
@property (nonatomic , strong) NSString *align;
@property (nonatomic , strong) NSString *attribute1;
@property (nonatomic , strong) NSString *attribute2;
@property (nonatomic , strong) NSString *attribute3;
@property (nonatomic , strong) NSString *attribute4;
@property (nonatomic , strong) NSString *attribute_count;
@property (nonatomic , strong) NSString *feedbackbit;

@property (nonatomic , strong) NSMutableArray *arrAnalitycGroup;

@end
