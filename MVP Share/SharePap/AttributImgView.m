//
//  AttributImgView.m
//  MVP
//
//  Created by Darshan on 25/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "AttributImgView.h"

@implementation AttributImgView

-(void)loadImageFromUrl:(NSString *)strImgUrl
{

    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSString *imgUrl = strImgUrl;
        
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:imgUrl]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.image = [UIImage imageWithData: data];
        });
        
    });
    
}

@end
