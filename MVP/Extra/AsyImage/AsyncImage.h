//
//  AsyncImage.h
//  Amaxing
//
//  Created by NCrypted on 2/5/15.
//  Copyright (c) 2015 Ncrypted. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol AsyncImageDelegate<NSObject>

-(void) onAsyncTouch:(NSString *)asyncImg;
-(void) FetchImageSuccess:(id)asyncImg;
-(void) FetchImageFail:(id)asyncImg;

@end

@interface AsyncImage : UIImageView<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSURLConnection* connection;
    NSMutableData* data;
    UIActivityIndicatorView *scrollingWheel;
    NSString *imgName;
    NSString *imgName2;
    NSString *strFolderName;
    NSString *imagePath;
}

@property (nonatomic, strong) id<AsyncImageDelegate> delegate;
@property (nonatomic, strong) UIActivityIndicatorView *scrollingWheel;
@property (nonatomic, strong) NSString *indexPath;


@property SEL onAsyncTouchSelector;

//- (void)loadImageFromExistingImage:(NSString*)stringUrl Folder:(NSString *)FolderName;
-(void)loadImageFromStringforUserimg:(NSString*)url;
-(void)cancelConnection;

-(id)initWithCoder:(NSCoder *)aDecoder;
-(id)initWithFrame:(CGRect)frame;
-(void)addGestureRecognizer;


@end
