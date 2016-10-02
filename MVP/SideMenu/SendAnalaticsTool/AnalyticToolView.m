//
//  AnalyticToolView.m
//  MVP
//
//  Created by Darshan on 17/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "AnalyticToolView.h"

#import "AnalyticsDetailsView.h"
#import "PapChat.h"
#import "StaticClass.h"
#import "AppDelegate.h"

@interface AnalyticToolView ()

@end

@implementation AnalyticToolView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"Analytics Tool" fontSize:18];
    
    //anlytics_Url
    
    NSString *strDeviceID = [[NSUserDefaults standardUserDefaults]objectForKey:DEVICE_ID];
      NSString *stremail = [[NSUserDefaults standardUserDefaults]objectForKey:USEREMAILID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:stremail forKey:@"email"];
    
    [SHARED_APPDELEGATE showLoadingView];
    
    [manager POST:anlytics_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"ResponceLogin %@",responseObject);
        
        arrReceivePap = [[NSMutableArray alloc]init];
        if(responseObject != nil){
            for(NSDictionary *dict in responseObject){
                
                NSString *strImg =[dict objectForKey:@"image"];
                NSString *strmsgId =[dict objectForKey:@"msg_id"];
                
                PapChat *objPapChat = [[PapChat alloc] init];
                objPapChat.arrAnalitycGroup = (NSMutableArray *)[dict objectForKey:@"data"];
                objPapChat.img_url = strImg;
                objPapChat.msg_id = strmsgId;
                
                [arrReceivePap addObject:objPapChat];
            }
            [_tblAnalytic reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"Error: %@", error);
        NSLog(@"operation %@ " , operation);
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91.0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrReceivePap count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Search";
    
    AnalyticToolCell *cell = (AnalyticToolCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AnalyticToolCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    PapChat *ogjPapChat = [arrReceivePap objectAtIndex:indexPath.row];
    [cell setAnalyticToolData:ogjPapChat];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnalyticsDetailsView *viewAnalytic = [[AnalyticsDetailsView alloc] initWithNibName:@"AnalyticsDetailsView" bundle:nil];
    [self.navigationController pushViewController:viewAnalytic animated:YES];
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

-(void)onClickCellIndex
{
    AnalyticsDetailsView *viewAnalytic = [[AnalyticsDetailsView alloc] initWithNibName:@"AnalyticsDetailsView" bundle:nil];
    [self.navigationController pushViewController:viewAnalytic animated:YES];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
