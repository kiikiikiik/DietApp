//
//  StrageExercise.m
//  diet
//
//  Created by Miwa Oshiro on 2013/12/17.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import "StrageExercise.h"
#import "FMDatabase.h"

@interface StrageExercise ()

@end

@implementation StrageExercise

@synthesize exerciseTitle;
@synthesize exerciseCal;
@synthesize exerciseNum;

sqlite3* db;

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
}

- (IBAction)excerciseSave:(id)sender {

    NSString *exercise_title = self.exerciseTitle.text;
    
    float exercise_cal_f = [self.exerciseCal.text floatValue];
    NSNumber *exercise_cal = [NSNumber numberWithFloat:exercise_cal_f];
    
    float exercise_num_f = [self.exerciseNum.text floatValue];
    NSNumber *exercise_num = [NSNumber numberWithFloat:exercise_num_f];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir   = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    
    
    if ([fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"diet.db"]])
    {
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"diet.db"]];
        
        [db open]; //DB開く
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat  = @"yyyy-MM-dd HH:mm:ss";
        NSString *strDate = [df stringFromDate:[NSDate date]];
        
        [db executeUpdate:@"insert into exercise_data (exercise_title,exercise_cal,exercise_num,date) values (?,?,?,?);",exercise_title,exercise_cal,exercise_num,strDate];
        
        NSLog(@"Error %@ - %d", [db lastErrorMessage], [db lastErrorCode]);
        [db close];
    }
    

    
}
@end
