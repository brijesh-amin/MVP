//
//  ShareViewController.h
//  MVP Share
//
//  Created by Darshan on 23/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "ShareCell.h"

@interface ShareViewController : UIViewController <UICollectionViewDelegate , UICollectionViewDataSource , ShareCellDelegate>
{
    NSUserDefaults *sharedUserDefaults;
    NSExtensionItem *inputItem;
    NSMutableArray *arrImages ;
    IBOutlet UICollectionView *collectionV;
    
    NSMutableArray *arrSelected;
    
    UIView *loadView;
    UIView *viewBack;
    UILabel *lblLoading;
    UIActivityIndicatorView *spinningWheel;

    IBOutlet UIImageView *imgVie;
}

-(void)showLoadingView;
-(void) hideLoadingView;

//UIButton
@property (nonatomic , strong) IBOutlet UIButton *btnDone;
@property (nonatomic , strong) IBOutlet UIButton *btnCancel;

@end
