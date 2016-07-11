//
//  AttributView.h
//  MVP
//
//  Created by Darshan on 20/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttributImgView.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "ShareViewController.h"
#import "ContactListView.h"
#import "ContactCell.h"
#import "SelectPopUpView.h"
#import "AttributCell.h"

@interface AttributView : UIViewController <UICollectionViewDelegate , UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,MJSelectPopUpDelegate,closeDelegate,UIGestureRecognizerDelegate>

{
    UIView *loadView;

   
    UIView *viewBack;
    UILabel *lblLoading;
    UIActivityIndicatorView *spinningWheel;
    
    NSMutableData *receiveData;
    
    IBOutlet UICollectionView *collectionContact;
    NSMutableArray *arrContacts;
    
    NSString *strFirst;
    NSString *strSecond;
    NSString *strThird;
    
    NSMutableArray *arrSelected;
    
    NSInteger isFirstSelectedId;
}

//UITableView
@property (nonatomic , strong) IBOutlet UITableView *tblList;

//UILabel
@property (nonatomic , strong) IBOutlet UILabel *lblTitle;

//UIScrollView
@property (nonatomic , strong) IBOutlet UIScrollView *scrollV;

//UITableView
@property (nonatomic , strong) IBOutlet UITableView *tblListing;
@property (strong, nonatomic) IBOutlet UITableView *tbltypeattribute;

//UIImageView
@property (nonatomic , strong) IBOutlet AttributImgView *imgProduct;

//NSMutableArray
@property (nonatomic , strong) NSMutableArray *arrList;
@property (nonatomic , strong) NSMutableArray *arrAttributAdd;
@property (nonatomic , strong) NSMutableArray *arrAttribut;
@property (nonatomic , strong) NSMutableArray *arrAddatr;

@property (nonatomic , strong) NSMutableArray *arrMain;
@property (nonatomic , strong) NSMutableArray *arrDisplay;
@property (nonatomic , strong) NSMutableArray *arrSecTblData;

@property (nonatomic , strong) NSMutableArray *arr1;
@property (nonatomic , strong) NSMutableArray *arr2;
@property (nonatomic , strong) NSMutableArray *arr3;
@property (nonatomic , strong) NSMutableArray *arr4;
@property (nonatomic , strong) NSMutableArray *arr5;
@property (nonatomic , strong) NSMutableArray *arr6;
@property (nonatomic , strong) NSMutableArray *arr7;
@property (nonatomic , strong) NSMutableArray *arr8;
@property (nonatomic , strong) NSMutableArray *arr9;
@property (nonatomic , strong) NSMutableArray *arr10;
@property (nonatomic , strong) NSMutableArray *arr11;
@property (nonatomic , strong) NSMutableArray *arr12;
@property (nonatomic , strong) NSMutableArray *arr13;
@property (nonatomic , strong) NSMutableArray *arr14;
@property (nonatomic , strong) NSMutableArray *arr15;
@property (nonatomic , strong) NSMutableArray *arr16;
@property (nonatomic , strong) NSMutableArray *arr17;

@property (nonatomic , strong) NSMutableArray *temparr;


//UIView
@property (nonatomic , strong) IBOutlet UIView *viewImg;
@property (nonatomic , strong) IBOutlet UIView *viewLeft;
@property (nonatomic , strong) IBOutlet UIView *viewRight;
@property (nonatomic , strong) IBOutlet UIView *viewHeader;
@property (nonatomic , strong) IBOutlet UIView *viewListinTable;
@property (nonatomic , strong) IBOutlet UIView *viewTop;
@property (nonatomic , strong) IBOutlet UIView *viewFooter;
@property (nonatomic , strong) IBOutlet UIView *viewtap;
// IBOutlet UIView *viewtap;

//UIButton
@property (nonatomic , strong) IBOutlet UIButton *btnFirstGroup;
@property (nonatomic , strong) IBOutlet UIButton *btnSecondGroup;
@property (nonatomic , strong) IBOutlet UIButton *btnThirdGroup;
@property (nonatomic , strong) IBOutlet UIButton *btnSend;
@property (nonatomic , strong) IBOutlet UIButton *btnColor;
@property (nonatomic , strong) IBOutlet UIButton *btnSize;
@property (nonatomic , strong) IBOutlet UIButton *btnDesign;

@property (nonatomic , strong) NSString *strOther;

@property (nonatomic , strong) NSString *strq;

@property (nonatomic , strong) NSString *strqq;

//NSMutableArray
@property (strong , nonatomic)NSMutableArray *arrSelected;

@property (strong, nonatomic) IBOutlet UIButton *btnCancel;

-(void)handleMyTapGesture;
-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer;

@end
