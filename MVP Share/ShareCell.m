//
//  ShareCell.m
//  ShareExtDemo
//
//  Created by Mitul on 23/05/16.
//  Copyright © 2016 com.abc. All rights reserved.
//

#import "ShareCell.h"

@implementation ShareCell

@synthesize delegate;
@synthesize cellIndex;
@synthesize imgRight;

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


-(void)setImage:(NSString *)imgUrl
{
    //[imgLoad loadImageFromStringforUserimg:imgUrl];
    //[imgLoad loadImageWithURl:imgUrl];
    
    imgLoad.layer.borderColor = [UIColor colorWithRed:238.0/255.0 green:224.0/255.0 blue:111.0/255.0 alpha:1.0].CGColor;
    imgLoad.layer.borderWidth = 1.0;
    
    imgLoad.alpha = 1.0f;
    
    [btnSelection setSelected:NO];
    imgRight.hidden = YES;

    dispatch_async(dispatch_get_main_queue(), ^{
        [imgLoad loadImageWithURl:[NSString stringWithFormat:@"%@", imgUrl] andPlaceholderName:nil];
    });
    
//    dispatch_async(dispatch_get_global_queue(0,0), ^{
//        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:imgUrl]];
//        if ( data == nil )
//            return;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // WARNING: is the cell still using the same data by this point??
//            imgLoad.image = [UIImage imageWithData: data];
//        });
//        
//    });
}

-(void)setSelectedImage:(NSString *)imgUrl
{
    
    imgLoad.layer.borderColor = [UIColor colorWithRed:238.0/255.0 green:224.0/255.0 blue:111.0/255.0 alpha:1.0].CGColor;
    imgLoad.layer.borderWidth = 1.0;
    imgLoad.alpha = 0.5f;
    
    [btnSelection setSelected:YES];
    imgRight.hidden = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [imgLoad loadImageWithURl:[NSString stringWithFormat:@"%@", imgUrl] andPlaceholderName:nil];
    });
    
//    dispatch_async(dispatch_get_global_queue(0,0), ^{
//        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:imgUrl]];
//        NSLog(@"ImageViewdata %@",data);
//        if ( data == nil )
//            return;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // WARNING: is the cell still using the same data by this point??
//            imgLoad.image = [UIImage imageWithData: data];
//            NSLog(@"ImageView %@",imgLoad.image);
//            
//        });
//    });
}

-(IBAction)onclickSelection:(id)sender
{
    if([btnSelection isSelected]){
        [btnSelection setSelected:NO];
        imgLoad.alpha = 1.0f;
        imgRight.hidden = YES;
        if(delegate && [delegate respondsToSelector:@selector(imageSelectinAtIndex:isSelected:)]){
            [delegate imageSelectinAtIndex:cellIndex isSelected:YES];
        }
        
    }else{
        [btnSelection setSelected:YES];
        imgLoad.alpha = 0.5f;
        imgRight.hidden = NO;
        if(delegate && [delegate respondsToSelector:@selector(imageSelectinAtIndex:isSelected:)]){
            [delegate imageSelectinAtIndex:cellIndex isSelected:NO];
        }

    }
    
}



@end
