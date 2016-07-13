//
//  AttributView.m
//  MVP
//
//  Created by Darshan on 20/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "AttributView.h"
#import "AttributImgView.h"
#import "StaticClass.h"
#import "AttributCell.h"
#import "tblcellatr.h"
#import "ContactListView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>

#define GROUP_ONE   @"groupone"
#define GROUP_TWO   @"grouptwo"
#define GROUP_THREE @"groupthree"

#define GROUP_NAME_ONE   @"groupnameone"
#define GROUP_NAME_TWO   @"groupnametwo"
#define GROUP_NAME_THREE @"groupnamethree"

#define SELECTFAMILY @"SelectFamily"
#define ITEMTYPE @"ItemType"
#define URLTYPE @"urlType"

#define PRODUCTTITLE @"productTitle"
#define SELECTCOLOR @"SelectColor"

@interface AttributView ()
-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer;
@end

@implementation AttributView

//UIView
@synthesize viewImg;
@synthesize viewLeft;
@synthesize viewRight;
@synthesize viewHeader;
@synthesize viewListinTable;
@synthesize viewTop;
@synthesize viewtap;
//UITableView
@synthesize tblListing;
@synthesize tblList;
@synthesize tbltypeattribute;

//UIButton
@synthesize btnSend;
@synthesize btnCancel;

//UIImageView
@synthesize imgProduct;

//NSMutableArray
@synthesize arrSelected;
@synthesize arrList;
@synthesize arrAttributAdd;
@synthesize arrAttribut;
@synthesize arrAddatr;
@synthesize arrMain;
@synthesize arrDisplay;
@synthesize arrSecTblData;

@synthesize arr1;
@synthesize arr2;
@synthesize arr3;
@synthesize arr4;
@synthesize arr5;
@synthesize arr6;
@synthesize arr7;
@synthesize arr8;
@synthesize arr9;
@synthesize arr10;
@synthesize arr11;
@synthesize arr12;
@synthesize arr13;
@synthesize arr14;
@synthesize arr15;
@synthesize arr16;
@synthesize arr17;
@synthesize temparr;

//UIBUtton
@synthesize btnFirstGroup;
@synthesize btnSecondGroup;
@synthesize btnThirdGroup;
@synthesize btnSize;
@synthesize btnColor;
@synthesize btnDesign;



//UIScrollView
@synthesize scrollV;

@synthesize strOther;
@synthesize strq;
@synthesize strqq;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // self.navigationItem.titleView = [[AppDelegate sharedAppDelegate] getNavigationWithTitle:@"Attribut" fontSize:18];
    [tbltypeattribute setDelegate:self];
    [tbltypeattribute setDataSource:self];
    //[tbltypeattribute registerClass:[UITableViewCell self] forCellReuseIdentifier:@"tblcellatr1"];
    
    arr1 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Length",@"Material",@"Design",@"Trediness",nil];
    arr2 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Length",@"Frumpiness",@"Material",@"Design",nil];
    arr3 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Material",@"Design",@"Trediness",nil];
    arr4 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Length",@"Material",@"Design",@"Zip",nil];
    arr5 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Shape",@"Trediness",nil];
    arr6 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Material",@"Design",@"Shape",nil];
    arr7 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Length",@"Material",@"Design",@"Trediness",nil];
    arr8 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Length",@"Material",@"Cheaplooking",@"Design",nil];
    arr9 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Material",@"Comfort",@"Thickness",nil];
    arr10 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Material",@"Practically",@"Trediness",@"Strap",nil];
    arr11 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Material",@"Design",nil];
    arr12 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Frumpiness",@"Material",@"Bum Look Big",@"length",nil];
    arr13 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Length",@"Material",@"Pockets",nil];
    arr14 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Length",@"Bum Look Big",@"Shape",nil];
    arr15 = [[NSMutableArray alloc] initWithObjects:@"Trediness",@"Material",@"Smart",nil];
    arr16 = [[NSMutableArray alloc] initWithObjects:@"Trediness",@"Material",@"Smart",@"Lapel",nil];
    arr17 = [[NSMutableArray alloc] initWithObjects:@"Colour",@"Collar",@"Material",@"Cuffs",nil];
    
    NSString *strProductTitle = [[NSUserDefaults standardUserDefaults]objectForKey:PRODUCTTITLE];
    
    NSString *string = strProductTitle;
    //NSString *string = @"Men Jacket";
    
    //[@"Men" rangeOfString:string options:NSCaseInsensitiveSearch];
    if ([string rangeOfString:@"Men" options:NSCaseInsensitiveSearch].location != NSNotFound) {
        
        if ([string rangeOfString:@"jacket" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"overcoat" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"coat" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Raincoat" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Mac" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Macintosh" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            temparr = arr1;
        }
        if([string rangeOfString:@"Hoodie" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Sweatshirt" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Sweater" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Cardigan" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"pullover" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"jumper" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            temparr=arr3;
        }
        
        if([string rangeOfString:@"jeans" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            temparr=arr5;
        }
        if([string rangeOfString:@"trousers" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            temparr=arr6;
        }
        if([string rangeOfString:@"Waistcoat" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            temparr=arr8;
        }
        if([string rangeOfString:@"T-shirt" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Polo" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            temparr=arr11;
        }
        if([string rangeOfString:@"shirt" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Formal" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Casual" options:NSCaseInsensitiveSearch].location != NSNotFound )
        {
            temparr=arr17;
        }
    }
    else if([string rangeOfString:@"Ladies" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        
        if ([string rangeOfString:@"jacket" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"overcoat" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"coat" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Raincoat" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Mac" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Macintosh" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            temparr = arr1;
        }
        if([string rangeOfString:@"wedding" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Dresses" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Mexi" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Mini" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Workwear" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            temparr=arr2;
        }
        if([string rangeOfString:@"Hoodie" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Sweatshirt" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Sweater" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Cardigan" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"pullover" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"jumper" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            temparr=arr3;
        }
        if([string rangeOfString:@"jeans" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            temparr=arr5;
        }
        if([string rangeOfString:@"Leggings" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            temparr=arr6;
        }
        if([string rangeOfString:@"T-shirt" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Polo" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            temparr=arr11;
        }
        if([string rangeOfString:@"Blouse" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Top" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Casual" options:NSCaseInsensitiveSearch].location != NSNotFound || [string rangeOfString:@"Shirt" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            temparr=arr17;
        }
    }
    else{
        temparr=arr11;
    }
    
    if([temparr count ]==5)
    {
        arrAttributAdd = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"", nil];
    }
    if([temparr count ]==4)
    {
        arrAttributAdd = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"", nil];
    }
    if([temparr count ]==3)
    {
        arrAttributAdd = [[NSMutableArray alloc] initWithObjects:@"",@"",@"", nil];
    }
    if([temparr count ]==2)
    {
        arrAttributAdd = [[NSMutableArray alloc] initWithObjects:@"",@"", nil];
    }
    //    } else {
    //        NSLog(@"string does not contain bla");
    //    }
    //
    
    //    if ([string rangeOfString:@"Men" options:NSCaseInsensitiveSearch].location == NSNotFound )
    //    {
    //        if([string rangeOfString:@"Jacket" options:NSCaseInsensitiveSearch].location == NSNotFound ){
    //            arrAttributAdd = arr1;
    //
    //        }else if ([string rangeOfString:@"Tshirt" options:NSCaseInsensitiveSearch].location == NSNotFound ){
    //
    //
    //        }
    //
    //        NSLog(@"string does not contain bla");
    //    }
    
    
    btnSend.layer.cornerRadius = 15.0f;
    UIBarButtonItem *barBtnFilter = [[UIBarButtonItem alloc] initWithCustomView:btnSend];
    self.navigationItem.rightBarButtonItems = @[barBtnFilter];
    
    btnColor.layer.cornerRadius = 4.0f;
    btnSize.layer.cornerRadius = 4.0f;
    btnDesign.layer.cornerRadius = 4.0f;
    
    arrDisplay = [[NSMutableArray alloc] initWithArray: nil];
    
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: viewTop.frame byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){10.0, 10.0}].CGPath;
    viewTop.layer.mask = maskLayer;
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:tblList.bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = tblList.bounds;
    maskLayer1.path = maskPath.CGPath;
    tblList.layer.mask = maskLayer1;
    
    viewListinTable.layer.cornerRadius = 10.0f;
    viewListinTable.layer.borderWidth = 0.5;
    viewListinTable.layer.borderColor = appColor.CGColor;
    
    
    //  arrAttributAdd = [[NSMutableArray alloc] initWithObjects:nil, nil];
    arrAttribut = [[NSMutableArray alloc] initWithObjects:nil, nil];
    arrAddatr = [[NSMutableArray alloc] initWithObjects:nil, nil];
    viewImg.layer.cornerRadius = 4.0f;
    viewImg.layer.borderWidth = 2.0f;
    viewImg.layer.borderColor = [UIColor whiteColor].CGColor;
    
    viewLeft.layer.cornerRadius = 4.0f;
    viewLeft.layer.borderWidth = 1.0f;
    viewLeft.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    viewRight.layer.cornerRadius = 4.0f;
    viewRight.layer.borderWidth = 1.0f;
    viewRight.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    btnSend.layer.cornerRadius = 15.0f;
    
    [imgProduct loadImageFromUrl:[arrSelected firstObject]];
    
    [collectionContact registerNib:[UINib nibWithNibName:@"ContactCell" bundle:nil] forCellWithReuseIdentifier:@"ContactCell"];
    
    [self averageColor:imgProduct.image];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL* url = [NSURL URLWithString:[arrSelected firstObject]];
        [self logMetaDataFromURL:url];
        NSData *data = [NSData dataWithContentsOfURL:url];
        // [self logMetaDataFromData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [[UIImage alloc] initWithData:data];
            [self logMetaDataFromImage:image];
            NSLog (@"image.imageOrientation %ld",(long)image.imageOrientation);
        });
    });
    
    arrSelected =[[NSMutableArray alloc]init];
    
//    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
//    [self.viewtap addGestureRecognizer:singleTapGestureRecognizer];
}


-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer{
 
//    if (tblList.hidden) {
//        tblList.hidden = true;
//    }else
//    {
//          NSLog (@"",@"");
//    }
  
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if ([touch.view isDescendantOfView:tblList]) {
//        
//        // Don't let selections of auto-complete entries fire the
//        // gesture recognizer
//        return YES;
//    }
//    
//    return YES;
//}

-(void)reloadAllContacts {
    
    arrContacts =[[NSMutableArray alloc]init];
    [arrContacts addObjectsFromArray:[self getAllContactsfromContact]];
    [collectionContact reloadData];
}


- (void) logMetaDataFromURL:(NSURL*)URL
{
    NSLog(@" %@",NSStringFromSelector(_cmd));
    CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef)URL, NULL);
    CFDictionaryRef imageMetaData = CGImageSourceCopyPropertiesAtIndex(source,0,NULL);
    NSLog (@"%@",imageMetaData);
    
    
}
- (void) logMetaDataFromImage:(UIImage*)image
{
    NSLog(@" %@",NSStringFromSelector(_cmd));
    NSData *jpegData = UIImageJPEGRepresentation(image, 1.0);
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)jpegData, NULL);
    CFDictionaryRef imageMetaData = CGImageSourceCopyPropertiesAtIndex(source,0,NULL);
    NSLog (@"%@",imageMetaData);
}

- (UIColor *)averageColor:(UIImage*)img {
    
    CGImageRef imgRef = img.CGImage;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), imgRef);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == tblListing) {
        return self.viewFooter.frame.size.height;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView == tblListing) {
        return _viewFooter;
    }
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == tblListing) {
        return viewHeader.frame.size.height;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == tblListing) {
        return viewHeader;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tbltypeattribute) {
        return 44.0f;
    }
    return 44.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    if (tableView == tblListing) {
        return [arrAddatr count];
    }
    if (tableView == tbltypeattribute){
        
        return arrAttributAdd.count;
    }
    return [temparr count];
    //
    //    if (tableView == tblListing) {
    //        return [arrAttributAdd count];
    //    }
    //    else if (tableView == tbltypeattribute){
    //
    //        return arrAttributAdd.count;
    //    }
    //    return [arrAddatr count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == tblListing) {
        
        static NSString *simpleTableIdenti = @"AttributCell";
        
        AttributCell *cell = (AttributCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdenti];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AttributCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.closeBtnDelegate = self;
        cell.index = (int)indexPath.row;
        cell.txtAttribut.text = [arrAddatr objectAtIndex:indexPath.row];
        
        return cell;
    }
    if(tableView == tbltypeattribute){
        //
        //static NSString *simpleTableIdenti1 = @"tblcellatr";
        //         tblcellatr *cell = (tblcellatr *)[tableView dequeueReusableCellWithIdentifier:@"tblcellatr1"];
        //
        //        if (cell == nil) {
        //
        //            cell.textLabel.text @"size"
        //            cell.textlab
        //             NSLog (@"%@",@"no cell");
        //            cell.lblattributename.text = @"size";
        //            cell.lblattributename.textColor = [UIColor redColor];
        //            cell.tag = indexPath.row;
        //
        //        }
        //
        //
        
        static NSString *simpleTableIdenti = @"tblcellatr";
        
        tblcellatr *cell = (tblcellatr *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdenti];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"tblcellatr" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        //         if (indexPath.row  == strqq) {
        //             strqq = @"z";
        //               cell.lblattributename.text = strq;
        //         }
        //
        
        //         if (strqq == @"1") {
        //             strqq = @"2";
        //             cell.lblattributename.text = strq;
        //         }
        // cell.lblattributename.text = @"size";
        cell.lblattributename.text = [arrAttributAdd objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.tag = indexPath.row;
        
        return cell;
    }
    
    else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Any"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Any"];
        }
        //    if([arrBusinessCatCheck containsObject:arrBusCategory]) {
        //        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //    }
        //    else {
        //        cell.accessoryType = UITableViewCellAccessoryNone;
        //    }
        
        cell.textLabel.text = [arrList objectAtIndex:indexPath.row];
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblList) {
        
        arrSecTblData = [[NSMutableArray alloc] initWithObjects:@1.1,@1.2,@1.3, nil];
        arrSecTblData = arr1;
        NSString *strBusinessSelect = [arrSecTblData objectAtIndex:indexPath.row];
        //strqq = @"1";
        //NSString* myNewString = [NSString stringWithFormat:@"%i", indexPath.row];
        // strqq = myNewString;
        //  printf(@"strBusinessSelect");
        NSLog(@"strType>>> %@",strBusinessSelect);
        // strq = strBusinessSelect;
        
        //        if ([_lblTitle.text isEqualToString:@"Select Color"]) {
        //            [btnColor setTitle:strBusinessSelect forState:UIControlStateNormal];
        //            strFirst = strBusinessSelect;
        //        }else if ([_lblTitle.text isEqualToString:@"Select Size"]){
        //            [btnSize setTitle:strBusinessSelect forState:UIControlStateNormal];
        //            strSecond = strBusinessSelect;
        //        }else if ([_lblTitle.text isEqualToString:@"Select Design"]){
        //            [btnDesign setTitle:strBusinessSelect forState:UIControlStateNormal];
        //            strThird = strBusinessSelect;
        //        }
        
        
        [arrAttributAdd replaceObjectAtIndex:isFirstSelectedId withObject:[arrList objectAtIndex:indexPath.row]];
        
        [tbltypeattribute reloadData];
        viewListinTable.hidden = YES;
    }else if(tableView == tbltypeattribute){
        viewListinTable.hidden = NO;
        arrList = [[NSMutableArray alloc] init];
        isFirstSelectedId = indexPath.row;
        
        self.lblTitle.text = @"Select Attribute";
        //arrList = [NSMutableArray arrayWithObjects:@"Color", @"Size",@"Design", nil];
        arrList = temparr;
        //  NSString* myNewString = [NSString stringWithFormat:@"%i", [arrList count]];
        // NSLog(@"strType>>> %@",myNewString);
        [tblList reloadData];
        
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)setTableScrollWithIndex:(int)index
{
    int scrollY =  100 + (54 * index);
    [tblListing setContentOffset:CGPointMake(0.0f, scrollY) animated:YES];
}

//- (IBAction)onClickColorSetBtn:(UIButton *)sender {
//
//    viewListinTable.hidden = NO;
//    arrList = [[NSMutableArray alloc] init];
//
//    self.lblTitle.text = @"Select Color";
//    arrList = [NSMutableArray arrayWithObjects:@"Color", @"Size",@"Design", nil];
//
//    [tblList reloadData];
//}

//- (IBAction)onClickSizeSetBtn:(UIButton *)sender {
//
////    viewListinTable.sizeDelegate = self;
//    viewListinTable.hidden = NO;
//    self.lblTitle.text = @"Select Size";
//    arrList = [NSMutableArray arrayWithObjects:@"Color", @"Size",@"Design", nil];
//    [tblList reloadData];
//}
//
//- (IBAction)onClickDesignSetBtn:(UIButton *)sender {
//
//    viewListinTable.hidden = NO;
//    self.lblTitle.text = @"Select Design";
//    arrList = [NSMutableArray arrayWithObjects:@"Color", @"Size",@"Design", nil];
//    [tblList reloadData];
//}

-(void)selectCategoryPopUp:(NSString *)strCategory andReturnType:(NSString *)strType
{
    
    
    if ([strType isEqualToString:@"SelectColor"]) {
        [btnColor setTitle:strCategory forState:UIControlStateNormal];
    }else if ([strType isEqualToString:@"SelectSize"]){
        [btnSize setTitle:strCategory forState:UIControlStateNormal];
    }else if ([strType isEqualToString:@"SelectDesign"]){
        [btnDesign setTitle:strCategory forState:UIControlStateNormal];    }
    
    NSLog(@"strType>>> %@",strType);
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
- (IBAction)onClickAddAttributeBtn:(UIButton *)sender {
    
    if(!arrAddatr){
        arrAddatr = [[NSMutableArray alloc]init];
    }
    [arrAddatr addObject:@""];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[arrAddatr count]-1 inSection:0];
    [tblListing insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)closeBtnAtindex:(int)index
{
    if ([arrAddatr count] - 1 > index )
    {
        UIAlertController * alert= [UIAlertController
                                      alertControllerWithTitle:provideAlert
                                      message:@"Please remove below field first."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:provideOk
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        return;

    }
    
    NSLog(@"IndexValues %d",index);
    int myInteger = 5;
    NSString* myNewString = [NSString stringWithFormat:@"%i", myInteger];
    [arrAddatr removeObjectAtIndex:index];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:index   inSection:0];
    [tblListing deleteRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    // [arrAddatr reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    NSString *strFirstGroup = [[NSUserDefaults standardUserDefaults]objectForKey:GROUP_NAME_ONE];
    NSString *strTwoGroup = [[NSUserDefaults standardUserDefaults]objectForKey:GROUP_NAME_TWO];
    NSString *strThirdGroup = [[NSUserDefaults standardUserDefaults]objectForKey:GROUP_NAME_THREE];
    
    if (strFirstGroup == nil) {
        [btnFirstGroup setTitle:@"First Group" forState:UIControlStateNormal];
    }else{
        [btnFirstGroup setTitle:strFirstGroup forState:UIControlStateNormal];
    }
    
    if (strTwoGroup == nil){
        [btnSecondGroup setTitle:@"Second Group" forState:UIControlStateNormal];
    }else{
        [btnSecondGroup setTitle:strTwoGroup forState:UIControlStateNormal];
    }
    
    if (strThirdGroup == nil){
        [btnThirdGroup setTitle:@"Third Group" forState:UIControlStateNormal];
    }else{
        [btnThirdGroup setTitle:strThirdGroup forState:UIControlStateNormal];
    }
    
    btnFirstGroup.layer.cornerRadius = 4.0f;
    btnSecondGroup.layer.cornerRadius = 4.0f;
    btnThirdGroup.layer.cornerRadius = 4.0f;
    
    [self reloadAllContacts];
}
-(IBAction)onclickGroupOne:(id)sender
{
    NSUserDefaults *userDefault =[NSUserDefaults standardUserDefaults];
    if([userDefault objectForKey:GROUP_NAME_ONE] == nil){
        ContactListView *contactList =[[ContactListView alloc]initWithNibName:@"ContactListView" bundle:nil];
        contactList.grouptype = Group_One;
        [self presentViewController:contactList animated:YES completion:nil];
    }else{
        
        arrContacts =[[NSMutableArray alloc]init];
        NSArray *Arr =[userDefault objectForKey:GROUP_ONE];
        
        NSLog(@"DATA %@", Arr);
        arrContacts =[[NSMutableArray alloc]initWithArray:Arr];
        
        [collectionContact reloadData];
    }
}



-(IBAction)onclickGroupTwo:(id)sender
{
    NSUserDefaults *userDefault =[NSUserDefaults standardUserDefaults];
    if([userDefault objectForKey:GROUP_NAME_TWO] == nil){
        ContactListView *contactList =[[ContactListView alloc]initWithNibName:@"ContactListView" bundle:nil];
        contactList.grouptype = Group_Two;
        [self presentViewController:contactList animated:YES completion:nil];
    }else{
        arrContacts =[[NSMutableArray alloc]init];
        
        NSArray *Arr =[userDefault objectForKey:GROUP_TWO];
        
        NSLog(@"DATA %@", Arr);
        arrContacts =[[NSMutableArray alloc]initWithArray:Arr];
        
        
        [collectionContact reloadData];
    }
}

-(IBAction)onclickGroupThree:(id)sender
{
    NSUserDefaults *userDefault =[NSUserDefaults standardUserDefaults];
    if([userDefault objectForKey:GROUP_NAME_THREE] == nil){
        ContactListView *contactList =[[ContactListView alloc]initWithNibName:@"ContactListView" bundle:nil];
        contactList.grouptype = Group_Three;
        [self presentViewController:contactList animated:YES completion:nil];
    }else{
        arrContacts =[[NSMutableArray alloc]init];
        
        NSArray *Arr =[userDefault objectForKey:GROUP_THREE];
        NSLog(@"DATA %@", Arr);
        arrContacts =[[NSMutableArray alloc]initWithArray:Arr];
        
        [collectionContact reloadData];
    }
}


-(UIView*)getTextFieldLeftAndRightView
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    return paddingView;
}

#pragma mark -
#pragma mark - TextField Padding Method

-(UIView*)getTextFieldRightAndLeftView
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    return paddingView;
}

-(void)resingKeyBoard
{
    [tblListing setContentOffset:CGPointMake(0.0f, 0.0) animated:YES];
}

#pragma mark -
#pragma mark - Pop To View Mothod

-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSArray *)getAllContactsfromContact {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    CFErrorRef *error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    __block BOOL accessGranted = NO;
    
    if (&ABAddressBookRequestAccessWithCompletion != NULL){
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else{
        accessGranted = YES;
    }
    if (accessGranted){
        // If the app is authorized to access the first time then add the contact
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
        
        for (int i=0; i<numberOfPeople; i++){
            CFStringRef phone;
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
            CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
            CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
            CFStringRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
            
            NSData *imageData = (__bridge NSData*)ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
            UIImage *image = [UIImage imageWithData:imageData];
            
            
            NSString *userName = @"NoName";
            
            userName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
            userName = [userName stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            
            ABMutableMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
            CFIndex phoneNumberCount = ABMultiValueGetCount( phoneNumbers );
            
            phone = nil;
            
            for ( CFIndex ind= 0; ind<phoneNumberCount; ind++ ){
                CFStringRef phoneNumberLabel = ABMultiValueCopyLabelAtIndex( phoneNumbers, ind);
                CFStringRef phoneNumberValue = ABMultiValueCopyValueAtIndex( phoneNumbers, ind);
                if (phoneNumberLabel != nil){
                    CFStringCompareFlags compareOptions  =  kCFCompareCaseInsensitive ;
                    if(CFStringCompare(phoneNumberLabel, CFSTR("mobile"),compareOptions)){
                        phone = phoneNumberValue;
                    }
                    phone = phoneNumberValue;
                    CFStringCompareFlags compareOptionss  =  kCFCompareCaseInsensitive ;
                    if(!CFStringCompare(phone, CFSTR("1-800-MY-APPLE"),compareOptionss)){
                        continue;
                    }
                    /*
                     ContactData *contactData =  [[ContactData alloc]init];
                     contactData.firstName = userName;
                     contactData.lastName = [userName lowercaseString];
                     contactData.contact =[NSString stringWithFormat:@"%@", phone];
                     contactData.email = [NSString stringWithFormat:@"%@" ,email];
                     */
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                    
                    [dict setObject:userName forKey:@"firstName"];
                    [dict setObject:userName forKey:@"lastName"];
                    [dict setObject:[NSString stringWithFormat:@"%@", phone] forKey:@"contact"];
                    [dict setObject:[NSString stringWithFormat:@"%@" ,email] forKey:@"email"];
                    
                    if (image != nil) {
                        [dict setObject:image forKey:@"ProfileImage"];
                    }
                    
                    [result addObject:dict];
                }
                break;
            }
        }
    }
    return result;
}

- (IBAction)btnCancel:(id)sender {
    viewListinTable.hidden = true;
    [tbltypeattribute reloadData];
}


- (IBAction)onClickSendBtn:(UIButton *)sender {
    
    
    if ([arrSelected count] == 0) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:provideAlert
                                      message:@"OO..Please select someone."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:provideOk
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
        
         //NSLog(@"strContact>>> %@","no selected");
    }
    [self showLoadingView];
    /*
     For Share pap service :-
     
     Link :- http://mahatmainfoware.com/iphoneAppServices/sharepap.php
     
     Required parameter :- device_id,url,for,item_type,attribute1,attribute2,attribute3,attribute4,attribute5,to,image(fileupload)
     
     Response parameter :-Status,email,message
     */
    
    // ,,,,,,,,,to,(fileupload)
    NSMutableArray *arrTemp = [[NSMutableArray alloc] init];
    
    NSString *str1 = nil;
    NSString *str2 = nil;
    NSString *str3 = nil;
    

    
    NSString *strDeviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *strUrl = [[NSUserDefaults standardUserDefaults]objectForKey:URLTYPE];
    NSString *strItem = [[NSUserDefaults standardUserDefaults]objectForKey:ITEMTYPE];
    NSString *strFor = nil;
    if (strOther == nil) {
        strFor = [[NSUserDefaults standardUserDefaults]objectForKey:SELECTFAMILY];
    }else{
        strFor = strOther;
    }
    
    NSMutableArray *columns = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary *dict in arrSelected) {
        
        [columns addObject:[dict objectForKey:@"contact"]];
    }
    
    NSString *strTableColumn = [columns componentsJoinedByString:@","];
    
    NSLog(@"strContact>>> %@",strTableColumn);
    
    //    NSString *strTo = [NSString stringWithFormat:@"%@,%@,%@",@"Darshan",@"Jolapara",@"darshan@gmail.com"];
    
    NSLog(@"strDeviceID>>>>>> %@",strDeviceID);
    NSLog(@"strUrl>>>>> %@",strUrl);
    NSLog(@"strItem>>>> %@",strItem);
    NSLog(@"strFor>>>> %@",strFor);
    
    NSString *strProductTitle = [[NSUserDefaults standardUserDefaults]objectForKey:PRODUCTTITLE];
    
    NSURL *aUrl = [NSURL URLWithString:sharePap_Url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"POST"];
    
    /*
     [dictParam setValue:@"userfavorite" forKey:@"action"];
     [dictParam setValue:@"usersList" forKey:@"type"];
     [dictParam setValue:@"1" forKey:@"userid"];
     */
   // arrAttributAdd
      NSString *str4 = @"";
     NSString *str5 = @"";
    if([temparr count ]==5)
    {
        //arrAttributAdd = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"", nil];
        str1 = [arrAttributAdd objectAtIndex:0];
        str2 = [arrAttributAdd objectAtIndex:1];
        str3 = [arrAttributAdd objectAtIndex:2];
        str4 = [arrAttributAdd objectAtIndex:3];
        str5 = [arrAttributAdd objectAtIndex:4];
    }
    if([temparr count ]==4)
    {
       // arrAttributAdd = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"", nil];
        str1 = [arrAttributAdd objectAtIndex:0];
        str2 = [arrAttributAdd objectAtIndex:1];
        str3 = [arrAttributAdd objectAtIndex:2];
        str4 = [arrAttributAdd objectAtIndex:3];
      //  str5 = [arrAttributAdd objectAtIndex:4];
    }
    if([temparr count ]==3)
    {
       // arrAttributAdd = [[NSMutableArray alloc] initWithObjects:@"",@"",@"", nil];
        str1 = [arrAttributAdd objectAtIndex:0];
        str2 = [arrAttributAdd objectAtIndex:1];
        str3 = [arrAttributAdd objectAtIndex:2];
        //str4 = [arrAttributAdd objectAtIndex:3];

    }
    if([temparr count ]==2)
    {
        //arrAttributAdd = [[NSMutableArray alloc] initWithObjects:@"",@"", nil];
        str1 = [arrAttributAdd objectAtIndex:0];
        str2 = [arrAttributAdd objectAtIndex:1];
        //str3 = [a rrAttributAdd objectAtIndex:2];

    }
    
    NSString *str6 = @"";
    NSString *str7 = @"";
    NSString *str8 = @"";
    NSString *str9 = @"";
    if ([arrAddatr count]==1) {
        str6 = [arrAddatr objectAtIndex:0];
    }
    if ([arrAddatr count]==2) {
        str6 = [arrAddatr objectAtIndex:0];
         str7 = [arrAddatr objectAtIndex:1];

    }
    if ([arrAddatr count]==3) {
        str6 = [arrAddatr objectAtIndex:0];
        str7 = [arrAddatr objectAtIndex:1];
          str8 = [arrAddatr objectAtIndex:2];
    }
    if ([arrAddatr count]==4) {
        str6 = [arrAddatr objectAtIndex:0];
        str7 = [arrAddatr objectAtIndex:1];
        str8 = [arrAddatr objectAtIndex:2];
        str9 = [arrAddatr objectAtIndex:3];
    }

    for(int i= 0 ; i < [arrAddatr count] ; i++){
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        AttributCell *cell = [tblListing cellForRowAtIndexPath:newIndexPath];
        if(cell != nil){
            [arrTemp addObject:cell.txtAttribut.text];
            
            if (i == 0) {
                str6 = cell.txtAttribut.text;
            }else if (i == 1){
                str7 = cell.txtAttribut.text;
            }else if (i == 2){
                str8 = cell.txtAttribut.text;
            }else if (i == 2){
                str9 = cell.txtAttribut.text;
            }
        }
    }
    
    NSString *postString = [NSString stringWithFormat:@"device_id=%@&url=%@&for=%@&item_type=%@&attribute1=%@&attribute2=%@&attribute3=%@&attribute4=%@&attribute5=%@&attribute6=%@&attribute7=%@&attribute8=%@&attribute9=%@&attribute10=%@&to=%@&image=%@&keyword=%@",strDeviceID,strUrl,strFor,strItem,str1,str2,str3,str4,str5,@"",str6,str7,str8,str9,strTableColumn,strUrl,strProductTitle];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection= [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
        receiveData = [NSMutableData data];
    }
}
#pragma mark -
#pragma mark - NSURL CONNECTION DELEGATE

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    receiveData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [receiveData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSError *jsonError;
    
    // 2
    NSDictionary *notesJSON =
    [NSJSONSerialization JSONObjectWithData:receiveData
                                    options:NSJSONReadingAllowFragments
                                      error:&jsonError];
    
    //    arrList = [[NSMutableArray alloc]init];
    //
    //    for(NSDictionary *dict in [notesJSON objectForKey:@"teamList"]){
    //        [arrList addObject:dict];
    //    }
    
    NSLog(@"notesJSON %@", notesJSON);
    [self hideLoadingView];
    
    if (![[notesJSON objectForKey:@"Status"] boolValue]) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:provideAlert
                                      message:[notesJSON objectForKey:@"message"]
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:provideOk
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    if ([[notesJSON objectForKey:@"Status"] boolValue]) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:provideAlert
                                      message:[notesJSON objectForKey:@"message"]
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:provideOk
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self setNavigationMethod];
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    if (!jsonError) {
        // TODO 2: More coming here!
    }
    
    
}

-(void)setNavigationMethod
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification" object:self];
    
    UIViewController* vc = self;
    
    while (vc) {
        UIViewController* temp = vc.presentingViewController;
        if (!temp.presentedViewController) {
            [vc dismissViewControllerAnimated:YES completion:^{}];
            break;
        }
        vc =  temp;
    }
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"GETTING ERROR %@", error);
}

//-(void)DelayType
//{
//    [self hideLoadingView];
//
//    UIAlertController * alert=   [UIAlertController
//                                  alertControllerWithTitle:provideAlert
//                                  message:@"Send SuccessFully...."
//                                  preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction* ok = [UIAlertAction
//                         actionWithTitle:provideOk
//                         style:UIAlertActionStyleDefault
//                         handler:^(UIAlertAction * action)
//                         {
//                             [alert dismissViewControllerAnimated:YES completion:nil];
//
//                         }];
//
//    [alert addAction:ok];
//
//    [self presentViewController:alert animated:YES completion:nil];
//}
-(void)showLoadingView
{
    
    if (loadView == nil)
    {
        loadView = [[UIView alloc] initWithFrame:self.view.frame];
        loadView.opaque = NO;
        loadView.backgroundColor = [UIColor clearColor];
        //loadView.alpha = 0.7f;
        
        viewBack = [[UIView alloc] initWithFrame:CGRectMake(80, 230, 160, 50)];
        viewBack.backgroundColor = [UIColor blackColor];
        viewBack.alpha = 0.7f;
        viewBack.layer.masksToBounds = NO;
        viewBack.layer.cornerRadius = 5;
        
        lblLoading = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 110, 50)];
        lblLoading.backgroundColor = [UIColor clearColor];
        lblLoading.textAlignment = NSTextAlignmentCenter;
        lblLoading.text = @"Please Wait...";
        lblLoading.numberOfLines = 2;
        
        spinningWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(5.0, 10.0, 30.0, 30.0)];
        spinningWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        lblLoading.textColor = [UIColor whiteColor];
        [spinningWheel startAnimating];
        [viewBack addSubview:spinningWheel];
        
        //lblLoading.font = FONT_REGULAR(16);
        [viewBack addSubview:lblLoading];
        [loadView addSubview:viewBack];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            
            float y = (loadView.frame.size.height/2 ) - (viewBack.frame.size.height/2);
            float x =(loadView.frame.size.width/2 ) - (viewBack.frame.size.width/2);
            viewBack.frame = CGRectMake(x , y, 160, 50);;
        }
        else{
            
            float y = (loadView.frame.size.height/2 ) - (viewBack.frame.size.height/2);
            float x =(loadView.frame.size.width/2 ) - (viewBack.frame.size.width/2);
            viewBack.frame = CGRectMake(x , y, 160, 50);;
        }
    }
    if(loadView.superview == nil)
        [self.view addSubview:loadView];
}

-(void) hideLoadingView
{
    [loadView removeFromSuperview];
    loadView=nil;
}


#pragma mark - UICollectionView Datasource
#pragma mark -

-(NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return [arrContacts count];
}

#pragma mark - UICollectionView Delegate

-(UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ContactCell *cell =(ContactCell *)[cv dequeueReusableCellWithReuseIdentifier:@"ContactCell" forIndexPath:indexPath];
    
    NSMutableDictionary *dict =[arrContacts objectAtIndex:indexPath.row];
    
    if([arrSelected containsObject:dict]){
        [cell setSelectedContact:dict];
    }else{
        [cell setNormalContact:dict];
    }
    //[cell setContacts:[arrContacts objectAtIndex:indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dict =[arrContacts objectAtIndex:indexPath.row];
    
    if([arrSelected containsObject:dict]){
        [arrSelected removeObject:dict];
    }else{
        if(!arrSelected ){
            arrSelected =[[NSMutableArray alloc]init];
        }
        [arrSelected addObject:dict];
    }
    [collectionView reloadData];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 90);
}


- (IBAction)onClickBackBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
