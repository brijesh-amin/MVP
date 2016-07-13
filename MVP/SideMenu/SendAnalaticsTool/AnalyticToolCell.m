//
//  AnalyticToolCell.m
//  MVP
//
//  Created by Darshan on 18/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "AnalyticToolCell.h"

@implementation AnalyticToolCell

@synthesize collectionViewC;
@synthesize imgAsync;
@synthesize arrAnalytic;

@synthesize delegate;


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [collectionViewC registerNib:[UINib nibWithNibName:@"AnalyticCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionCell"];
    
    imgAsync.layer.cornerRadius = 30.f;
    imgAsync.clipsToBounds = YES;
    
}

#pragma mark -
#pragma mark - Collection view delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrAnalytic count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AnalyticCollectionCell *cell =(AnalyticCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    cell.imgAsy.layer.cornerRadius = 30.f;
    cell.clipsToBounds = YES;
    
    if ([arrAnalytic count] > indexPath.row) {
        
        NSMutableDictionary *dict = [arrAnalytic objectAtIndex:indexPath.row];
        
        [cell.imgAsy loadImageFromStringforUserimg:[dict objectForKey:@"profile_img"]];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"SELECT CELL");
    if(delegate && [delegate respondsToSelector:@selector(onClickCellIndex)]){
        [delegate onClickCellIndex];
    }
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

-(void)setAnalyticToolData:(PapChat*)objPap
{
    NSString *imageName;
    
    if (objPap.img_url == nil || [objPap.img_url isEqualToString:@""]) {
        imgAsync.image = [UIImage imageNamed:@"btnPlaceHolder.png"];
    }else{
        imageName = [NSString stringWithFormat:@"%@",objPap.img_url];
        [imgAsync loadImageFromStringforUserimg:imageName];
    }
    
    arrAnalytic = [[NSMutableArray alloc] initWithArray:objPap.arrAnalitycGroup];
    [collectionViewC reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
