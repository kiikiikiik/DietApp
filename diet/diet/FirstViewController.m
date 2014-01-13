//
//  FirstViewController.m
//  diet
//
//  Created by Miwa Oshiro on 2014/01/14.
//  Copyright (c) 2014年 kikukawa haruki. All rights reserved.
//

#import "FirstViewController.h"
#import "GetTimeline.h"

@interface FirstViewController ()

@end



@implementation FirstViewController{
    IBOutlet UITableView *hoge;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//フロント側でテーブルを更新

- (void) refreshTableOnFront {
    
    [self performSelectorOnMainThread:@selector(refreshTable) withObject:self waitUntilDone:TRUE];
    
}


//テーブルの内容をセット

- (void)refreshTable {
    
    //ステータスバーのActivity Indicatorを停止
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    //最新の内容にテーブルをセット
    [hoge reloadData];

}

@end
