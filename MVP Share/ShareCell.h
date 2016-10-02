//
//  ShareCell.h
//  ShareExtDemo
//
//  Created by Mitul on 23/05/16.
//  Copyright © 2016 com.abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyImage.h"

@protocol ShareCellDelegate <NSObject>

-(void)imageSelectinAtIndex:(int)indedx isSelected:(BOOL)isSelection;


@end

@interface ShareCell : UICollectionViewCell
{
    IBOutlet AsyImage *imgLoad;
    IBOutlet UIButton *btnSelection;
    
    id<ShareCellDelegate> delegate;
}
@property (strong , nonatomic)id<ShareCellDelegate> delegate;

@property (nonatomic)int cellIndex;

@property (nonatomic , strong) IBOutlet UIImageView *imgRight;

-(void)setImage:(NSString *)imgUrl;

-(void)setSelectedImage:(NSString *)imgUrl;


@end
