//
//  CommonClass.m
//  Viewfoo
//
//  Created by MitulB on 22/05/15.
//  Copyright (c) 2015 com. All rights reserved.
//

#import "CommonClass.h"
#import "AppDelegate.h"

//AppDelegate *appDelegate;

@implementation CommonClass



/*
+(CommonClass *)shareObject
{
    appDelegate  = [AppDelegate sharedAppDelegate];
    static CommonClass *objComminClass = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objComminClass = [[CommonClass alloc]init];
    });
    return objComminClass;
} */


+(NSString *)trimString:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
}

+(NSString *) removeNull:(NSString *) string
{
    if (string.length == 0)
    {
        string = @"";
    }
    NSRange range = [string rangeOfString:@"null"];
    if (range.length > 0 || string == nil)
    {
        string = @"";
    }
    string = [self trimString:string];
    return string;
}

+(NSString *) removeNull1:(NSString *) string
{
    if ([string isKindOfClass:[NSNull class]] || [string isEqualToString:@""])
    {
        string = @"-";
    }
    string = [self trimString:string];
    return string;
}

+ (void) showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];

}
+(void)showAlertWithTitle:(NSString *)strTitle andMessage:(NSString *)strMessage delegate:(id)delegate
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Alert!"
                                          message:strMessage
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                       
                                   }];
    [alertController addAction:cancelAction];
    [delegate presentViewController:alertController animated:YES completion:nil];
}

+ (BOOL)textIsValidEmailFormat:(NSString *)text {
    
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:text];
}
+ (BOOL)validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}
+(NSString *)getStringDateFromDate:(NSDate *)date
{
    /*
    NSDate* endDateLocal = [NSDate dateWithTimeInterval:[[NSTimeZone systemTimeZone] secondsFromGMT] sinceDate:curDate];
    NSTimeInterval seconds = [endDateLocal timeIntervalSinceDate:strDate];
     */
    NSDateFormatter *dateFromat = [[NSDateFormatter alloc]init];
    [dateFromat setDateFormat:@"MMM,dd yyyy"];
    NSString *strDate = [dateFromat stringFromDate:date];
    
    return strDate;
}
+(NSString *)getStringDateFromString:(NSString *)strDate
{
        return @"sd";
}

+ (NSString*)generateFileNameWithExtension:(NSString *)extensionString
{
    // Extenstion string is like @".png"
    
    NSDate *time = [NSDate date];
    NSDateFormatter* df = [NSDateFormatter new];
    [df setDateFormat:@"dd-MM-yyyy-hh-mm-ss"];
    NSString *timeString = [df stringFromDate:time];
    int r = arc4random() % 100;
    int d = arc4random() % 100;
    NSString *fileName = [NSString stringWithFormat:@"File-%@%d%d%@", timeString, r , d , extensionString ];
    
    NSLog(@"FILE NAME %@", fileName);
    
    return fileName;
}

+ (NSString *)extractYoutubeIdFromLink:(NSString *)link {
    
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    
    NSArray *array = [regExp matchesInString:link options:0 range:NSMakeRange(0,link.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
        return [link substringWithRange:result.range];
    }
    return nil;
}



@end
