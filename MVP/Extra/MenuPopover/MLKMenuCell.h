//
//  MLKMenuCell.h
//  ScratcherNeo
//
//  Created by My Mac on 4/13/16.
//  Copyright (c) 2016 Darshan Jolapara. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol soundEffectDelegate <NSObject>

-(void)setSelectSoundEffect:(int)index;

@end

@interface MLKMenuCell : UITableViewCell

//Delegate
@property (strong , nonatomic) id<soundEffectDelegate> effectDelegate;

//Label
@property (nonatomic , strong) IBOutlet UILabel *lblTitle;

//Button
@property (nonatomic , strong) IBOutlet UIButton *btnRedio;

//Integer
@property (nonatomic)int index;

@end
