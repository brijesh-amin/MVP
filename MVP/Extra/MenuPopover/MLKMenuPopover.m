//
//  MLKMenuPopover.m
//  MLKMenuPopover
//
//  Created by NagaMalleswar on 20/11/14.
//  Copyright (c) 2014 NagaMalleswar. All rights reserved.
//

#import "MLKMenuPopover.h"
#import <QuartzCore/QuartzCore.h>
#import "StaticClass.h"
#import "MLKMenuCell.h"
#import "AppDelegate.h"

#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]

#define MENU_ITEM_HEIGHT        44
#define FONT_SIZE               15
#define CELL_IDENTIGIER         @"MenuPopoverCell"
#define MENU_TABLE_VIEW_FRAME   CGRectMake(0, 0, frame.size.width, frame.size.height)
#define SEPERATOR_LINE_RECT     CGRectMake(10, MENU_ITEM_HEIGHT - 1, self.frame.size.width - 20, 1)
#define MENU_POINTER_RECT       CGRectMake(frame.origin.x, frame.origin.y, 23, 11)

#define CONTAINER_BG_COLOR      RGBA(0, 0, 0, 0.1f)

#define ZERO                    0.0f
#define ONE                     1.0f
#define ANIMATION_DURATION      0.5f

#define MENU_POINTER_TAG        1011
#define MENU_TABLE_VIEW_TAG     1012

#define LANDSCAPE_WIDTH_PADDING 50

@interface MLKMenuPopover ()

@property(nonatomic,retain) NSMutableArray *menuItems;
@property(nonatomic,retain) UIButton *containerButton;

- (void)hide;
- (void)addSeparatorImageToCell:(UITableViewCell *)cell;

@end

@implementation MLKMenuPopover

@synthesize menuPopoverDelegate;
@synthesize menuItems;
@synthesize containerButton;
@synthesize selectSound;
@synthesize isShowMenu;

AppDelegate *appDelegateMenuPopOver;

- (id)initWithFrame:(CGRect)frame menuItems:(NSMutableArray *)aMenuItems
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.menuItems = aMenuItems;
        
        appDelegateMenuPopOver = [AppDelegate sharedAppDelegate];
        
//        [self.menuItems addObject:[self getDictfromTitle:@"Stream" imageIco:@"Stream" andSelIcon:@"SelectStream"]];
//        [self.menuItems addObject:[self getDictfromTitle:@"Search Paper" imageIco:@"StramPaper" andSelIcon:@"SelectStramPaper"]];
//        [self.menuItems addObject:[self getDictfromTitle:@"Book Category" imageIco:@"BookCategory" andSelIcon:@"SelectBookCategory"]];
//        [self.menuItems addObject:[self getDictfromTitle:@"Books" imageIco:@"Books" andSelIcon:@"SelectBooks"]];
//        [self.menuItems addObject:[self getDictfromTitle:@"Download" imageIco:@"DownloadFile" andSelIcon:@"SelectDownloadFile"]];
//        [self.menuItems addObject:[self getDictfromTitle:@"About Us" imageIco:@"Books" andSelIcon:@"SelectBooks"]];
//        [self.menuItems addObject:[self getDictfromTitle:@"LogOut" imageIco:@"LogOut" andSelIcon:@"SelectLogOut"]];
        
        // Adding Container Button which will take care of hiding menu when user taps outside of menu area
        self.containerButton = [[UIButton alloc] init];
        [self.containerButton setBackgroundColor:CONTAINER_BG_COLOR];
        [self.containerButton addTarget:self action:@selector(dismissMenuPopover) forControlEvents:UIControlEventTouchUpInside];
        [self.containerButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
        
        // Adding Menu Options Pointer
       /* UIImageView *menuPointerView = [[UIImageView alloc] initWithFrame:MENU_POINTER_RECT];
        menuPointerView.image = [UIImage imageNamed:@"options_pointer"];
        menuPointerView.tag = MENU_POINTER_TAG;
        [self.containerButton addSubview:menuPointerView];*/
        
        // Adding menu Items table
        UITableView *menuItemsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        menuItemsTableView.dataSource = self;
        menuItemsTableView.delegate = self;
        menuItemsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        menuItemsTableView.scrollEnabled = NO;
        menuItemsTableView.backgroundColor = tableColor;//[UIColor whiteColor];
        menuItemsTableView.tag = MENU_TABLE_VIEW_TAG;
        
        //UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Menu_PopOver_BG"]];
        //menuItemsTableView.backgroundView = bgView;
        
        [self addSubview:menuItemsTableView];
        
        [self.containerButton addSubview:self];
    }
    
    return self;
}

#pragma mark -
#pragma mark UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MENU_ITEM_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *simpleTableIdentifier = @"Search";
    
    MLKMenuCell *cell = (MLKMenuCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MLKMenuCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.effectDelegate = self;
    cell.index = (int)indexPath.row;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (selectSound == NO) {
        cell.lblTitle.text = [self.menuItems objectAtIndex:indexPath.row];
    }else{
        cell.lblTitle.text = [self.menuItems objectAtIndex:indexPath.row];
        cell.btnRedio.hidden = NO;

        NSString *strtitle = [[NSUserDefaults standardUserDefaults]objectForKey:TITLE];
        
        if([strtitle isEqualToString:cell.lblTitle.text]){
            [cell.btnRedio setSelected:YES];
        }else{
            [cell.btnRedio setSelected:NO];
        }
}
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];

    if (selectSound == YES) {
        NSString *strTitle = [self.menuItems objectAtIndex:indexPath.row];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:strTitle forKey:TITLE];
    }
    [self.menuPopoverDelegate menuPopover:self didSelectMenuItemAtIndex:indexPath.row];
}

-(void)setSelectSoundEffect:(int)index
{
    [self hide];
    
    if (selectSound == YES) {
        NSString *strTitle = [self.menuItems objectAtIndex:index];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:strTitle forKey:TITLE];
    }
    [self.menuPopoverDelegate menuPopover:self didSelectMenuItemAtIndex:index];
}
#pragma mark -
#pragma mark Actions

- (void)dismissMenuPopover
{
    [self hide];
}

- (void)showInView:(UIView *)view
{
    self.containerButton.alpha = ZERO;
    self.containerButton.frame = view.bounds;
    [view addSubview:self.containerButton];
        
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         self.containerButton.alpha = ONE;
                         isShowMenu = YES;
                     }
                     completion:^(BOOL finished) {}];
}

- (void)hide
{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         self.containerButton.alpha = ZERO;
                     }
                     completion:^(BOOL finished) {
                         [self.containerButton removeFromSuperview];
                         isShowMenu = NO;
                     }];
}

#pragma mark -
#pragma mark Separator Methods

- (void)addSeparatorImageToCell:(UITableViewCell *)cell
{
    UIImageView *separatorImageView = [[UIImageView alloc] initWithFrame:SEPERATOR_LINE_RECT];
    [separatorImageView setBackgroundColor:[UIColor blackColor]];
//    [separatorImageView setImage:[UIImage imageNamed:@"DefaultLine"]];
    separatorImageView.opaque = YES;
    [cell.contentView addSubview:separatorImageView];
}

#pragma mark -
#pragma mark Orientation Methods

- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    BOOL landscape = (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    
    UIImageView *menuPointerView = (UIImageView *)[self.containerButton viewWithTag:MENU_POINTER_TAG];
    UITableView *menuItemsTableView = (UITableView *)[self.containerButton viewWithTag:MENU_TABLE_VIEW_TAG];
    
    if( landscape )
    {
        menuPointerView.frame = CGRectMake(menuPointerView.frame.origin.x + LANDSCAPE_WIDTH_PADDING, menuPointerView.frame.origin.y, menuPointerView.frame.size.width, menuPointerView.frame.size.height);
        
        menuItemsTableView.frame = CGRectMake(menuItemsTableView.frame.origin.x + LANDSCAPE_WIDTH_PADDING, menuItemsTableView.frame.origin.y, menuItemsTableView.frame.size.width, menuItemsTableView.frame.size.height);
    }
    else
    {
        menuPointerView.frame = CGRectMake(menuPointerView.frame.origin.x - LANDSCAPE_WIDTH_PADDING, menuPointerView.frame.origin.y, menuPointerView.frame.size.width, menuPointerView.frame.size.height);
        
        menuItemsTableView.frame = CGRectMake(menuItemsTableView.frame.origin.x - LANDSCAPE_WIDTH_PADDING, menuItemsTableView.frame.origin.y, menuItemsTableView.frame.size.width, menuItemsTableView.frame.size.height);
    }
}

@end
