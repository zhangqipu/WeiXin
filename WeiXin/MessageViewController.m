//
//  MessageViewController.m
//  WeiXin
//
//  Created by zhangqipu on 15/4/26.
//  Copyright (c) 2015年 zhangqipu. All rights reserved.
//

#import "MessageViewController.h"
#import "ChatViewController.h"
#import "Common.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
    
    self.dataSource = [NSMutableArray arrayWithObjects:@{@"userName":@"刘亦菲", @"userIcon":@"person", @"lastMessage":@"hello"}, @{@"userName":@"刘亦菲", @"userIcon":@"person", @"lastMessage":@"hello"}, @{@"userName":@"刘亦菲", @"userIcon":@"person", @"lastMessage":@"hello"}, @{@"userName":@"刘亦菲", @"userIcon":@"person", @"lastMessage":@"hello"}, @{@"userName":@"刘亦菲", @"userIcon":@"person", @"lastMessage":@"hello"} ,nil];
    
    self.tabBarItem.badgeValue = @"15";
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 3;
    cell.imageView.image = [UIImage imageNamed:self.dataSource[indexPath.row][@"userIcon"]];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = self.dataSource[indexPath.row][@"userName"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.text = self.dataSource[indexPath.row][@"lastMessage"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    AddRedDot(2, cell.contentView, CGPointMake(40, 10), @"3");
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatViewController *vc = [[ChatViewController alloc] init];
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

@end
