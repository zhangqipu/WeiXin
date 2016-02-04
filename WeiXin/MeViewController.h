//
//  MeViewController.h
//  WeiXin
//
//  Created by zhangqipu on 15/4/26.
//  Copyright (c) 2015年 zhangqipu. All rights reserved.
//

#import "BaseNavViewController.h"

@interface MeViewController : BaseNavViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *dataSource;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
