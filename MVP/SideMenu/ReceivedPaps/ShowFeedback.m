//
//  ShowFeedback.m
//  MVP
//
//  Created by Bhavik Panchal on 7/29/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "ShowFeedback.h"
#import "StaticClass.h"
#import "AppDelegate.h"
#import "feedbackAttri.h"
@interface ShowFeedback ()
{
    NSArray *atribute;
    NSArray *noOfYes;
    NSArray *noOfNo;
    NSMutableArray *nameArr;
    NSMutableArray *feedbackArr;
    
    
}
@end

@implementation ShowFeedback
int segSelIndex = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"Analytic Feedback" fontSize:18];
    tvListData.dataSource = self;
    tvListData.delegate = self;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setObject:_strMessageId forKey:@"msg_id"];
    NSLog(@"msgId = %@",_strMessageId);
    [SHARED_APPDELEGATE showLoadingView];
    
    [manager POST:feedBackData_Url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SHARED_APPDELEGATE hideLoadingView];
        NSLog(@"ResponceLogin %@",responseObject);
        
        NSMutableDictionary *dicDetail = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
        
        NSArray *feedArr = [dicDetail objectForKey:@"feedback"];
        nameArr = [[NSMutableArray alloc] init];
        feedbackArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < feedArr.count; i++) {
            NSDictionary *innerDic = feedArr[i];
            
            [nameArr addObject:[innerDic objectForKey:@"name"]];
            [feedbackArr addObject:[innerDic objectForKey:@"feedbackdata"]];
            
            
        }
        
        if ([[dicDetail objectForKey:@"attribute"] length] > 0)
        {
            
            atribute = [[dicDetail objectForKey:@"attribute"] componentsSeparatedByString:@","];
            noOfYes = [[dicDetail objectForKey:@"totalyescount"] componentsSeparatedByString:@","];
            noOfNo = [[dicDetail objectForKey:@"totalnocount"] componentsSeparatedByString:@","];

            /*NSString *strFinalAttribute = [[NSString alloc] init];
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
*/
            //lblAttribute.text = strFinalAttribute;
            //lblNoofYes.text = strFinaNoOfYes;
            //lbNoOfNo.text = strFinalNoOfNo;
            
            [self addSegment];
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

-(void)addSegment
{
    NSLog(@"AttriArray = %@",atribute);
    
    HMSegmentedControl *segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles:atribute];
    segmentedControl1.frame = CGRectMake(0, 0, self.view.frame.size.width, 40) ;
    //HMSegmentedControl *segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Navratri", @"Diwali", @"X-mas", @"New Year", @"Utarayan", @"Holi", @"Rakshabandhan", @"Janmastami"]];
    segmentedControl1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    
    segmentedControl1.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 20);
    segmentedControl1.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl1.verticalDividerEnabled = NO;
    segmentedControl1.verticalDividerColor = [UIColor blackColor];
    segmentedControl1.verticalDividerWidth = 0.5f;
    [segmentedControl1 setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index , BOOL selected)
     {
         if (index == 0)
         {
             NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:1.0f]}];
             
             if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
             {
                 /* run something specific for the iPad */
                 [attString addAttribute:NSFontAttributeName
                                   value:[UIFont systemFontOfSize:20.0] range:NSMakeRange(0, title.length)
                  ];
             }
             return attString;
         }
         else
         {
             NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
             
             if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
             {
                 /* run something specific for the iPad */
                 [attString addAttribute:NSFontAttributeName
                                   value:[UIFont systemFontOfSize:20.0] range:NSMakeRange(0, title.length)
                  ];
             }
             return attString;
         }
         
     }];
    
    
    
    segmentedControl1.backgroundColor = [UIColor whiteColor];
    [segmentedControl1 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [segView addSubview:segmentedControl1];
    
    [tvListData reloadData];
}


    
    
    - (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl
    {
        NSUInteger myval =  (long)segmentedControl.selectedSegmentIndex;
        [segmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
            
            //selectedCat = title;
            
            // NSLog(@"Cat = %@",selectedCat);
            
            //[self DisplayData];
            int kvalue = (int)segmentedControl.selectedSegmentIndex;
            NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
            if (index == myval) {
                // catName = title;
                NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:1.0f]}];
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    //run something specific for the iPad
                    [attString addAttribute:NSFontAttributeName
                                      value:[UIFont systemFontOfSize:20.0] range:NSMakeRange(0, title.length)
                     ];
                }
                return attString;
            }
            else
            {
                NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    // run something specific for the iPad
                    [attString addAttribute:NSFontAttributeName
                                      value:[UIFont systemFontOfSize:20.0] range:NSMakeRange(0, title.length)
                     ];
                }
                return attString;
            }
            
        }];
        
        //[tvEventList reloadData];
        int kvalue = (int)segmentedControl.selectedSegmentIndex;
        NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
        
        segSelIndex = kvalue ;
        [tvListData reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [nameArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdenti = @"ChatImageCell";
    
    feedbackAttri *cell = (feedbackAttri *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdenti];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"feedbackAttri" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell.lblyesno.text = @"no";
    
    cell.lblname.text = nameArr[indexPath.row];
    NSArray *innerArr = [feedbackArr[indexPath.row] componentsSeparatedByString:@","];
    
    for (int i = 0; i < innerArr.count; i++) {
        int innerVal = [innerArr[i] intValue];
        
        if (segSelIndex == i) {
            if (innerVal == 1) {
                cell.lblyesno.text = @"yes";
            }
        }
    }
    return cell;
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
