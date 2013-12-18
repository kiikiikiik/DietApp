//
//  StrageCalorie.m
//  diet
//
//  Created by Miwa Oshiro on 2013/12/17.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import "StrageCalorie.h"
#import "FMDatabase.h"

@interface StrageCalorie ()

@end

@implementation StrageCalorie

@synthesize calorieTitle;
@synthesize calorieCal;
@synthesize calorieNum;

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
//    calorieTitle.delegate = self;
}


- (IBAction)calorieSave:(id)sender {
    
    NSString *calorie_title = self.calorieTitle.text;
    
    float calorie_cal_f = [self.calorieCal.text floatValue];
    NSNumber *calorie_cal = [NSNumber numberWithFloat:calorie_cal_f];
    
    float calorie_num_f = [self.calorieNum.text floatValue];
    NSNumber *calorie_num = [NSNumber numberWithFloat:calorie_num_f];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSLog(@"%@",paths);
    NSString *dir   = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    
    
    if ([fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"diet.db"]])
    {
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"diet.db"]];
        
        [db open]; //DB開く
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat  = @"yyyy-MM-dd HH:mm:ss";
        NSString *strDate = [df stringFromDate:[NSDate date]];
        
        [db executeUpdate:@"insert into calorie_data (calorie_title,calorie_cal,calorie_num,date) values (?,?,?,?);",calorie_title,calorie_cal,calorie_num,strDate];
        
        NSLog(@"Error %@ - %d", [db lastErrorMessage], [db lastErrorCode]);
        [db close];
    }
    

}
@end
