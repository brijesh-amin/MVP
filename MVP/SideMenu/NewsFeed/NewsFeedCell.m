//
//  NewsFeedCell.m
//  MVP
//
//  Created by Darshan on 15/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "NewsFeedCell.h"


@implementation NewsFeedCell

//UILabel
@synthesize lblTitle;

@synthesize collectionViewC;

@synthesize arrListing;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    [collectionViewC registerNib:[UINib nibWithNibName:@"NewsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionCell"];
}

-(void)setNewsFeedData:(NSMutableDictionary*)dictFeedList
{
    NSLog(@"dictFeedList>>>>>>>>>> %@",dictFeedList);
    
    for(NSString *key in [dictFeedList allKeys]){
        
        arrListing =[[NSMutableArray alloc]init];
        lblTitle.text = key;
        [arrListing addObjectsFromArray:[dictFeedList objectForKey:key]];
        
          NSLog(@"arrlisting>>>>>>>>>> %@",arrListing);
        [collectionViewC reloadData];
        
    }
}
#pragma mark -
#pragma mark - Collection view delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrListing count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    
     NewsCollectionCell *cell =(NewsCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
       [cell setNewsFeedListing:arrListing[indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"SELECT CELL");
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}

//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 2;
//}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets;
    insets=UIEdgeInsetsMake(0, 0, 0, 0);
    
    return insets;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
