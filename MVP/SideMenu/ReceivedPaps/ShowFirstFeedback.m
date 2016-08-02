//
//  ShowFeedback.m
//  MVP
//
//  Created by Bhavik Panchal on 7/29/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "ShowFirstFeedback.h"
#import "ShowFeedback.h"
#import "StaticClass.h"
#import "AppDelegate.h"

@interface ShowFirstFeedback ()

@end

@implementation ShowFirstFeedback

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"Analytic Feedback" fontSize:18];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:_strMessageId forKey:@"msg_id"];
    
    [SHARED_APPDELEGATE showLoadingView];
    
    [manager POST:feedBackData_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"ResponceLogin %@",responseObject);
        
        NSMutableDictionary *dicDetail = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
        
        
        if ([[dicDetail objectForKey:@"attribute"] length] > 0) {
            
            NSArray *atribute = [[dicDetail objectForKey:@"attribute"] componentsSeparatedByString:@","];
            NSArray *noOfYes = [[dicDetail objectForKey:@"totalyescount"] componentsSeparatedByString:@","];
            NSArray *noOfNo = [[dicDetail objectForKey:@"totalnocount"] componentsSeparatedByString:@","];

            NSString *strFinalAttribute = [[NSString alloc] init];
            NSString *strFinalNoOfNo = [[NSString alloc] init];
            NSString *strFinaNoOfYes = [[NSString alloc] init];
            for (int i = 0; i < atribute.count; i++) {
                if ([strFinalAttribute length] > 0) {
                    strFinalAttribute = [NSString stringWithFormat:@"%@\n%@",strFinalAttribute,[atribute objectAtIndex:i]];
                } else {
                    strFinalAttribute = [NSString stringWithFormat:@"%@",[atribute objectAtIndex:i]];
                }
            }
            
            for (int i = 0; i < noOfYes.count; i++) {
                if ([strFinaNoOfYes length] > 0) {
                    strFinaNoOfYes = [NSString stringWithFormat:@"%@\n%@",strFinaNoOfYes,[noOfYes objectAtIndex:i]];
                } else {
                    strFinaNoOfYes = [NSString stringWithFormat:@"%@",[noOfYes objectAtIndex:i]];
                }
            }

            for (int i = 0; i < noOfNo.count; i++) {
                if ([strFinalNoOfNo length] > 0) {
                    strFinalNoOfNo = [NSString stringWithFormat:@"%@\n%@",strFinalNoOfNo,[noOfNo objectAtIndex:i]];
                } else {
                    strFinalNoOfNo = [NSString stringWithFormat:@"%@",[noOfNo objectAtIndex:i]];
                }
            }

            lblAttribute.text = strFinalAttribute;
            lblNoofYes.text = strFinaNoOfYes;
            lbNoOfNo.text = strFinalNoOfNo;
        }
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"Error: %@", error);
        NSLog(@"operation %@ " , operation);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) buttontouch:(id)sender
{
    ShowFeedback *viewPapChat = [[ShowFeedback alloc] initWithNibName:@"ShowFeedback" bundle:nil];
    NSLog(@"Error: %@", _strMessageId);
    viewPapChat.strMessageId = _strMessageId;
    [[self navigationController] pushViewController:viewPapChat animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
