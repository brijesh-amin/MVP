//
//  AsyImage.m
//  Zobaze
//
//  Created by Mitul on 18/02/16.
//  Copyright © 2016 com.abc. All rights reserved.
//

#import "AsyImage.h"
#import "UIImageView+Letters.h"

@implementation AsyImage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize delegate;
@synthesize onAsyncTouchSelector;
@synthesize imgUrl;

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        
        self.clipsToBounds = YES;
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
        UITapGestureRecognizer *singleFingerDTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleFingerDTap];

    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self =[super initWithCoder:aDecoder])
    {
        self.clipsToBounds = YES;
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
        UITapGestureRecognizer *singleFingerDTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleFingerDTap];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void) handleSingleTap:(id)sender
{
    if([delegate respondsToSelector:onAsyncTouchSelector]){
        [delegate performSelector:onAsyncTouchSelector withObject:self];
    }
}


-(void)loadImageWithURl:(NSString *)url
{
        self.imgUrl  = [NSURL URLWithString:url];
    [self loadImageWithURl:url andPlaceHolderImage:nil];
}
-(void)loadImageWithURl:(NSString *)url andPlaceHolderImage:(UIImage *)placeHolderImage
{
    if(url == nil || [url isEqualToString:@""]){
        
      //  [self setImageWithString:@"tt" color:COLOR_DARK_YELLOW_CUST circular:NO textAttributes:@{NSFontAttributeName:FONT_FIRA_MEDIUM(20), NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
    }else{
        
        self.imgUrl  = [NSURL URLWithString:url];
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:url]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if (image) {
                                    self.image = image;
                                }
                            }];
    }
    

}
-(void)loadImageWithURl:(NSString *)imageURL andPlaceholderName:(NSString *)strName
{
    if(imageURL == nil || [imageURL isEqualToString:@""]){
        
        [self setImageWithString:strName color:[UIColor redColor] circular:NO textAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:[UIColor whiteColor]}];

    }else{
        self.imgUrl  = [NSURL URLWithString:imageURL];
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:imageURL]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if (image) {
                                    self.image = image;
                                }
                            }];
    }

    
}


@end
