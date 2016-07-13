//
//  AppDelegate.m
//  MVP
//
//  Created by Darshan on 14/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsFeedView.h"
#import "StaticClass.h"
#import "CommonClass.h"
#import "MVPSideMenu.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize navigation;
@synthesize window;
@synthesize viewLogin;
@synthesize arrSavedAttributes;

@synthesize selectedIndex;

+(AppDelegate*)sharedAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setAppProperty];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"ISLOGIN"] isEqualToString:@"YES"]){
        [self createAccountOrLogin];
    }else{
        [self setMVPLogin];
    }
    
    // Create Dir for save Images
    NSString *filePath = [[self applicationCacheDirectory] stringByAppendingPathComponent:@"Images"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSLog(@"FilePath %@",filePath);
    
    if(![fileManager fileExistsAtPath:filePath]) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
    }

    // push notifications
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        NSLog(@"iOS 8 Requesting permission for push notifications..."); // iOS 8
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                                UIUserNotificationTypeAlert | UIUserNotificationTypeBadge |
                                                UIUserNotificationTypeSound categories:nil];
        [UIApplication.sharedApplication registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark -
#pragma mark - TextField Padding Method

-(UIView*)getTextFieldLeftAndRightView
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    return paddingView;
}

#pragma mark -
#pragma mark - TextField Padding Method

-(UIView*)getTextFieldRightAndLeftView
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    return paddingView;
}

#pragma mark -
#pragma mark - TextField Padding Method

-(UIView*)getTextFieldRightAndLeftViewDate
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    return paddingView;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "DC.MVP" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MVP" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MVP.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(void)setMVPLogin
{
    viewLogin = [[LoginView alloc] initWithNibName:@"LoginView" bundle:nil];
    navigation = [[UINavigationController alloc] initWithRootViewController:viewLogin];
    window.rootViewController = navigation;
    
    [window makeKeyWindow];
}
#pragma mark -
#pragma mark - Create Account Or Login Methods

-(void)createAccountOrLogin
{
    MVPSideMenu *leftMenuViewController = [[MVPSideMenu alloc] init];
    MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:[self navigationController]
                                                    leftMenuViewController:leftMenuViewController
                                                    rightMenuViewController:nil];
    self.window.rootViewController = container;
    [self.window makeKeyAndVisible];
}

- (NewsFeedView *)demoController {
    return [[NewsFeedView alloc] initWithNibName:@"NewsFeedView" bundle:nil];
}

- (UINavigationController *)navigationController {
    
    return [[UINavigationController alloc]
            initWithRootViewController:[self demoController]];
}

#pragma mark -
#pragma mark - LogOut Method

-(void)MVPLogOut
{
    [SHARED_APPDELEGATE MVPlogOut];
}

#pragma mark -
#pragma mark - NavigationTitle

-(UILabel *)getNavigationWithTitle:(NSString *)title fontSize:(int)size
{
    UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SHARED_APPDELEGATE.window.frame.size.width-120 , 35)];
    lblTitle.font = [UIFont fontWithName:@"ArialMT" size:size];
    lblTitle.text = title;
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor =[UIColor blackColor];
    //    lblTitle.font = [UIFont systemFontOfSize:size];
    return lblTitle;
}

#pragma mark -
#pragma mark - NavigationBarColor

-(void)setAppProperty
{
    [[UIBarButtonItem appearance] setTintColor:[UIColor blackColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance]setBackgroundImage:[self imageFromColor:appColor] forBarMetrics:UIBarMetricsDefault];
}

-(UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)MVPlogOut
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault removeObjectForKey:@"ISLOGIN"];
    [SHARED_APPDELEGATE setMVPLogin];
}

#pragma mark -
#pragma mark - Loading View

-(void)showLoadingView
{
    
    if (loadView == nil)
    {
        loadView = [[UIView alloc] initWithFrame:self.window.frame];
        loadView.opaque = NO;
        loadView.backgroundColor = [UIColor clearColor];
        //loadView.alpha = 0.7f;
        
        viewBack = [[UIView alloc] initWithFrame:CGRectMake(80, 230, 160, 50)];
        viewBack.backgroundColor = [UIColor blackColor];
        viewBack.alpha = 0.7f;
        viewBack.layer.masksToBounds = NO;
        viewBack.layer.cornerRadius = 5;
        
        lblLoading = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 110, 50)];
        lblLoading.backgroundColor = [UIColor clearColor];
        lblLoading.textAlignment = NSTextAlignmentCenter;
        lblLoading.text = @"Please Wait...";
        lblLoading.numberOfLines = 2;
        
        spinningWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(5.0, 10.0, 30.0, 30.0)];
        spinningWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        lblLoading.textColor = [UIColor whiteColor];
        [spinningWheel startAnimating];
        [viewBack addSubview:spinningWheel];
        
        //lblLoading.font = FONT_REGULAR(16);
        [viewBack addSubview:lblLoading];
        [loadView addSubview:viewBack];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            
            float y = (loadView.frame.size.height/2 ) - (viewBack.frame.size.height/2);
            float x =(loadView.frame.size.width/2 ) - (viewBack.frame.size.width/2);
            viewBack.frame = CGRectMake(x , y, 160, 50);;
        }
        else{
            
            float y = (loadView.frame.size.height/2 ) - (viewBack.frame.size.height/2);
            float x =(loadView.frame.size.width/2 ) - (viewBack.frame.size.width/2);
            viewBack.frame = CGRectMake(x , y, 160, 50);;
        }
    }
    if(loadView.superview == nil)
        [self.window addSubview:loadView];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    UIApplicationState state = [application applicationState];
    
    //    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *aps = (NSDictionary *)[userInfo objectForKey:@"aps"];
    NSString *strData = [NSString stringWithFormat:@"%@",[aps valueForKey:@"data"]];
    
    NSError *jsonError;
    NSData *objectData = [strData dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:objectData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&jsonError];
    
    if (state == UIApplicationStateActive)
    {
        NSLog(@"received a notification while active...");
        
        if (dictData)
        {
            //            [userDefault setObject:[CommonClass removeNull1:[dictData valueForKey:@"fromLat"]] forKey:fromLat];
            //            [userDefault setObject:[CommonClass removeNull1:[dictData valueForKey:@"fromLong"]] forKey:fromLong];
            //            [userDefault setObject:[CommonClass removeNull1:[dictData valueForKey:@"toLat"]] forKey:toLat];
            //            [userDefault setObject:[CommonClass removeNull1:[dictData valueForKey:@"toLong"]] forKey:toLong];
            //            [userDefault setObject:[CommonClass removeNull1:[dictData valueForKey:@"loadId"]] forKey:load_Id];
        }
        
    }
    else if (application.applicationState == UIApplicationStateInactive || application.applicationState == UIApplicationStateBackground)
    {
        //opened from a push notification when the app was on background
        NSLog(@"i received a notification...");
        NSLog(@"Message: %@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
        NSLog(@"whole data: %@",userInfo);
        
        NSDictionary *aps = [(NSDictionary *)[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
        NSString *strData = [NSString stringWithFormat:@"%@",[aps valueForKey:@"data"]];
        
        NSLog(@"aps>>>>> %@",aps);
        NSLog(@"strData>>>>> %@",strData);
        
        //        if (dictData)
        //        {
        ////            [userDefault setObject:[CommonClass removeNull1:[dictData valueForKey:@"fromLat"]] forKey:fromLat];
        ////            [userDefault setObject:[CommonClass removeNull1:[dictData valueForKey:@"fromLong"]] forKey:fromLong];
        ////            [userDefault setObject:[CommonClass removeNull1:[dictData valueForKey:@"toLat"]] forKey:toLat];
        ////            [userDefault setObject:[CommonClass removeNull1:[dictData valueForKey:@"toLong"]] forKey:toLong];
        ////            [userDefault setObject:[CommonClass removeNull1:[dictData valueForKey:@"loadId"]] forKey:load_Id];
        //        }
    }
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[CommonClass trimString:token] forKey:DEVICE_ID];
    
    //    [userDefault setObject:token forKey:device_Token];
    NSString *strDeviToken = [[NSUserDefaults standardUserDefaults]objectForKey:DEVICE_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"-->> strDeviToken:%@",strDeviToken);
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    NSLog(@"Registering device for push notifications..."); // iOS 8
    [application registerForRemoteNotifications];
}
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)notification completionHandler:(void(^)())completionHandler
{
    NSLog(@"Received push notification: %@, identifier: %@", notification, identifier); // iOS 8 s
    completionHandler();
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    // Respond to any push notification registration errors here.
    NSLog(@"Failed to get token, error: %@", error);
}

-(NSString *) removeNull:(NSString *) string
{
    if ([string isKindOfClass:[NSNull class]]){
        string = @"";
    }
    string = [self trimString:string];
    return string;
}

-(NSString*) trimString:(NSString *)theString
{
    NSString *theStringTrimmed = [theString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return theStringTrimmed;
}

-(NSString *)applicationCacheDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

-(void) hideLoadingView
{
    [loadView removeFromSuperview];
    loadView=nil;
}

@end
