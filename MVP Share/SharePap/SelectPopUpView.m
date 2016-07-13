//
//  SelectPopUpView.m
//  MVP
//
//  Created by Darshan on 05/06/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "SelectPopUpView.h"

@interface SelectPopUpView ()

@end

@implementation SelectPopUpView

@synthesize tblList;
@synthesize lblTitle;
@synthesize arrList;
@synthesize strTitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    arrList = [[NSMutableArray alloc] init];
    
    if ([strTitle isEqualToString:@"SelectColor"]) {
        lblTitle.text = @"Select Color";
        arrList = [NSMutableArray arrayWithObjects:@"Color", @"Size",@"Design", nil];
    }else if ([strTitle isEqualToString:@"UKBottom"]){
        lblTitle.text = @"Select Size";
        arrList = [NSMutableArray arrayWithObjects:@"Color", @"Size",@"Design", nil];
    }else if ([strTitle isEqualToString:@"ChestSize"]){
        lblTitle.text = @"Select Design";
        arrList = [NSMutableArray arrayWithObjects:@"Color", @"Size",@"Design", nil];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strBusinessSelect = [arrList objectAtIndex:indexPath.row];
    NSLog(@"result>>>>> %@",strBusinessSelect);
    
    if (_categoryDelegate && [_categoryDelegate respondsToSelector:@selector(selectCategoryPopUp:andReturnType:)]) {
        [_categoryDelegate selectCategoryPopUp:strBusinessSelect andReturnType:strTitle];
    }
}
- (void) deselect
{
    [self.tblList deselectRowAtIndexPath:[self.tblList indexPathForSelectedRow] animated:YES];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
