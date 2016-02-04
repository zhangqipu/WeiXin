//
//  QPChatStateMachine.h
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/11.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatViewController.h"
#import "QPInputToolBar.h"

typedef NS_ENUM(NSUInteger, QPChatInputState) {
    QPChatInputStateBottomTextInput,          // 文字输入框在底部状态
    QPChatInputStateBottomVoiceInput,         // 语言输入状态状态
    QPChatInputStateKeyboardUpTextInput,      // 键盘抬起文字输入状态
    QPChatInputStateEmotionInput,             // 表情输入状态
    QPChatInputStateExtendMenu                // 扩展菜单状态
};

@interface QPChatStateMachine : NSObject

@property (nonatomic, assign) ChatViewController *chatController;

- (instancetype)initWithChatController:(ChatViewController *)chatController;

- (void)changeToState:(QPChatInputState)targetState;

@end
