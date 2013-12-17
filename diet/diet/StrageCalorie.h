//
//  StrageCalorie.h
//  diet
//
//  Created by Miwa Oshiro on 2013/12/17.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrageCalorie : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *calorieTitle;
@property (strong, nonatomic) IBOutlet UITextField *calorieCal;
@property (strong, nonatomic) IBOutlet UITextField *calorieNum;

- (IBAction)calorieSave:(id)sender;

@end
