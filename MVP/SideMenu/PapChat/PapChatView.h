//
//  PapChatView.h
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "MasterViewController.h"
#import "MLKMenuPopover.h"

@interface PapChatView : MasterViewController<MLKMenuPopoverDelegate>

{
    BOOL menuOpen;
}
//UITableView
@property (nonatomic , strong) IBOutlet UITableView *tblPapChat;

//NSMutableArray
@property (nonatomic , strong) NSMutableArray *arrPapChat;
@property (nonatomic , strong) NSMutableArray *arrSelectPap;

//UIButton
@property (nonatomic , strong) IBOutlet UIButton *btnDrop;

//MLKPopOver
@property(nonatomic , strong) MLKMenuPopover *menuPop;

@end
