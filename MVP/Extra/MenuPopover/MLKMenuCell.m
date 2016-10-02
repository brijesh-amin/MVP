//
//  MLKMenuCell.m
//  ScratcherNeo
//
//  Created by My Mac on 4/13/16.
//  Copyright (c) 2016 Darshan Jolapara. All rights reserved.
//

#import "MLKMenuCell.h"

@implementation MLKMenuCell

//Label
@synthesize lblTitle;

//Button
@synthesize btnRedio;

//Integer
@synthesize index;

//Delegate
@synthesize effectDelegate;

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)onClickSelectEffectBtn:(UIButton *)sender {
    
    if (effectDelegate && [effectDelegate respondsToSelector:@selector(setSelectSoundEffect:)]) {
        [effectDelegate setSelectSoundEffect:index];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
