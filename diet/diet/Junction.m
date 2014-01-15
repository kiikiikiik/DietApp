//
//  Junction.m
//  diet
//
//  Created by kikukawa haruki on 2013/12/10.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import "Junction.h"
#import "FMDatabase.h"

sqlite3* db;

@interface Junction ()

@end

@implementation Junction

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

    [self createDB];
}

- (void)createDB{
    
    //DBファイルのパス
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir   = [paths objectAtIndex:0];
    
    //DBファイルがあるかどうか確認
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"diet.db"]])
    {
        //なければ新規作成
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"diet.db"]];
        
        NSString *createCalorieDataTable = @"CREATE TABLE calorie_data (id INTEGER PRIMARY KEY AUTOINCREMENT,calorie_title TEXT,calorie_cal INTEGER,calorie_num INTEGER,date TEXT);";
        NSString *createExerciseDataTable = @"CREATE TABLE exercise_data (id INTEGER PRIMARY KEY AUTOINCREMENT,exercise_title TEXT,exercise_cal INTEGER,exercise_num INTEGER,date TEXT);";
        NSString *createCalorieplusDataTable = @"CREATE TABLE calorieplus (id INTEGER PRIMARY KEY AUTOINCREMENT,calplus INTEGER,date TEXT);";

        
        [db open]; //DB開く
        [db executeUpdate:createCalorieDataTable]; //SQL実行
        [db executeUpdate:createExerciseDataTable]; //SQL実行
        [db executeUpdate:createCalorieplusDataTable];
        [db close];
    }
    
}


@end
