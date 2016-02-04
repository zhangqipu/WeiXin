//
//  ChatViewController.h
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/6.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QPInputToolBar.h"
#import "QPChatDefines.h"

#import "QPEmotionView.h"
#import "QPExtendMenuView.h"

@interface ChatViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, QPInputToolBarDelegate, QPEmotionViewDelegate>

@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) NSMutableArray   *messages;
@property (nonatomic, strong) QPInputToolBar   *inputToolBar;
@property (nonatomic, strong) QPEmotionView    *emotionView;
@property (nonatomic, strong) QPExtendMenuView *extendMenuView;

@end
