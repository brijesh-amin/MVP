//
//  PapReceiveView.m
//  MVP
//
//  Created by Darshan on 18/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "PapReceiveView.h"
#import "SendFeedBackView.h"
#import "StaticClass.h"
#import "AppDelegate.h"

@interface PapReceiveView ()

@end

@implementation PapReceiveView

//AsyncImage
@synthesize asyImage;

//UIView
@synthesize viewPic;
@synthesize viewBack;

//UIButton
@synthesize btnDesign;

//NSString
@synthesize strImg;
@synthesize BeanPapChat;
@synthesize attributeTitle;
@synthesize isLastSlide;

@synthesize slideIndex;

AppDelegate *appDelegateP;

-(void)setObject:(PapChat *)obj
{
    objPap = obj;
}



- (void)viewDidLoad {
    [super viewDidLoad];
        
    asyImage.layer.cornerRadius = 40.0;
    asyImage.clipsToBounds = YES;
    
    viewBack.layer.cornerRadius = 5.0f;
    viewBack.clipsToBounds = YES;
    viewBack.layer.borderWidth = 1.0f;
    viewBack.layer.borderColor = viewCircleColor.CGColor;
    
    btnDesign.layer.cornerRadius = 15.0;
    
//    viewPicX = asyImage.frame.origin.x;
//    viewPicY = asyImage.frame.origin.y;
    
    strLikeDislike = @"0";
    //strsuitDontSuit = @"1";
    
    
    NSString *imageName;
    if (strImg == nil || [strImg isEqualToString:@""]) {
        asyImage.image = [UIImage imageNamed:@"btnPlaceHolder.png"];
    }else{
        imageName = [NSString stringWithFormat:@"%@",strImg];
        [asyImage loadImageFromStringforUserimg:imageName];
    }
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
    [asyImage addGestureRecognizer:panGestureRecognizer];
    defaultFrame = asyImage.frame;
    
    if(isLastSlide){
        btnDesign.userInteractionEnabled = YES;
    }else{
        btnDesign.userInteractionEnabled = NO;
    }
    [btnDesign setTitle:attributeTitle forState:UIControlStateNormal];
}

-(void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer{
    
    CGPoint touchLocation = [panGestureRecognizer locationInView:viewBack];
    
    asyImage.center = touchLocation;
    
    
    CGPoint velocity = [panGestureRecognizer velocityInView:asyImage];
    BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
    
    
    if (isVerticalGesture) {
        if (velocity.y > 0) {
            
            NSLog(@"DOWN");
            strLikeDislike = @"2";
            
        } else {
            
            NSLog(@"UP");
            strLikeDislike = @"3";
        }
        
    }else {
        if (velocity.x > 0) {
            
            NSLog(@"RIGHT");
            strLikeDislike = @"1";
        } else {
            
            NSLog(@"LEFT ");
            strLikeDislike = @"0";
        }
    }

    if(panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.5
                         animations:^{
                             
                             asyImage.frame = defaultFrame;
                         }
                         completion:^(BOOL finished){
                             if(isLastSlide){
                                 [self onClickDesignBtn:nil];
                             }else{
                                 [self postnotificationWithIndex];
                             }
                         }];
    }
}

-(void)postnotificationWithIndex
{
    NSDictionary* userInfo = @{@"index":[NSString stringWithFormat:@"%d", slideIndex]};
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:NOTIFICATION_CENTER_SWIPE object:self userInfo:userInfo];
}

-(void)viewWillDisappear:(BOOL)animated
{
    if(!isLastSlide){
        NSString *strResultString =[NSString stringWithFormat:@"%@", strLikeDislike];
        [SHARED_APPDELEGATE.arrSavedAttributes insertObject:strResultString atIndex:slideIndex];
    }
    //[SHARED_APPDELEGATE.arrSavedAttributes addObject:strResultString];
}


- (IBAction)onClickDesignBtn:(UIButton *)sender {
    
    NSString *strResultString =[NSString stringWithFormat:@"%@", strLikeDislike];
    [SHARED_APPDELEGATE.arrSavedAttributes insertObject:strResultString atIndex:slideIndex];
    
    SendFeedBackView *viewFeedBack = [[SendFeedBackView alloc] initWithNibName:@"SendFeedBackView" bundle:nil];
    [self.navigationController pushViewController:viewFeedBack animated:YES];
}

/*-(void)move:(UIPanGestureRecognizer*)sender {
    
    [self.view bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        firstX = [[sender view] center].x;
        firstY = [[sender view] center].y;
    }
    
    translatedPoint = CGPointMake(firstX+translatedPoint.x, firstY);
    
    [[sender view] setCenter:translatedPoint];
    
    
    
    CGPoint velocity = [sender velocityInView:asyImage];
    
    BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
    

    CGFloat velocityY = (0.2*[sender velocityInView:asyImage].y);
    CGFloat finalX1 = translatedPoint.x + velocityY;
    CGFloat finalY1 = translatedPoint.y + (.35*[(UIPanGestureRecognizer*)sender velocityInView:asyImage].y);

    if (isVerticalGesture) {
        if (velocity.y > 0) {
            //direction = UIPanGestureRecognizerDirectionDown;
            NSLog(@"DOWN");
            
        } else {
            //direction = UIPanGestureRecognizerDirectionUp;
            NSLog(@"UP");
        }
        
         CGPoint translation = [sender translationInView:self.view];;
        // [sender view].center = CGPointMake(asyImage.frame.origin.x + (asyImage.frame.size.height/2) , asyImage.frame.origin.y + translation.y);
        NSLog(@"TRANSLATION %f", translation.y);
        [sender view].frame =CGRectMake(asyImage.frame.origin.x, translation.y, asyImage.frame.size.width, asyImage.frame.size.height);
        
    }
    
    else {
        if (velocity.x > 0) {
            //direction = UIPanGestureRecognizerDirectionRight;
            NSLog(@"RIGHT");
        } else {
            //direction = UIPanGestureRecognizerDirectionLeft;
            NSLog(@"LEFT ");
        }
        
       // CGPoint translation = [sender translationInView:self.view];;
        // [sender view].center = CGPointMake(asyImage.frame.origin.x + (asyImage.frame.size.height/2) , asyImage.frame.origin.y + translation.y);
       // NSLog(@"TRANSLATION %f", translation.y);
       // [sender view].frame =CGRectMake(translation.x, asyImage.frame.origin.y, asyImage.frame.size.width, asyImage.frame.size.height);
        

    }
    


    
    /*
    else if(vel.y > 0){
        NSLog(@"TOP");
     
    }else{
        NSLog(@"BOTTOM");
    } * /
    

    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        CGFloat velocityX = (0.2*[(UIPanGestureRecognizer*)sender velocityInView:asyImage].x);
        
        
        CGFloat finalX = translatedPoint.x + velocityX;
        CGFloat finalY = translatedPoint.y + (.35*[(UIPanGestureRecognizer*)sender velocityInView:asyImage].y);
        
        
        
        /*
        if (UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
            if (finalX < 0) {
                //finalX = 0;
                NSLog(@"gesture moving left");
            } else if (finalX > 768) {
                //finalX = 768;
                NSLog(@"gesture moving right");
            }
            
            if (finalY < 0) {
                finalY = 0;
                NSLog(@"gesture moving left1");
            } else if (finalY > 1024) {
                finalY = 1024;
                NSLog(@"gesture moving right1");
            }
        } else {
            if (finalX < 0) {
                //finalX = 0;.
                NSLog(@"gesture moving left2");
            } else if (finalX > 1024) {
                //finalX = 768;
                NSLog(@"gesture moving right2");
            }
            
            if (finalY < 0) {
                finalY = 0;
                NSLog(@"gesture moving left3");
            } else if (finalY > 768) {
                finalY = 1024;
                NSLog(@"gesture moving right3");
            }
        } * /
        
//    CGPoint velocity2 = [sender velocityInView:asyImage];
        

        
        if(finalX1 > 0)
        {
            NSLog(@"gesture moving right");
        }
        else
        {
            NSLog(@"gesture moving left");
        }
        
        if(finalY1 > 0)
        {
            NSLog(@"gesture moving Up");
        }
        else
        {
            finalY1 = -500;
            NSLog(@"gesture moving Bottom");
        }
        
    }
}
-(void)animationDidFinish
{
    asyImage.frame = CGRectMake(viewPicX, viewPicY, asyImage.frame.size.width, asyImage.frame.size.height);
}


- (void)pan:(UIPanGestureRecognizer *)sender
{
    
    typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
        UIPanGestureRecognizerDirectionUndefined,
        UIPanGestureRecognizerDirectionUp,
        UIPanGestureRecognizerDirectionDown,
        UIPanGestureRecognizerDirectionLeft,
        UIPanGestureRecognizerDirectionRight
    };
    
    static UIPanGestureRecognizerDirection direction = UIPanGestureRecognizerDirectionUndefined;
    
    switch (sender.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            if (direction == UIPanGestureRecognizerDirectionUndefined) {
                
                CGPoint velocity = [sender velocityInView:asyImage];
                
                BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
                
                if (isVerticalGesture) {
                    if (velocity.y > 0) {
                        direction = UIPanGestureRecognizerDirectionDown;
                    } else {
                        direction = UIPanGestureRecognizerDirectionUp;
                    }
                }
                
                else {
                    if (velocity.x > 0) {
                        direction = UIPanGestureRecognizerDirectionRight;
                    } else {
                        direction = UIPanGestureRecognizerDirectionLeft;
                    }
                }
            }
            
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            switch (direction) {
                case UIPanGestureRecognizerDirectionUp: {
                    [self handleUpwardsGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionDown: {
                    [self handleDownwardsGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionLeft: {
                    [self handleLeftGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionRight: {
                    [self handleRightGesture:sender];
                    break;
                }
                default: {
                    break;
                }
            }
        }
            
        case UIGestureRecognizerStateEnded: {
            direction = UIPanGestureRecognizerDirectionUndefined;
            break;
        }
            
        default:
            break;
    }
    
}

- (void)handleUpwardsGesture:(UIPanGestureRecognizer *)sender
{
    NSLog(@"Up");
    
}

- (void)handleDownwardsGesture:(UIPanGestureRecognizer *)sender
{
    NSLog(@"Down");
}

- (void)handleLeftGesture:(UIPanGestureRecognizer *)sender
{
    NSLog(@"Left");
}

- (void)handleRightGesture:(UIPanGestureRecognizer *)sender
{
    NSLog(@"Right");
}


#pragma mark -
#pragma mark - Pop To View Mothod

-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


*/

@end
