//
//  MainTabViewController.m
//  WeiXin
//
//  Created by zhangqipu on 15/4/26.
//  Copyright (c) 2015年 zhangqipu. All rights reserved.
//

#import "MainTabViewController.h"

@interface MainTabViewController ()
{
    NSArray *_itemImageArray;
}

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tabBar setTintColor:[UIColor colorWithRed:0.27 green:0.75 blue:0.1 alpha:1]];
    [self initItemIconArray];
    
    int idx = 0;
    for (UIViewController *vc in self.viewControllers)
    {
        [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:_itemImageArray[idx++]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
}

- (void)initItemIconArray
{
    _itemImageArray = @[@"tab_message_h", @"tab_phone_book_h", @"tab_find_h", @"tab_me_h"];
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

@end
