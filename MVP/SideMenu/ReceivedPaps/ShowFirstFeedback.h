//
//  ShowFeedback.h
//  MVP
//
//  Created by Bhavik Panchal on 7/29/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowFirstFeedback : UIViewController

{
    IBOutlet UILabel *lblAttribute;
    IBOutlet UILabel *lblNoofYes;
    IBOutlet UILabel *lbNoOfNo;
    NSMutableArray *arradata;
}
-(IBAction)buttontouch:(id)sender;
@property (nonatomic,retain) NSString *strMessageId;



@end
