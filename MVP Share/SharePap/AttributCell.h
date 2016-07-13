//
//  AttributCell.h
//  MVP
//
//  Created by Darshan on 05/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol closeDelegate <NSObject>

-(void)closeBtnAtindex:(int)index;

-(void)setTableScrollWithIndex:(int)index;

-(void)resingKeyBoard;


@end

@interface AttributCell : UITableViewCell

//Delegate
@property (strong , nonatomic) id<closeDelegate> closeBtnDelegate;

//UITextField
@property (nonatomic , strong) IBOutlet UITextField *txtAttribut;

//Integer
@property (nonatomic)int index;
@end
