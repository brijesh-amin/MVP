//
//  NewsFeedCell.h
//  MVP
//
//  Created by Darshan on 15/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsCollectionCell.h"

@interface NewsFeedCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

//UILabel
@property (nonatomic , strong) IBOutlet UILabel *lblTitle;

@property (nonatomic , strong) IBOutlet UICollectionView *collectionViewC;

//NSMutableArray
@property (nonatomic , strong) NSMutableArray *arrListing;

-(void)setNewsFeedData:(NSMutableDictionary*)dictFeedList;
@end
