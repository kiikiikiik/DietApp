//
//  Goal.h
//  diet
//
//  Created by kikukawa haruki on 2013/12/10.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Goal : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *input_weight;
@property (weak, nonatomic) IBOutlet UITextField *input_period;
@property (weak, nonatomic) IBOutlet UIButton *enter;
- (IBAction)push_enter:(id)sender;
- (IBAction)end_input_weight:(id)sender;
- (IBAction)end_input_height:(id)sender;



@end
