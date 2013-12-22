//
//  CalorieSeek.m
//  diet
//
//  Created by Miwa Oshiro on 2013/12/22.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import "CalorieSeek.h"
#import "FMDatabase.h"


@interface CalorieSeek ()

@end

@implementation CalorieSeek


NSURL *dirPath;
FMDatabase *db;
NSURL *dbPath;




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



- (IBAction)seekButton:(id)sender {
}
@end
