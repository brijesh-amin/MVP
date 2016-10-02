//
//  AsyImage.h
//  Zobaze
//
//  Created by Mitul on 18/02/16.
//  Copyright © 2016 com.abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@protocol AsyImageDelegate <NSObject>

@optional
-(void) onAsyncTouch:(id)asyncImg;

@end

@interface AsyImage : UIImageView
{
    id<AsyImageDelegate> delegate;
}
@property (strong , nonatomic)id<AsyImageDelegate> delegate;
@property SEL onAsyncTouchSelector;
@property (strong , nonatomic)NSURL *imgUrl;


-(id)initWithCoder:(NSCoder *)aDecoder;
-(void)loadImageWithURl:(NSString *)url ;
-(void)loadImageWithURl:(NSString *)imageURL andPlaceholderName:(NSString *)strName ;
-(void)loadImageWithURl:(NSString *)url andPlaceHolderImage:(UIImage *)placeHolderImage ;

@end
