//
//  Goal.m
//  diet
//
//  Created by kikukawa haruki on 2013/12/10.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import "Goal.h"

@interface Goal ()

@end

@implementation Goal

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)push_enter:(id)sender {
    NSUserDefaults *weight = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *period = [NSUserDefaults standardUserDefaults];
    [weight setObject:self.input_weight.text forKey:@"my_weight"];
    [period setObject:self.input_period.text forKey:@"my_period"];
    int w = [weight integerForKey:@"my_weight"];
    int p = [period integerForKey:@"my_period"];
    NSLog(@"体重は%d",w);
    NSLog(@"期間は%d",p);
}

- (IBAction)hogehoge:(id)sender {
}
@end
