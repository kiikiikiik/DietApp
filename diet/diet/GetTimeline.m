//
//  GetTimeline.m
//  diet
//
//  Created by Miwa Oshiro on 2014/01/14.
//  Copyright (c) 2014年 kikukawa haruki. All rights reserved.
//

#import "GetTimeline.h"
#import "FirstViewController.h"

@interface GetTimeline ()

@end

@implementation GetTimeline{
    NSArray *tweets;
//    IBOutlet UITableView *table;
}

@synthesize table = _table;


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
    [self getTimeline];
}


- (void)getTimeline {
    
    //Twitter APIのURLを準備
    //今回は「statuses/home_timeline.json」を利用
    NSString *apiURL = @"https://api.twitter.com/1.1/statuses/home_timeline.json";
    
    //iOS内に保存されているTwitterのアカウント情報を取得
    ACAccountStore *store = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType =
    [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    //ユーザーにTwitterの認証情報を使うことを確認
    [store requestAccessToAccountsWithType:twitterAccountType
                                   options:nil
                                completion:^(BOOL granted, NSError *error) {
                                    //ユーザーが拒否した場合
                                    if (!granted) {
                                        NSLog(@"Twitterへの認証が拒否されました。");
                                        [self alertAccountProblem];
                                        //ユーザーの了解が取れた場合
                                    } else {
                                        //デバイスに保存されているTwitterのアカウント情報をすべて取得
                                        NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];
                                        //Twitterのアカウントが1つ以上登録されている場合
                                        if ([twitterAccounts count] > 0) {
                                            //0番目のアカウントを使用
                                            ACAccount *account = [twitterAccounts objectAtIndex:0];
                                            //認証が必要な要求に関する設定
                                            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                                            [params setObject:@"1" forKey:@"include_entities"];
                                            //リクエストを生成
                                            NSURL *url = [NSURL URLWithString:apiURL];
                                            SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                                  
                                                                                    requestMethod:SLRequestMethodGET
                                                                  
                                                                                              URL:url parameters:params];
                                            
                                            //リクエストに認証情報を付加
                                            [request setAccount:account];
                                            //ステータスバーのActivity Indicatorを開始
                                            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                                            
                                            //リクエストを発行
                                            [request performRequestWithHandler:^(
                                                                                 NSData *responseData,
                                                                                 NSHTTPURLResponse *urlResponse,
                                                                                 NSError *error) {
                                                
                                                //Twitterからの応答がなかった場合
                                                if (!responseData) {
                                                    // inspect the contents of error
                                                    NSLog(@"response error: %@", error);
                                                    //Twitterからの返答があった場合
                                                } else {
                                                    //JSONの配列を解析し、TweetをNSArrayの配列に入れる
                                                    NSError *jsonError;
                                                    tweets = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                             options: NSJSONReadingMutableLeaves error:&jsonError];
                                                    
                                                    //Tweet取得完了に伴い、Table Viewを更新
                                                    [self refreshTableOnFront];
                                                }
                                            }];
                                        } else {
                                            [self alertAccountProblem];
                                        }
                                    }
                                }];
}


-(void)alertAccountProblem {
    
    // メインスレッドで表示させる
    dispatch_async(dispatch_get_main_queue(), ^{
        //メッセージを表示
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Twitterアカウント"
                              message:@"アカウントに問題があります。今すぐ「設定」でアカウント情報を確認してください"
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"はい",
                              nil
                              ];
        [alert show];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Table Viewのセルの数を指定
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tweets count];
}

//各セルにタイトルをセット
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //セルのスタイルを標準のものに指定
    static NSString *CellIdentifier = @"TweetCell";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //カスタムセル上のラベル
    UILabel *tweetLabel = (UILabel*)[cell viewWithTag:1];
    UILabel *userLabel = (UILabel*)[cell viewWithTag:2];
    
    //セルに表示するtweetのJSONを解析し、NSDictionaryに
    NSDictionary *tweetMessage = [tweets objectAtIndex:[indexPath row]];
    
    //ユーザ情報を格納するJSONを解析し、NSDictionaryに
    NSDictionary *userInfo = [tweetMessage objectForKey:@"user"];
    
    //セルにTweetの内容とユーザー名を表示
    tweetLabel.text = [tweetMessage objectForKey:@"text"];
    userLabel.text = [userInfo objectForKey:@"screen_name"];
    
    return cell;
}

- (void) refreshTableOnFront {
    
    [self performSelectorOnMainThread:@selector(refreshTable) withObject:self waitUntilDone:TRUE];
    
}


//テーブルの内容をセット
- (void)refreshTable {
    //ステータスバーのActivity Indicatorを停止
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //最新の内容にテーブルをセット
    [_table reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //セルにされているtweetのJSONを解析し、NSDictionaryに
    NSDictionary *tweetMessage = [tweets objectAtIndex:[indexPath row]];
    
    //ユーザ情報を格納するJSONを解析し、NSDictionaryに
    NSDictionary *userInfo = [tweetMessage objectForKey:@"user"];
    
    //メッセージを表示
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = [userInfo objectForKey:@"screen_name"];
    alert.message = [tweetMessage objectForKey:@"text"];
    alert.delegate = self;
    [alert addButtonWithTitle:@"OK"];
    [alert show];
}

- (IBAction)sendEasyTweet:(id)sender {
    
    
    
    //SLComposeViewControllerのインスタンス生成
    
    SLComposeViewController *tweetViewController =
    
    [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    
    //Tweet投稿完了時・キャンセル時に呼ばれる処理
    
    [tweetViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
        
        switch (result) {
                
            case SLComposeViewControllerResultCancelled:
                
                NSLog(@"キャンセル");
                
                break;
                
            case SLComposeViewControllerResultDone:
                
                NSLog(@"Tweet投稿成功");
                
                break;
                
            default:
                
                break;
                
        }
        
        //Tweet画面を閉じる
        
        [self dismissViewControllerAnimated:YES  completion:nil];
        
    }];
    
    
    
    //Tweet画面を起動
    
    [self presentViewController:tweetViewController animated:YES completion:nil];
    
}

-(IBAction)refreshTimeline:(id)sender {
    
    [self getTimeline];
    
}



@end