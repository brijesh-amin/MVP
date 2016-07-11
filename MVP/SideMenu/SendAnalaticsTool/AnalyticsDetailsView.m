//
//  AnalyticsDetailsView.m
//  MVP
//
//  Created by Darshan on 19/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import "AnalyticsDetailsView.h"
#import "StaticClass.h"
#import "AppDelegate.h"

@interface AnalyticsDetailsView ()

@end

@implementation AnalyticsDetailsView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.titleView = [SHARED_APPDELEGATE getNavigationWithTitle:@"Analytics Details" fontSize:18];
    
    UIImage *backButtonImage = [UIImage imageNamed:@"Back"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:backButtonImage
                forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    
    [backButton addTarget:self
                   action:@selector(popViewController)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;

    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];

    segmentControlle.selectedSegmentIndex = 0;

    [self setStatisticsView];
}

#pragma mark -
#pragma mark - Pop To View Mothod

-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)onClickLoginSignupSegment:(UISegmentedControl *)sender {
    
    NSInteger selectedSegment = sender.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        [self.pieChart removeFromSuperview];
        [self.barChart removeFromSuperview];
        [self setStatisticsView];
    }else if (selectedSegment == 1){
        [self.barChart removeFromSuperview];
        [self.lineChart removeFromSuperview];
        [self setPieChartView];
    }else{
        [self.pieChart removeFromSuperview];
        [self.lineChart removeFromSuperview];
        [self setInfoChartView];
    }
}
-(void)setStatisticsView
{
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.backgroundColor = [UIColor clearColor];
    [self.lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5",@"SEP 6",@"SEP 7"]];
    self.lineChart.showCoordinateAxis = YES;
    
    // added an examle to show how yGridLines can be enabled
    // the color is set to clearColor so that the demo remains the same
//    self.lineChart.yGridLinesColor = [UIColor clearColor];
//    self.lineChart.showYGridLines = YES;
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    self.lineChart.yFixedValueMax = 300.0;
    self.lineChart.yFixedValueMin = 0.0;
    
    [self.lineChart setYLabels:@[
                                 @"0 min",
                                 @"50 min",
                                 @"100 min",
                                 @"150 min",
                                 @"200 min",
                                 @"250 min",
                                 @"300 min",
                                 ]
     ];
    
    // Line Chart #2
    NSArray * data02Array = @[@0.0, @180.1, @26.4, @202.2, @126.2, @167.2, @276.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.dataTitle = @"Beta";
    data02.color = PNTwitterColor;
    data02.alpha = 0.5f;
    data02.itemCount = data02Array.count;
    data02.inflexionPointStyle = PNLineChartPointStyleCircle;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    self.lineChart.chartData = @[data02];
    [self.lineChart strokeChart];
    self.lineChart.delegate = self;
    
    
    [self.view addSubview:self.lineChart];
    
//    self.lineChart.legendStyle = PNLegendItemStyleStacked;
//    self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
//    self.lineChart.legendFontColor = [UIColor redColor];
//    
//    UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
//    [legend setFrame:CGRectMake(30, 340, legend.frame.size.width, legend.frame.size.width)];
//    [self.view addSubview:legend];
}
-(void)setPieChartView
{
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:chartPinkColor description:@"Blue"],
                       [PNPieChartDataItem dataItemWithValue:40 color:[UIColor whiteColor] description:@"Orange"],
                       [PNPieChartDataItem dataItemWithValue:30 color:[UIColor blueColor] description:@"Pink"],
                       [PNPieChartDataItem dataItemWithValue:20 color:chartOrangeColor description:@"White"],
                       ];
    
    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2.0 - 100, 135, 200.0, 200.0) items:items];
    self.pieChart.descriptionTextColor = [UIColor blackColor];
    self.pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
    self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
    self.pieChart.showAbsoluteValues = NO;
    self.pieChart.showOnlyValues = NO;
    [self.pieChart strokeChart];
    
    
    self.pieChart.legendStyle = PNLegendItemStyleSerial;
    self.pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    
    //        UIView *legend = [self.pieChart getLegendWithMaxWidth:300];
    //        [legend setFrame:CGRectMake(60, 400, legend.frame.size.width, legend.frame.size.height)];
    //        [self.view addSubview:legend];
    
    [self.view addSubview:self.pieChart];
}
-(void)setInfoChartView
{
    static NSNumberFormatter *barChartFormatter;
    if (!barChartFormatter){
        barChartFormatter = [[NSNumberFormatter alloc] init];
        barChartFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        barChartFormatter.allowsFloats = NO;
        barChartFormatter.maximumFractionDigits = 0;
    }
    
    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(40, 135.0, SCREEN_WIDTH - 80, 200.0)];
    //        self.barChart.showLabel = NO;
    self.barChart.backgroundColor = [UIColor clearColor];
    self.barChart.yLabelFormatter = ^(CGFloat yValue){
        return [barChartFormatter stringFromNumber:[NSNumber numberWithFloat:yValue]];
    };
    
    self.barChart.yChartLabelWidth = 0.0;
    self.barChart.chartMarginLeft = 0.0;
    self.barChart.chartMarginRight = 0.0;
    self.barChart.chartMarginTop = 0.0;
    self.barChart.chartMarginBottom = 0.0;
    
    
    self.barChart.labelMarginTop = 5.0;
    self.barChart.showChartBorder = YES;
    [self.barChart setXLabels:@[@"",@"",@"",@"",@"",@""]];
    [self.barChart setYValues:@[@20,@35,@40,@66,@78,@50]];
    [self.barChart setStrokeColors:@[chartOrangeDarkColor,[UIColor redColor],[UIColor blueColor],chartOrangeLightColor,chartGreenLightColor,chartSkyColor]];
    self.barChart.isGradientShow = NO;
    self.barChart.isShowNumbers = YES;
    
    [self.barChart strokeChart];
    
    self.barChart.delegate = self;
    
    [self.view addSubview:self.barChart];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
