//
//  SendFeedBackView.h
//  MVP
//
//  Created by Darshan on 18/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendFeedBackView : UIViewController

//UIView
@property (nonatomic , strong) IBOutlet UIView *viewBack;
@property (nonatomic , strong) IBOutlet UIView *viewCustomer;

//UIScrollView
@property (nonatomic , strong) IBOutlet UIScrollView *scrollV;

//TextView
@property (nonatomic , strong) IBOutlet UITextView *txvFeedback;

//Button
@property (nonatomic , strong) IBOutlet UIButton *btnSend;

//UILabel
@property (nonatomic , strong) IBOutlet UILabel *lblName;

@property (nonatomic , strong) NSMutableArray *arrValue;

@end
