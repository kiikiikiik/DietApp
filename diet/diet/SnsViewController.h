//
//  SnsViewController.h
//  diet
//
//  Created by Miwa Oshiro on 2013/12/17.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GITableView.h"

@interface SnsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txtInputName;


@property (strong, nonatomic) IBOutlet GITableView *tableViewTextList;


- (IBAction)postData:(id)sender;
- (IBAction)getData:(id)sender;



@end
