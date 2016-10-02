//
//  ReceivePap.h
//  MVP
//
//  Created by Darshan on 10/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PapReceiveView.h"

#import "CarbonKit.h"


@interface ReceivePap : UIViewController <CarbonTabSwipeNavigationDelegate>
{
    NSMutableArray *items;
    CarbonTabSwipeNavigation *carbonTabSwipeNavigation;
    
}

@property (strong, nonatomic)NSMutableArray *arrData;

//NSString
@property (nonatomic , strong) NSString *strImg;
@property (nonatomic , strong) NSString *strName;
@property (nonatomic , strong) PapChat *BeanPapChat;

@end
