//
//  AppDelegate.h
//  MVP
//
//  Created by Darshan on 14/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MFSideMenuContainerViewController.h"
#import "LoginView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

{
    UIView *loadView;
    UIView *viewBack;
    UILabel *lblLoading;
    UIActivityIndicatorView *spinningWheel;
    
    UIImageView *imgView;
    
    MFSideMenuContainerViewController *sideMenu;
    
}

@property (strong  , nonatomic) NSMutableArray *arrSavedAttributes;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic , strong) LoginView *viewLogin;
@property (nonatomic , strong) UINavigationController *navigation;

@property (nonatomic) NSInteger selectedIndex;

-(UILabel *)getNavigationWithTitle:(NSString *)title fontSize:(int)size;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(UIView*)getTextFieldRightAndLeftViewDate;
-(UIView*)getTextFieldRightAndLeftView;
-(UIView*)getTextFieldLeftAndRightView;
+(AppDelegate*)sharedAppDelegate;

-(NSString *)applicationCacheDirectory;

-(void)MVPLogOut;
-(void)createAccountOrLogin;
-(void)showLoadingView;
-(void) hideLoadingView;

@end

