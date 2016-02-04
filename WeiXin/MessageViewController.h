//
//  MessageViewController.h
//  WeiXin
//
//  Created by zhangqipu on 15/4/26.
//  Copyright (c) 2015年 zhangqipu. All rights reserved.
//

#import "BaseNavViewController.h"

@interface MessageViewController : BaseNavViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end
