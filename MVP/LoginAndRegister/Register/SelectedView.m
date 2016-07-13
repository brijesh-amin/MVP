//
//  SelectedView.m
//  MVP
//
//  Created by Darshan on 14/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "SelectedView.h"

@interface SelectedView ()

@end

@implementation SelectedView

//Label
@synthesize lblTitle;

//NSString
@synthesize strSelect;

//NSMutableArray
@synthesize arrSelectSize;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    arrSelectSize = [[NSMutableArray alloc] init];
    
    if ([strSelect isEqualToString:@"UKTop"]) {
        lblTitle.text = @"Select UKTop";
        arrSelectSize = [NSMutableArray arrayWithObjects:@"78 CM",@"80.05 CM",@"83 CM",@"88 CM",@"93 CM",@"98 CM",@"103 CM",@"110.5 CM", nil];
    }else if ([strSelect isEqualToString:@"UKBottom"]){
        lblTitle.text = @"Select UKBottom";
        arrSelectSize = [NSMutableArray arrayWithObjects:@"60 CM",@"62.5 CM",@"65 CM",@"70 CM",@"75 CM",@"80 CM",@"85 CM",@"92.5 CM", nil];
    }else if ([strSelect isEqualToString:@"ChestSize"]){
        lblTitle.text = @"Select Chest Size";
        arrSelectSize = [NSMutableArray arrayWithObjects:@"86 CM",@"91 CM",@"96 CM",@"101 CM",@"106 CM",@"111 CM",@"116 CM", nil];
    }else if ([strSelect isEqualToString:@"WaistSize"]){
        lblTitle.text = @"Select Waist Size";
        arrSelectSize = [NSMutableArray arrayWithObjects:@"71 CM",@"76 CM",@"81 CM",@"86 CM",@"91 CM",@"96 CM", nil];
    }else if ([strSelect isEqualToString:@"ColarSize"]){
        lblTitle.text = @"Select Colar Size";
        arrSelectSize = [NSMutableArray arrayWithObjects:@"36 CM",@"37 CM",@"38 CM",@"41 CM",@"43 CM",@"44 CM",@"46 CM", nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrSelectSize count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    cell.textLabel.text = [arrSelectSize objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strBusinessSelect = [arrSelectSize objectAtIndex:indexPath.row];
    NSLog(@"result>>>>> %@",strBusinessSelect);
        
    if (_sizeDelegate && [_sizeDelegate respondsToSelector:@selector(selectSizePopUp:andReturnType:)]) {
        [_sizeDelegate selectSizePopUp:strBusinessSelect andReturnType:strSelect];
    }
}
- (void) deselect
{
    [self.tblBusinessCategory deselectRowAtIndexPath:[self.tblBusinessCategory indexPathForSelectedRow] animated:YES];
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
