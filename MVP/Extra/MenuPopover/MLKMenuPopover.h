//
//  MLKMenuPopover.h
//  MLKMenuPopover
//
//  Created by NagaMalleswar on 20/11/14.
//  Copyright (c) 2014 NagaMalleswar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLKMenuCell.h"

@class MLKMenuPopover;

@protocol MLKMenuPopoverDelegate

- (void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex;

@end

@interface MLKMenuPopover : UIView <UITableViewDataSource,UITableViewDelegate,soundEffectDelegate>

@property (nonatomic) BOOL selectSound;

@property(nonatomic,assign) id<MLKMenuPopoverDelegate> menuPopoverDelegate;

@property (nonatomic) BOOL isShowMenu;

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)menuItems;
- (void)showInView:(UIView *)view;
- (void)dismissMenuPopover;
- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
