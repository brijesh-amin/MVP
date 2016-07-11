//
//  AnalyticToolCell.h
//  MVP
//
//  Created by Darshan on 18/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnalyticCollectionCell.h"
#import "PapChat.h"
#import "AsyncImage.h"

@protocol AnalyticToolCellDelegate <NSObject>

-(void)onClickCellIndex;

@end

@interface AnalyticToolCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    id<AnalyticToolCellDelegate> delegate;
}

@property (strong , nonatomic)id<AnalyticToolCellDelegate> delegate;

@property (nonatomic , strong) IBOutlet UICollectionView *collectionViewC;

//AsyncImage
@property (nonatomic , strong) IBOutlet AsyncImage *imgAsync;

@property (nonatomic ,strong) NSMutableArray *arrAnalytic;

-(void)setAnalyticToolData:(PapChat*)objPap;

@end
