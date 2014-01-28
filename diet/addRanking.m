//
//  addRanking.m
//  diet
//
//  Created by Miwa Oshiro on 2014/01/28.
//  Copyright (c) 2014年 kikukawa haruki. All rights reserved.
//

#import "addRanking.h"
#import "AFNetworking.h"

@interface addRanking ()

@end

@implementation addRanking

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

#define TOPURL @"http://localhost:3000"

- (IBAction)ranking_submit:(id)sender {
    
    static AFHTTPClient *sharedCliant = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedCliant = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:TOPURL]];
    });

    NSString *path = [NSString stringWithFormat:@"ranking.json"];//パスの指定

    NSNumber *aaa = @11;


//    NSDictionary *params = @{@"ranking[twitter_name]": @"99", @"ranking[weight]": aaa};

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                             aaa, @"ranking[weight]",
                             nil];

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
@end
