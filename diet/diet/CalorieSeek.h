//
//  CalorieSeek.h
//  diet
//
//  Created by Miwa Oshiro on 2013/12/22.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalorieSeek : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *seekField;
@property (strong, nonatomic) IBOutlet UITableView *seekResult;
- (IBAction)seekButton:(id)sender;

@end
