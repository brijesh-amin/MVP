//
//  ReceivePap.m
//  MVP
//
//  Created by Darshan on 10/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "ReceivePap.h"
#import "AppDelegate.h"
#import "StaticClass.h"

@interface ReceivePap ()

@end

@implementation ReceivePap

@synthesize strImg;
@synthesize BeanPapChat;
@synthesize arrData;


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    items = @[@"One",
//              @"Two",
//              @"Three",
//              ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:NOTIFICATION_CENTER_SWIPE
                                               object:nil];

    
    

    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"Receive Pap" fontSize:18];
    
    UIImage *backButtonImage = [UIImage imageNamed:@"Back"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:backButtonImage
                forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    
    [backButton addTarget:self
                   action:@selector(popViewController)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    items = [[NSMutableArray alloc] init];
    
    NSInteger intV = [BeanPapChat.attribute_count integerValue];
    
    for(int i=0; i <= intV; i++){
        if(i== 0){
            [items addObject:BeanPapChat.attribute1];
        }else if(i==1){
            [items addObject:BeanPapChat.attribute2];
        }else if(i==2){
            [items addObject:BeanPapChat.attribute3];
        }
    }
    
    
    carbonTabSwipeNavigation = [[CarbonTabSwipeNavigation alloc] initWithItems:items delegate:self];
    [carbonTabSwipeNavigation insertIntoRootViewController:self];
    
    
    SHARED_APPDELEGATE.arrSavedAttributes =[[NSMutableArray alloc]init];
    
    [self style];
}
-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:NOTIFICATION_CENTER_SWIPE]){
        
        NSDictionary *userInfo = notification.userInfo;
        NSString *strTitle = [userInfo objectForKey:@"index"];
        int inttitle = [strTitle intValue];
        inttitle++;
        NSLog (@"Successfully received the test notification!");
        if([items count] > inttitle){
            [carbonTabSwipeNavigation setCurrentTabIndex:inttitle withAnimation:YES];
        }
    }
}

- (void)style {
    
    carbonTabSwipeNavigation.toolbar.translucent = NO;
    [carbonTabSwipeNavigation setTabExtraWidth:0];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:80 forSegmentAtIndex:0];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:80 forSegmentAtIndex:1];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:80 forSegmentAtIndex:2];
    

    [carbonTabSwipeNavigation setNormalColor:[UIColor clearColor]
                                        font:[UIFont boldSystemFontOfSize:14]];
    [carbonTabSwipeNavigation setSelectedColor:[UIColor clearColor] font:[UIFont boldSystemFontOfSize:14]];
    
}

#pragma mark - CarbonTabSwipeNavigation Delegate
// required
- (nonnull UIViewController *)carbonTabSwipeNavigation:
(nonnull CarbonTabSwipeNavigation *)carbontTabSwipeNavigation
                                 viewControllerAtIndex:(NSUInteger)index {
    
    PapReceiveView *papView =  [[PapReceiveView alloc]initWithNibName:@"PapReceiveView" bundle:nil];
    if([items count] > index){
        papView.attributeTitle =[items objectAtIndex:index];
    }
    if([items count]-1 == index){
        papView.isLastSlide = YES;
    }else{
        papView.isLastSlide = NO;
    }
    papView.slideIndex = (int)index;
    papView.strImg =strImg;
    
    return papView;
}

// optional
- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                 willMoveAtIndex:(NSUInteger)index {
    
    
}

- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                  didMoveAtIndex:(NSUInteger)index {
    NSLog(@"Did move at index: %ld", index);
    
}

- (UIBarPosition)barPositionForCarbonTabSwipeNavigation:
(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation {
    return UIBarPositionTop; // default UIBarPositionTop
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
