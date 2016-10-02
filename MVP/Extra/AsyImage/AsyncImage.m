//
//  AsyncImage.m
//  Amaxing
//
//  Created by NCrypted on 2/5/15.
//  Copyright (c) 2015 Ncrypted. All rights reserved.
//

#import "AsyncImage.h"
#import <QuartzCore/QuartzCore.h>

@implementation AsyncImage

@synthesize scrollingWheel,delegate;
@synthesize onAsyncTouchSelector;
@synthesize indexPath;

AppDelegate *appDelegateAsy;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self =[super initWithCoder:aDecoder])
    {
        [self initialization];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    if(self =[super initWithFrame:frame])
    {
        [self initialization];
    }
    return self;
}
-(void)initialization
{
    scrollingWheel = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    float x = self.bounds.size.width/2;
    float y = self.bounds.size.height/2;
    scrollingWheel.center = CGPointMake(x, y);
    scrollingWheel.hidesWhenStopped = YES;
    [self addSubview:scrollingWheel];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 0;
    
    [self setUserInteractionEnabled:YES];
    [self setMultipleTouchEnabled:YES];
    
    UITapGestureRecognizer *singleFingerDTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleFingerDTap];
}
-(void) handleSingleTap:(id)sender
{
    [delegate onAsyncTouch:indexPath];
}
- (void)loadImageFromStringforUserimg:(NSString*)stringUrl
{    
    [self cancelConnection];
    [scrollingWheel startAnimating];
    imgName = [[stringUrl componentsSeparatedByString:@"/"] lastObject];
    
//    NSRange whiteSpaceRange = [imgName rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
//    if (whiteSpaceRange.location != NSNotFound) {
//
//        stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@" " withString: @"%20"];
//        indexPath = stringUrl;
//        [indexPath retain];
//        strFolderName = @"Images";
//        imagePath = [[[AppDelegate sharedAppDelegate] applicationCacheDirectory] stringByAppendingPathComponent:strFolderName];
//        NSLog(@"imagePath: %@",imagePath);
//        imagePath = [imagePath stringByAppendingPathComponent:imgName];
//        
//    }else{
//       
//    }
    
    indexPath = stringUrl;

    strFolderName = @"Images";
    imagePath = [[[AppDelegate sharedAppDelegate] applicationCacheDirectory] stringByAppendingPathComponent:strFolderName];
    
    imagePath = [imagePath stringByAppendingPathComponent:imgName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //NSLog(@"File Path :%@", imagePath);
    
    if ([fileManager fileExistsAtPath:imagePath]==YES)
    {
        self.image = nil;
        UIImage *img = [[UIImage alloc]initWithContentsOfFile:imagePath];
        
        /*
         CGImageRef cgref = [img CGImage];
         CIImage *cim = [img CIImage];
         if (cim == nil && cgref == NULL){
         NSError *error = nil;
         [[NSFileManager defaultManager] removeItemAtPath: imagePath error:&error];
         [self loadImageUrl:stringUrl];
         }else{
         [self setImage:img];
         [scrollingWheel stopAnimating];
         if ([delegate respondsToSelector:@selector(FetchImageSuccess:)]){
         [delegate FetchImageSuccess:self];
         }
         }*/
        
        [self setImage:img];
        [scrollingWheel stopAnimating];
        if ([delegate respondsToSelector:@selector(FetchImageSuccess:)])
        {
            [delegate FetchImageSuccess:self];
        }
    }
    else
    {
        [self loadImageUrl:stringUrl];
    }
}

- (void)loadImageUrl:(NSString*)url
{
    self.image = nil;
    if (connection!=nil) {
        
        [connection cancel];
        connection = nil;
    }
    if (data!=nil) {
        data = nil;
    }
    if (imgName2!=nil)
    {
        imgName2=nil;
    }
    
    imgName2 = [[url componentsSeparatedByString:@"/"] lastObject];
    NSString *imagePath = [[[AppDelegate sharedAppDelegate] applicationCacheDirectory] stringByAppendingPathComponent:strFolderName];
    imagePath = [imagePath stringByAppendingPathComponent:imgName2];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:imagePath]==NO)
    {
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:120.0];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    data=nil;
    [scrollingWheel stopAnimating];
    if(delegate)
    {
        if ([delegate respondsToSelector:@selector(FetchImageFail:)])
        {
            [delegate FetchImageFail:self];
        }
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (data != nil)
    {
        data = nil;
    }
    data = [NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)dataObj
{
    if (data == nil)
    {
        data = [NSMutableData data];
    }
    [data appendData:dataObj];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    UIImage *img = [UIImage imageWithData:data];
    
    CGImageRef cgref = [img CGImage];
    CIImage *cim = [img CIImage];
    
    if (cim == nil && cgref == NULL)
    {
        /*
         [data release];
         data=nil;
         [self loadImageFromStringforUserimg:[NSString stringWithFormat:@"%@",[connection.currentRequest URL]]];
         [connection release];
         connection=nil;
         */
        
    }
    else
    {
        connection=nil;
        [scrollingWheel stopAnimating];
        
        NSString *imagePath = [[[AppDelegate sharedAppDelegate] applicationCacheDirectory] stringByAppendingPathComponent:strFolderName];
        imagePath = [imagePath stringByAppendingPathComponent:imgName2];
        
        [data writeToFile:imagePath atomically:YES];
        self.image = nil;
        [self setImage:[UIImage imageWithContentsOfFile:imagePath]];
        if ([delegate respondsToSelector:@selector(FetchImageSuccess:)])
        {
            [delegate FetchImageSuccess:self];
        }
        data=nil;
        
        
    }
}


-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] >0) {
        
    }
}
-(void)cancelConnection
{
    if (connection !=nil) {
        [connection cancel];
        connection=nil;
    }
    if(data!=nil){
        data=nil;
    }
    [scrollingWheel stopAnimating];
}

@end
