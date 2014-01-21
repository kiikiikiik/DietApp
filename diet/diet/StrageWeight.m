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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:self.weightNum.text forKey:@"my_weight"];
    
    float weight_nu = [self.weightNum.text floatValue];
    NSNumber *weight_num = [NSNumber numberWithFloat:weight_nu];
    
    //float weight_f = [userDefaults floatForKey:@"my_weight"];
    //NSNumber *weight_num = [NSNumber numberWithFloat:weight_f];

    
    /*
    float weight_f = [self.weightNum.text floatValue];
    NSNumber *weight_num = [NSNumber numberWithFloat:weight_f];
    */
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );

    NSLog(@"%@",paths);
    NSString *dir = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
   
    
     //NSLog(@"%f",weight_f);
    NSLog(@"%@",self.weightNum.text);
    NSLog(@"%f",weight_nu);
     NSLog(@"%@",weight_num);

    if ([fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"diet.db"]])
    {
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"diet.db"]];
        
        
        [db open]; //DB開く
        
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat  = @"yyyy-MM-dd";
        NSString *strDate = [df stringFromDate:[NSDate date]];
        
        [db executeUpdate:@"insert into weight (weiweight,date) values (?,?);",weight_num,strDate];
        
        NSLog(@"Error %@ - %d", [db lastErrorMessage], [db lastErrorCode]);
        [db close];
    }
    

    
    
}
@end
