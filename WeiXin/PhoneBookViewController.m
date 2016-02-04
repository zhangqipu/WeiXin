//
//  PhoneBookViewController.m
//  WeiXin
//
//  Created by zhangqipu on 15/4/26.
//  Copyright (c) 2015年 zhangqipu. All rights reserved.
//

#import "PhoneBookViewController.h"

@interface PhoneBookViewController ()

@end

@implementation PhoneBookViewController

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
    = @[@[@{@"iconKey":@"new_friend", @"titleKey":@"新的朋友"}, @{@"iconKey":@"group_chat", @"titleKey":@"群聊"}, @{@"iconKey":@"label", @"titleKey":@"标签"}, @{@"iconKey":@"common_number", @"titleKey":@"公众号"}]
        , @[@{@"iconKey":@"person", @"titleKey":@"刘亦菲"}, @{@"iconKey":@"person", @"titleKey":@"刘亦菲"}]
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
