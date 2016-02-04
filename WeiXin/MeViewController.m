//
//  MeViewController.m
//  WeiXin
//
//  Created by zhangqipu on 15/4/26.
//  Copyright (c) 2015年 zhangqipu. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initDataSource];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)initDataSource
{
    // --------- dataSource ------
    // NSArray
    
    // --------- group -------
    // NSArray
    
    // --------- cell -----------
    // keyIcon - value
    // keyName - value
    
    self.dataSource
    = @[@[@{@"iconKey":@"", @"titleKey":@"陈云"}]
        , @[@{@"iconKey":@"photo_library", @"titleKey":@"相册"}, @{@"iconKey":@"like", @"titleKey":@"收藏"},
            @{@"iconKey":@"pocket", @"titleKey":@"钱包"}]
        , @[@{@"iconKey":@"expression", @"titleKey":@"表情"}]
        , @[@{@"iconKey":@"setting", @"titleKey":@"设置"}]
        ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [self configCell:cell withIndexPath:indexPath];
    
    return cell;
}

- (void)configCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    cell.imageView.image = [UIImage imageNamed:self.dataSource[indexPath.section][indexPath.row][@"iconKey"]];
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row][@"titleKey"];
}

@end
