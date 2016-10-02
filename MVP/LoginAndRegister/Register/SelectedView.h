//
//  SelectedView.h
//  MVP
//
//  Created by Darshan on 14/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MJPopupViewController.h"

@protocol MJSelectPopDelegate <NSObject>

-(void)selectSizePopUp:(NSString *)strSize andReturnType:(NSString *)strType;

@end

@interface SelectedView : UIViewController


@property (assign, nonatomic) id <MJSelectPopDelegate> sizeDelegate;

//TabelView
@property (nonatomic , strong) IBOutlet UITableView *tblBusinessCategory;

//UILabel
@property (nonatomic , strong) IBOutlet UILabel *lblTitle;

//NSMutableArray
@property (nonatomic , strong) NSMutableArray *arrSelectSize;

//NSString
@property (nonatomic , strong) NSString *strSelect;

@end
