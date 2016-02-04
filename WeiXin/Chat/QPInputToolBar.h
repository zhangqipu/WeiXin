//
//  QPInputToolBar.h
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/8.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QPInputToolBar;

@protocol QPInputToolBarDelegate <NSObject>

// 发送文字
- (void)inputToolBarSendText:(QPInputToolBar *)inputToolBar;

// 输入文字
- (void)inputToolBarBeginTextInput:(QPInputToolBar *)inputToolBar;

// LeftItem点击
- (void)inputToolBarLeftBarButtonItemClicked:(QPInputToolBar *)inputToolBar;

// RightItem1点击
- (void)inputToolBarRightFirstBarButtonItemClicked:(QPInputToolBar *)inputToolBar;

// RightItem2点击
- (void)inputToolBarRightSecondBarButtonItemClicked:(QPInputToolBar *)inputToolBar;

@end

@interface QPInputToolBar : UIToolbar

// 左边按钮
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;

// 中间输入框和录音
@property (nonatomic, strong) UIBarButtonItem *middleBarButtonItem;

// 右边第一个按钮
@property (nonatomic, strong) UIBarButtonItem *rightFirstButtonItem;

// 右边第二个按钮
@property (nonatomic, strong) UIBarButtonItem *rightSecondButtonItem;

@property (nonatomic, assign) id <QPInputToolBarDelegate> inputToolBarDelegate;

@end

