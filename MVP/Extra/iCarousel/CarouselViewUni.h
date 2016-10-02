//
//  CorouselViewControllerViewController.h
//  BookListing
//
//  Created by logistic101 on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PapReceiveView.h"

#import "UIView+NibLoading.h"
@protocol SelectButtonDelegate

@optional
- (void)showoverview:(id)sender;
@end


@class Activitymenu;
//@class AsyncCorouselUni;
@class PapReceiveView;


@interface CarouselViewUni : UIView <UIScrollViewDelegate>
{
    IBOutlet UIScrollView *scrollView;

    PapReceiveView *controller;
	
	NSString *pageControlUsed;
	
	NSMutableArray *arrData;
    
    int height;
	int width;
    
    int currentPage;
    
    IBOutlet UILabel *lblTitle;
    
    NSMutableArray *viewControllers;
    
    //Activitymenu *objParent;
//    NSObject<SelectButtonDelegate> *delegate;
    
}

@property (nonatomic, retain) NSString *pageControlUsed;
@property (nonatomic, retain) NSMutableArray *arrData;
@property (nonatomic, retain) NSMutableArray *viewControllers;
 @property (nonatomic, assign) NSObject<SelectButtonDelegate> *delegate;

-(void)makingViewControllerArray ;

- (void)loadScrollViewWithPage:(int)page;



-(void) changePageManually;

-(void)setParent:(id)sender;

@end
