//
//  PapReceiveView.h
//  MVP
//
//  Created by Darshan on 18/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImage.h"
//#import "CarouselViewUni.h"
#import "AppDelegate.h"
#import "PapChat.h"

@protocol CorouselUniDelegate

@optional
- (void)LikeButtonClicked:(id)sender;
-(void)DisLikeButtonClicked:(id)sender;
-(void)SuitsButtonClicked:(id)sender;
-(void)DoNotSuitsButtonClicked:(id)sender;
-(void)submiteButtonClicked:(id)sender;

@end

@class CarouselViewUni;
@class Activitymenu;

@interface PapReceiveView : UIViewController

{
    float firstX;
    float firstY;
    
    float viewPicX;
    float viewPicY;
    
    PapChat *objPap;
    
    IBOutlet UIButton *btnLike,*btnDisLike,*btnSuits,*btnDoNotSuits;
    NSObject<CorouselUniDelegate> *delegate;
    
    CGRect defaultFrame;
    
    NSString *strLikeDislike;
    //NSString *strsuitDontSuit;
    
}

@property (nonatomic, assign) NSObject<CorouselUniDelegate> *delegate;


//AsyncImage
@property (nonatomic , strong) IBOutlet AsyncImage *asyImage;

//UIView
@property (nonatomic , strong) IBOutlet UIView *viewPic;
@property (nonatomic , strong) IBOutlet UIView *viewBack;

//UIButton
@property (nonatomic , strong) IBOutlet UIButton *btnDesign;

//NSString
@property (nonatomic , strong) NSString *strImg;
@property (strong , nonatomic) NSString *attributeTitle;
@property (nonatomic) BOOL isLastSlide;
@property (nonatomic) int slideIndex;

@property (nonatomic , strong) PapChat *BeanPapChat;

@end
