//
//  CommonClass.h
//  Viewfoo
//
//  Created by MitulB on 22/05/15.
//  Copyright (c) 2015 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonClass : NSObject

//+(CommonClass *)shareObject;

+(NSString *)trimString:(NSString *)string;

+(NSString *) removeNull:(NSString *) string;

+(NSString *) removeNull1:(NSString *) string;

+ (void) showAlertWithTitle:(NSString *)title message:(NSString *)message;
+ (BOOL)textIsValidEmailFormat:(NSString *)text;

+(NSString *)getStringDateFromDate:(NSDate *)date;

+ (NSString*)generateFileNameWithExtension:(NSString *)extensionString;

+ (NSString *)extractYoutubeIdFromLink:(NSString *)link;
+ (BOOL)validateUrl: (NSString *) candidate;
+(void)showAlertWithTitle:(NSString *)strTitle andMessage:(NSString *)strMessage delegate:(id)delegate;
@end
