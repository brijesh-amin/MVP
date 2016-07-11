//
//  CorouselViewControllerViewController.m
//  BookListing
//
//  Created by logistic101 on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CarouselViewUni.h"

#import "AppDelegate.h"


@implementation CarouselViewUni

@synthesize pageControlUsed,delegate;

AppDelegate *appDelegate;

@synthesize viewControllers, arrData;

/*
-(void)setParent:(Activitymenu *)obj
{
    objParent = obj;
} */


-(id) initWithFrame:(CGRect)frame 
{
    if(self=[super initWithFrame:frame]) 
    {
        UIView *result = nil;
        NSArray* elements = [[NSBundle mainBundle] loadNibNamed:@"CarouselViewUni" owner:@"CarouselViewUni" options: nil];
        for (id anObject in elements)
        {
            if ([anObject isKindOfClass:[self class]])
            {
                result = anObject;
                break;
            }
        }
        self = (CarouselViewUni *)result;
        self.frame = frame;
        
        appDelegate = [AppDelegate sharedAppDelegate];
    }
    return self;
}

#pragma mark - Delegate
#pragma mark -

-(void)SelectButtonClicked:(id)sender{
    [delegate showoverview:self];
}
-(void)PreButtonClicked:(id)sender{
    currentPage--;
    [self changePageManually];
}
-(void)NextButtonClicked:(id)sender{
    currentPage++;
    [self changePageManually];
}

#pragma mark -
#pragma mark Methods for ScrollViewiPhone 

-(void)makingViewControllerArray  {

    NSLog(@"CarouselView >>>>> makingViewControllerArray >> %f",scrollView.frame.size.width);
    width = self.frame.size.width;
    height = self.frame.size.height - 32;
    
    if(self.viewControllers != nil)
    {
        int counter = 1;
        for(AsyncCorouselUni *objAsyn in self.viewControllers)
        {
            if ((NSNull *)objAsyn != [NSNull null]) {
//                [objAsyn removeFromSuperview];
                NSLog(@">>>>>>>> Object Removed at %d",counter);
            }
        }
    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [arrData count], scrollView.frame.size.height);
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [arrData count]; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
	[self loadScrollViewWithPage:currentPage];
}

-(void) changePageManually 
{
	CGRect frame = scrollView.frame;
	frame.origin.x = frame.size.width * currentPage;
	frame.origin.y = 0;
	[scrollView scrollRectToVisible:frame animated:NO];
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0) return;
    if (page >= [arrData count]) return;
    if (page != 0) {
		controller = [viewControllers objectAtIndex:page-1];

        Activitymenu *objCousel = (Activitymenu *)[arrData objectAtIndex:page - 1];
        if ((NSNull *)controller == [NSNull null]) {
            
 			controller = [[AsyncCorouselUni alloc] initWithFrame:CGRectMake(0,0,width,height)parent:self];
         	[viewControllers replaceObjectAtIndex:page-1 withObject:controller];
			[controller release];
		}
        [controller setObject:objCousel];
        controller.tag = page;

        [controller setBeanData];
		if (nil == controller.superview) {
			CGRect frame = scrollView.frame;
			frame.origin.x = frame.size.width * (page-1);
			frame.origin.y = 0;
			controller.frame = frame;
			[scrollView addSubview:controller];
		}
	}

	controller = [viewControllers objectAtIndex:page];

    if ((NSNull *)controller == [NSNull null]) {
    	controller = [[AsyncCorouselUni alloc] initWithFrame:CGRectMake(0,0,width,height)parent:self];
        controller.btnSelect.tag = 0;
        controller.btnSelect.titleLabel.text = 0;
        controller.delegate = self;
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        [controller release];
    }

    Activitymenu *objCousel = (Activitymenu *)[arrData objectAtIndex:page];
     NSString *path = [NSString stringWithFormat:@"%@/%@",API_IMG,objCousel.strIpath];
    [controller setObject:objCousel];
    [controller imageFromImagePath:path];
    controller.tag = page;
    [controller setBeanData];
	if (nil == controller.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
		controller.frame = frame;
        [scrollView addSubview:controller];
    }

    if (page == [arrData count]-1) {
        controller.btnNext.hidden = true;
    }
  else
  {
      controller.btnNext.hidden = false;
  }
    if (page == 0) {
        controller.btnPre.hidden = true;
    }
   else
   {
       controller.btnPre.hidden = false;
   }
/*
	if (page != [arrData count]-1)
 {
 controller = [viewControllers objectAtIndex:page+1];
 if ((NSNull *)controller == [NSNull null]) {
 controller = [[AsyncCorouselUni alloc] initWithFrame:CGRectMake(0,0,width,height)parent:self];
 controller.delegate = self;
 [viewControllers replaceObjectAtIndex:page+1 withObject:controller];
 [controller release];
 }
 
 Activitymenu *objCousel = (Activitymenu *)[arrData objectAtIndex:page + 1];
 [controller setObject:objCousel];
 
 if (nil == controller.superview) {
 CGRect frame = scrollView.frame;
 frame.origin.x = frame.size.width * (page+1);
 frame.origin.y = 0;
 controller.frame = frame;
 [scrollView addSubview:controller];
 }
	}
	*/
    [self unloadImages:page];
}

-(void) unloadImages:(int)page {
    
    for (int i = 0; i < [viewControllers count]; i++) {
		if (i != page && i != page+1 && i != page-1) {			
			
            controller = [viewControllers objectAtIndex:i];			
            
            if ((NSNull *)controller != [NSNull null]) {
//				[controller removeFromSuperview];
				controller = nil;
				[viewControllers replaceObjectAtIndex:i withObject:[NSNull null]];
			}
		}
    }
}

#pragma mark -
#pragma mark ScrollView delegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	
    if ([pageControlUsed isEqualToString:@"pageControlUsed"]) {
		//NSLog(@">>>>>>>>>>>>>>>>>>>>> page control used before");
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    
    int page;
    
    page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPage = page;
    pageControlUsed = @"notpageControlUsed";
    [self loadScrollViewWithPage:page];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	//NSLog(@"\nscrollViewDidEndDecelerating\n");
	pageControlUsed = @"notpageControlUsed";
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	//NSLog(@"\nScrollViewDidScroll\n");
	
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}



#pragma mark -
#pragma mark path for document directory 
-(NSString *)applicationDocumentsDirectory 
{	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
	return basePath;
}


@end
