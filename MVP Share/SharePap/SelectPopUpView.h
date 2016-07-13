//
//  SelectPopUpView.h
//  MVP
//
//  Created by Darshan on 05/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MJPopupViewController.h"

@protocol MJSelectPopUpDelegate <NSObject>

-(void)selectCategoryPopUp:(NSString *)strCategory andReturnType:(NSString *)strType;

@end

@interface SelectPopUpView : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (assign, nonatomic) id <MJSelectPopUpDelegate> categoryDelegate;

//UITableView
@property (nonatomic , strong) IBOutlet UITableView *tblList;

//UILabel
@property (nonatomic , strong) IBOutlet UILabel *lblTitle;

//NSMutableArray
@property (nonatomic , strong) NSMutableArray *arrList;

//NSString
@property (nonatomic , strong) NSString *strTitle;

@end
