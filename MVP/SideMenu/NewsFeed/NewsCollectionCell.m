//
//  NewsCollectionCell.m
//  MVP
//
//  Created by Darshan on 21/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "NewsCollectionCell.h"

@implementation NewsCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imgAsync.layer.cornerRadius = 30.0f;
    self.imgAsync.clipsToBounds = YES;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"NewsCollectionCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
    }
    
    return self;
    
}

-(void)setNewsFeedListing:(NSMutableArray *)arrFeedNewsList
{ 

    
    for (NSMutableDictionary *dict in arrFeedNewsList) {
        
        NSString *imageName;
        
        imageName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"p_image"]];
          NSLog(@"imagename>>>>>>>>>> %@",imageName);
        
            [self.imgAsync loadImageFromStringforUserimg:imageName];
    
        
}
}
@end
