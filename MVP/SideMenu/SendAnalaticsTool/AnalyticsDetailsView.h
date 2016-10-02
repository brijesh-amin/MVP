//
//  AnalyticsDetailsView.h
//  MVP
//
//  Created by Darshan on 19/05/16.
//  Copyright © 2016 Darshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChartDelegate.h"
#import "PNLineChart.h"
#import "PNChart.h"

@interface AnalyticsDetailsView : UIViewController<PNChartDelegate>

{
    IBOutlet UISegmentedControl *segmentControlle;
}

@property (nonatomic) PNBarChart * barChart;
@property (nonatomic) PNPieChart *pieChart;
@property (nonatomic) PNLineChart * lineChart;

@end
