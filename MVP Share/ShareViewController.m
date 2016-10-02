//
//  ShareViewController.m
//  MVP Share
//
//  Created by Darshan on 23/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "ShareViewController.h"
#import <Social/Social.h>
#import "ShareCell.h"
#import "AppDelegate.h"
#import "SharePapView.h"

@import MobileCoreServices;

static NSString *const AppGroupId = @"group.MVP.share";
#define TypeUrl @"Type url.. Here"
#define PRODUCTTITLE @"productTitle"

@interface ShareViewController ()

@end

@implementation ShareViewController

//UIButton
@synthesize btnDone;
@synthesize btnCancel;

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}

-(void)viewDidLoad
{
    //[self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
    sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:AppGroupId];
    
    collectionV.backgroundColor = [UIColor clearColor];
    [collectionV registerNib:[UINib nibWithNibName:@"ShareCell" bundle:nil] forCellWithReuseIdentifier:@"ShareCell"];

    arrSelected = [[NSMutableArray alloc]init];
    
    [self showLoadingView];
    
    inputItem = self.extensionContext.inputItems.firstObject;
    NSItemProvider *urlItemProvider = [[inputItem.userInfo valueForKey:NSExtensionItemAttachmentsKey] objectAtIndex:0];
    if ([urlItemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *)kUTTypePropertyList])
    {
//        NSLog(@"ITEM %@", urlItemProvider);
        
        [urlItemProvider loadItemForTypeIdentifier:(__bridge NSString *)kUTTypePropertyList options:nil completionHandler:^(NSDictionary *data, NSError *error)
         {
//             NSLog(@"ITEM %@", data);
             
             arrImages =[[NSMutableArray alloc]init];
             
             NSDictionary *resultDict =data;
             
             NSDictionary *urlDictionary =resultDict[NSExtensionJavaScriptPreprocessingResultsKey];
             NSLog(@"urlDictionary>>>>>>>>> %@",urlDictionary);
             
             NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
             [userDefault setObject:[urlDictionary objectForKey:@"title"] forKey:PRODUCTTITLE];
             
             [userDefault synchronize];
             
             for(NSString *value in urlDictionary){
                 
                 //NSString *keys = value;
                 NSString *values = [urlDictionary objectForKey:value];
                 
                 if(values.length > 4){
                     if([[values substringToIndex:4]isEqualToString:@"http"]){
                         
                         [arrImages addObject:values];
                         
                     }else if([[values substringToIndex:2]isEqualToString:@"//"]){
                         
                         NSString *urlStr =[NSString stringWithFormat:@"http:%@",values];
                         [arrImages addObject:urlStr];
                     }
                         
                 }
             }
//             NSLog(@"IMAGE LIST %@" , arrImages);
             dispatch_async(dispatch_get_main_queue(), ^{
                 [collectionV reloadData];
                 [self hideLoadingView];
             });
         }];
    }
    
    btnDone.layer.cornerRadius = 4.0f;
    btnCancel.layer.cornerRadius = 4.0f;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];

}

- (void) receiveTestNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"TestNotification"]){
        NSLog (@"Successfully received the test notification!");
        [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
    }
}

#pragma mark - UICollectionView Datasource
#pragma mark -

-(NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
//    [arrImages removeObjectsInRange:NSMakeRange(0, arrImages.count-3)];

    return [arrImages count];
}

#pragma mark - UICollectionView Delegate

-(UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShareCell *cell1 =(ShareCell *)[cv dequeueReusableCellWithReuseIdentifier:@"ShareCell" forIndexPath:indexPath];
    if([arrImages count] > indexPath.row){
        
        NSString *strUrl =[arrImages objectAtIndex:indexPath.row];
        if([arrSelected containsObject:strUrl]){
            [cell1 setSelectedImage:[arrImages objectAtIndex:indexPath.row]];
            
        }else{
            [cell1 setImage:[arrImages objectAtIndex:indexPath.row]];
        }
    }
    cell1.delegate = self;
    cell1.cellIndex = (int) indexPath.row;
    return cell1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90,90);
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)imageSelectinAtIndex:(int)indedx isSelected:(BOOL)isSelection
{
    NSString *strUrl = [arrImages objectAtIndex:indedx];
    
    if([arrSelected containsObject:strUrl]){
        [arrSelected removeObject:strUrl];
        NSLog(@"UnSelect");
    }else{
        NSLog(@"Select");
        [arrSelected addObject:strUrl];
    }
}



- (void)didSelectPost {
    
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}


-(IBAction)onClickDismiss:(id)sender
{
    [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
}

-(IBAction)onClicDone:(id)sender
{
    SharePapView *shareView =[[SharePapView alloc]initWithNibName:@"SharePapView" bundle:nil];
    shareView.arrSelected = arrSelected;
    //[self.navigationController pushViewController:shareView animated:YES];
    [self presentViewController:shareView animated:YES completion:nil];
    
    
}

-(void)showLoadingView
{
    
    if (loadView == nil)
    {
        loadView = [[UIView alloc] initWithFrame:self.view.frame];
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
        [self.view addSubview:loadView];
}

-(void) hideLoadingView
{
    [loadView removeFromSuperview];
    loadView=nil;
}


- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return @[];
}

@end
