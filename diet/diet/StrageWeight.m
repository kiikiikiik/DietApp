//
//  StrageWeight.m
//  diet
//
//  Created by Miwa Oshiro on 2013/12/17.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import "StrageWeight.h"
#import "FMDatabase.h"

@interface StrageWeight ()

@end

@implementation StrageWeight

@synthesize weightNum;
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

- (IBAction)weightSave:(id)sender {
    
    
    float weight_f = [self.weightNum.text floatValue];
    NSNumber *weight_num = [NSNumber numberWithFloat:weight_f];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );

    NSLog(@"%@",paths);
    NSString *dir = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"diet.db"]])
    {
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"diet.db"]];
        
        [db open]; //DB開く
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat  = @"yyyy-MM-dd";
        NSString *strDate = [df stringFromDate:[NSDate date]];
        NSNumber *past_weight;
        NSNumber *diff_weight;

        int c_weight;
        int p_weight;
        int d_weight=0;


        FMResultSet *results = [db executeQuery:@"select * from calorieplus order by id desc limit 1;"];

        while ([results next]) {
            NSDictionary *dic = [results resultDictionary];

            past_weight = [dic objectForKey:@"calplus"];
            p_weight = [past_weight intValue];
            c_weight = [weight_num intValue];
            d_weight = c_weight - p_weight;
            
            NSLog(@"%d",d_weight);
            
        }
        
        diff_weight = [NSNumber numberWithInteger:d_weight];

        
        [db executeUpdate:@"insert into calorieplus (calplus,date,diff_weight) values (?,?,?);",weight_num,strDate,diff_weight];

        
        NSLog(@"Error %@ - %d", [db lastErrorMessage], [db lastErrorCode]);
        [db close];
    }
    
}
@end
