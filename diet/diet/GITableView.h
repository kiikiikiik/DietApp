//
//  GITableView.h
//  diet
//
//  Created by Miwa Oshiro on 2013/12/17.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GITableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain)NSArray *nameList;

@end
