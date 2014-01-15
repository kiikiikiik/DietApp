//
//  GetTimeline.h
//  diet
//
//  Created by Miwa Oshiro on 2014/01/14.
//  Copyright (c) 2014年 kikukawa haruki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface GetTimeline : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    UITableView *_table;
}


- (IBAction)refreshTimeline:(id)sender;
- (IBAction)sendEasyTweet:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *table;

@end
