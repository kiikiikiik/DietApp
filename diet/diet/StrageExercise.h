//
//  StrageExercise.h
//  diet
//
//  Created by Miwa Oshiro on 2013/12/17.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrageExercise : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *exerciseTitle;
@property (strong, nonatomic) IBOutlet UITextField *exerciseCal;
@property (strong, nonatomic) IBOutlet UITextField *exerciseNum;

- (IBAction)excerciseSave:(id)sender;

@end
