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

@synthesize seekField;
@synthesize seekResult;


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
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    
    NSLog(@"%@",paths);
    NSString *dir = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"diet.db"]])
    {
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"diet.db"]];
        
        [db open]; //DB開く
        
        FMResultSet *result = [db executeQuery:@"select id,calorie_title from calorie_data"];


        NSMutableArray *data= [[NSMutableArray alloc] init];


        while ([result next]) {
            int result_id = [result intForColumn:@"id"];
            NSString *result_title = [result stringForColumn:@"calorie_title"];
            [data addObject:result_title];
            NSLog(@"recode id[%d], title[%@]",result_id, result_title);
        }
        
        NSLog(@"%@", data);

        NSLog(@"count = %d",[data count]);

        
        // 値は取得できたから、あとは、テーブルへの格納！


        

        
        NSLog(@"Error %@ - %d", [db lastErrorMessage], [db lastErrorCode]);
        [db close];
    }
    
}
@end
