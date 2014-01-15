//
//  ViewController.h
//  diet
//
//  Created by kikukawa haruki on 13/11/05.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface Graphdraw : UIViewController
<CPTPieChartDataSource,CPTPieChartDelegate>
{
@private
    // グラフ表示領域（この領域に棒グラフを追加する）
    CPTGraph *graph;
}

@property(nonatomic, strong) NSMutableArray *dataForBar;        // 棒グラフ用
@property(nonatomic, strong) NSMutableArray *dataForScatter;    // 折れ線グラフ用

@end
