//
//  TodayWeight.m
//  diet
//
//  Created by kikukawa haruki on 2013/12/10.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import "TodayWeight.h"
#import "FMDatabase.h"

@interface TodayWeight ()

@end

@implementation TodayWeight

@synthesize weight;

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

    /*
    weight.delegate = self;
    
    //DBファイルのパス
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir   = [paths objectAtIndex:0];
    //DBファイルがあるかどうか確認
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"weight.db"]])
    {
        //なければ新規作成
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"weight.db"]];
        
        NSString *sql = @"CREATE TABLE weight (id INTEGER PRIMARY KEY AUTOINCREMENT,weight TEXT,date TEXT);";
        
        [db open]; //DB開く
        [db executeUpdate:sql]; //SQL実行
        [db close];
    }
     */
}

/*
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
 */


- (IBAction)weightSave:(id)sender {

    float weight_f = [self.weight.text floatValue];
    NSNumber *weight_num = [NSNumber numberWithFloat:weight_f];
    

    /*
    // UserDefaults に TextFieldの値を保存
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:self.weight.text forKey:@"my_weight"];
    
    
    float weight_f = [userDefaults floatForKey:@"my_weight"];
    NSNumber *weight_num = [NSNumber numberWithFloat:weight_f];
     */
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir   = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"weight.db"]])
    {
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"weight.db"]];
        
        [db open]; //DB開く
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat  = @"yyyy-MM-dd HH:mm:ss";
        NSString *strDate = [df stringFromDate:[NSDate date]];
        
        [db executeUpdate:@"insert into weight (weight,date) values (?,?);",weight_num,strDate];
        
        NSLog(@"Error %@ - %d", [db lastErrorMessage], [db lastErrorCode]);
        [db close];
    }

}
@end
