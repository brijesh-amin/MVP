//
//  NewsCollectionCell.h
//  MVP
//
//  Created by Darshan on 21/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImage.h"

@interface NewsCollectionCell : UICollectionViewCell

//AsyncImage
@property (nonatomic , strong) IBOutlet AsyncImage *imgAsync;

-(void)setNewsFeedListing:(NSMutableArray *)arrFeedNewsList;

@end
