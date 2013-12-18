//
//  SnsViewController.m
//  diet
//
//  Created by Miwa Oshiro on 2013/12/17.
//  Copyright (c) 2013年 kikukawa haruki. All rights reserved.
//

#import "SnsViewController.h"
#import "AFNetworking.h"

@interface SnsViewController ()

@end

@implementation SnsViewController

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


#pragma mark - 自作関数

//デリゲートなどの初期設定
- (void)initialize
{
    
    //TableViewの初期設定
    self.tableViewTextList.dataSource = self.tableViewTextList;
    self.tableViewTextList.delegate = self.tableViewTextList;
    
    //UITextFieldの初期設定
//    self.txtInputName.delegate = self;
    [self.txtInputName becomeFirstResponder];
    self.txtInputName.placeholder = @"登録したい名前を入力してね";
    
}

//サーバーのあるURLの設定
#define TOPURL @"http://localhost:3000"


- (IBAction)postData:(id)sender {
    //名前が空だと登録させない
    if ([self.txtInputName.text isEqualToString:@""]) {
        return;
    }
    
    //HTTP通信クライアントの作製
    static AFHTTPClient *sharedCliant = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedCliant = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:TOPURL]];
    });
    
    NSString *path = [NSString stringWithFormat:@"tops.json"];//パスの指定
    NSDictionary *params = @{@"top[name]":self.txtInputName.text};//テキストデータのセット
    
    
    [sharedCliant setParameterEncoding:AFFormURLParameterEncoding];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[sharedCliant requestWithMethod:@"POST"
                                                                                                                           path:path
                                                                                                                     parameters:params
                                                                                                 ]
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            
                                                                                            //通信が成功したときの処理
                                                                                            NSLog(@"JSON: %@", JSON);
                                                                                            
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error, id JSON){
                                                                                            
                                                                                            //通信が失敗した時の処理
                                                                                            NSLog(@"error: %@", error);
                                                                                            
                                                                                        }];
    
    [sharedCliant enqueueHTTPRequestOperation:operation];//通信開始
    
    
    
}

- (IBAction)getData:(id)sender {
    
    static AFHTTPClient *sharedCliant = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedCliant = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:TOPURL]];
    });
    
    NSString *path = [NSString stringWithFormat:@"tops.json"];
    [sharedCliant setParameterEncoding:AFJSONParameterEncoding];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[sharedCliant requestWithMethod:@"GET" path:path parameters:nil]
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
                                                                                            
                                                                                            //データの取得に成功した時の処理
                                                                                            NSLog(@"JSON: %@", JSON);
                                                                                            
                                                                                            //取得したJSONデータを配列に格納
                                                                                            NSMutableArray *names = [NSMutableArray array];
                                                                                            for (NSDictionary *jsonObject in JSON) {
                                                                                                
                                                                                                [names addObject:[jsonObject objectForKey:@"name"]];
                                                                                                
                                                                                            }
                                                                                            
                                                                                            //テーブルビューに配列の中身をセットして更新
                                                                                            self.tableViewTextList.nameList = names;
                                                                                            [self.tableViewTextList reloadData];
                                                                                            
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error, id JSON){
                                                                                            
                                                                                            //データの取得に失敗した時の処理
                                                                                            NSLog(@"error: %@", error);
                                                                                        }];
    
    [sharedCliant enqueueHTTPRequestOperation:operation];
}




@end
