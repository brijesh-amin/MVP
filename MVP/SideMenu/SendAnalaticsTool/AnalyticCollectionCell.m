//
//  AnalyticCollectionCell.m
//  MVP
//
//  Created by Darshan on 21/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "AnalyticCollectionCell.h"

@implementation AnalyticCollectionCell

@synthesize imgAsy;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    imgAsy.userInteractionEnabled = NO;
}

@end
