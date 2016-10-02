//
//  NewsFeedView.m
//  MVP
//
//  Created by Darshan on 15/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "NewsFeedView.h"
#import "NewsFeedCell.h"
#import "StaticClass.h"
#import "AppDelegate.h"

@interface NewsFeedView ()

@end

@implementation NewsFeedView

//UITableView
@synthesize tblNewsFeed;

//NSMutableArray
@synthesize arrNewsFeed;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"News Feed" fontSize:18];
    
  //  self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    tblNewsFeed.tableFooterView  = [[UIView alloc]initWithFrame:CGRectZero];
    
    arrNewsFeed = [[NSMutableArray alloc] init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [SHARED_APPDELEGATE showLoadingView];
    
    [manager POST:trend_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"ResponceLogin %@",responseObject);
        
        NSArray *arrAllKey = [responseObject allKeys];
        
        for (NSString *strKeys in arrAllKey) {
            NSMutableArray *arrAccount = [responseObject objectForKey:strKeys];
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            
            [dict setObject:arrAccount forKey:strKeys];
            
            [arrNewsFeed addObject:dict];
        }
        [tblNewsFeed reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"Error: %@", error);
        NSLog(@"operation %@ " , operation);
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arrNewsFeed count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdenti = @"ChatImageCell";
    
    NewsFeedCell *cell = (NewsFeedCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdenti];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewsFeedCell" owner:self options:nil];
      //  cell = [nib objectAtIndex:0];
         cell = [nib objectAtIndex:0];
    }
    
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    NSMutableDictionary *dict = [arrNewsFeed objectAtIndex:indexPath.row];
    
    [cell setNewsFeedData:dict];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
