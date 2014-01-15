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
    [self initialize];
}

- (void)initialize
{
    self.seekResult.dataSource = self.seekResult;
    self.seekResult.delegate = self.seekResult;
    
    [self.seekField becomeFirstResponder];
    self.seekField.placeholder = @"検索したいタイトルを入力";
}


- (IBAction)seekButton:(id)sender {
    
    if ([self.seekField.text isEqualToString:@""]) {
        return;
    }


    // db内を曖昧検索するための形をここで作っている。
    // seekFieldに入力した文字列
    NSString *title = self.seekField.text;
    NSString *a = @"%";
    NSString *str = [NSString stringWithFormat:@"%@%@%@",a,title,a];
    NSLog(@"%@",str);
    

    // db先のパス
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSLog(@"%@",paths);

    NSString *dir = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"diet.db"]])
    {
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"diet.db"]];
        
        [db open];

        // DB内検索(ここでstrを使用している)
        FMResultSet *result = [db executeQuery:@"select * from calorie_data where calorie_title like ?",str];


        int calocalo = 0;
        NSMutableArray *data= [[NSMutableArray alloc] init];

        // DB内の値取得
        while ([result next]) {
            // int result_id = [result intForColumn:@"id"];
            NSString *cal_title = [result stringForColumn:@"calorie_title"];
            int cal_cal = [result intForColumn:@"calorie_cal"];
            int cal_num = [result intForColumn:@"calorie_num"];
            calocalo = cal_cal;
            
            NSString *result = [NSString stringWithFormat:@"title = %@ cal = %d num = %d",cal_title,cal_cal,cal_num];
            [data addObject:result];
        }
        
        NSNumber *calocalo2= [[NSNumber alloc] initWithInt:calocalo];
        
        NSLog(@"%@", data);
        NSLog(@"count = %d",[data count]);
        
        // テーブルへの格納
        self.seekResult.nameList = data;
        [self.seekResult reloadData];
        
        //
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat  = @"yyyy-MM-dd HH:mm:ss";
        NSString *strDate = [df stringFromDate:[NSDate date]];
        
        //NSLog(@"insert into calorieplus (calplus,date) values (%d,%@);",calocalo,strDate);
        [db executeUpdate:@"insert into calorieplus (calplus,date) values (?,?);",calocalo2,strDate];
        
        
        //
        
        
        NSLog(@"Error %@ - %d", [db lastErrorMessage], [db lastErrorCode]);
        [db close];
        

    }
    
}



/* 呼び出される側のメソッド */
- (void)likeButtonPressed:(id)sender{
    UIButton *button = (UIButton *)sender;
    UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
    int row = [self.seekResult indexPathForCell:cell].row;
    UIAlertView *ar = [[UIAlertView alloc] initWithTitle:@"Like?"
                                                 message:[NSString stringWithFormat:@"%d行目のボタンが押されました", row]
                                                delegate:self
                                       cancelButtonTitle:@"YES"
                                       otherButtonTitles:@"NO",nil];
    [ar show];
}




@end
