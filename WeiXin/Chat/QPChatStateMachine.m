//
//  QPChatStateMachine.m
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/11.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "QPChatStateMachine.h"
#import "TextVoiceInputView.h"

#define kKeyboardHeight (([UIScreen mainScreen].bounds.size.height) * 216 / 568)

@implementation QPChatStateMachine

- (instancetype)initWithChatController:(ChatViewController *)chatController
{
    if (self = [super init]) {
        self.chatController = chatController;
    }
    
    return self;
}

- (void)changeToState:(QPChatInputState)targetState
{
    CGFloat viewH                = CGRectGetHeight(self.chatController.view.frame);
    CGRect toolBarRect           = self.chatController.inputToolBar.frame;
    CGRect tableViewRect         = self.chatController.tableView.frame;
    CGRect emotionViewRect       = self.chatController.emotionView.frame;
    CGRect extendMenuViewRect    = self.chatController.extendMenuView.frame;
    
    switch (targetState) {
        case QPChatInputStateKeyboardUpTextInput: {
            
            toolBarRect        = CGRectMake(CGRectGetMinX(toolBarRect),
                                            viewH - kKeyboardHeight - CGRectGetHeight(toolBarRect),
                                            CGRectGetWidth(toolBarRect),
                                            CGRectGetHeight(toolBarRect));
            tableViewRect      = CGRectMake(CGRectGetMinX(tableViewRect),
                                            - kKeyboardHeight,
                                            CGRectGetWidth(tableViewRect),
                                            CGRectGetHeight(tableViewRect));
            emotionViewRect    = CGRectMake(CGRectGetMinX(emotionViewRect),
                                            viewH + CGRectGetHeight(emotionViewRect),
                                            CGRectGetWidth(emotionViewRect),
                                            CGRectGetHeight(emotionViewRect));
            extendMenuViewRect = CGRectMake(CGRectGetMinX(extendMenuViewRect),
                                            viewH + CGRectGetHeight(extendMenuViewRect),
                                            CGRectGetWidth(extendMenuViewRect),
                                            CGRectGetHeight(extendMenuViewRect));
            break;
        }
        case QPChatInputStateBottomTextInput: {
            
            toolBarRect        = CGRectMake(CGRectGetMinX(toolBarRect),
                                            viewH - CGRectGetHeight(toolBarRect),
                                            CGRectGetWidth(toolBarRect),
                                            CGRectGetHeight(toolBarRect));
            tableViewRect      = CGRectMake(CGRectGetMinX(tableViewRect),
                                            0,
                                            CGRectGetWidth(tableViewRect),
                                            CGRectGetHeight(tableViewRect));
            emotionViewRect    = CGRectMake(CGRectGetMinX(emotionViewRect),
                                            viewH + CGRectGetHeight(emotionViewRect),
                                            CGRectGetWidth(emotionViewRect),
                                            CGRectGetHeight(emotionViewRect));
            extendMenuViewRect = CGRectMake(CGRectGetMinX(extendMenuViewRect),
                                            viewH + CGRectGetHeight(extendMenuViewRect),
                                            CGRectGetWidth(extendMenuViewRect),
                                            CGRectGetHeight(extendMenuViewRect));
            break;
        }
        case QPChatInputStateBottomVoiceInput: {
            
            toolBarRect        = CGRectMake(CGRectGetMinX(toolBarRect),
                                            viewH - CGRectGetHeight(toolBarRect),
                                            CGRectGetWidth(toolBarRect),
                                            CGRectGetHeight(toolBarRect));
            tableViewRect      = CGRectMake(CGRectGetMinX(tableViewRect),
                                            0,
                                            CGRectGetWidth(tableViewRect),
                                            CGRectGetHeight(tableViewRect));
            emotionViewRect    = CGRectMake(CGRectGetMinX(emotionViewRect),
                                            viewH + CGRectGetHeight(emotionViewRect),
                                            CGRectGetWidth(emotionViewRect),
                                            CGRectGetHeight(emotionViewRect));
            extendMenuViewRect = CGRectMake(CGRectGetMinX(extendMenuViewRect),
                                            viewH + CGRectGetHeight(extendMenuViewRect),
                                            CGRectGetWidth(extendMenuViewRect),
                                            CGRectGetHeight(extendMenuViewRect));
            
            break;
        }
        case QPChatInputStateEmotionInput: {
            
            toolBarRect        = CGRectMake(CGRectGetMinX(toolBarRect),
                                            viewH - CGRectGetHeight(emotionViewRect)
                                            - CGRectGetHeight(toolBarRect),
                                            CGRectGetWidth(toolBarRect),
                                            CGRectGetHeight(toolBarRect));
            tableViewRect      = CGRectMake(CGRectGetMinX(tableViewRect),
                                            - CGRectGetHeight(emotionViewRect),
                                            CGRectGetWidth(tableViewRect),
                                            CGRectGetHeight(tableViewRect));
            emotionViewRect    = CGRectMake(CGRectGetMinX(emotionViewRect),
                                            viewH - CGRectGetHeight(emotionViewRect),
                                            CGRectGetWidth(emotionViewRect),
                                            CGRectGetHeight(emotionViewRect));
            extendMenuViewRect = CGRectMake(CGRectGetMinX(extendMenuViewRect),
                                            viewH + CGRectGetHeight(extendMenuViewRect),
                                            CGRectGetWidth(extendMenuViewRect),
                                            CGRectGetHeight(extendMenuViewRect));
            break;
        }
        case QPChatInputStateExtendMenu: {
            
            toolBarRect        = CGRectMake(CGRectGetMinX(toolBarRect),
                                            viewH - CGRectGetHeight(extendMenuViewRect)
                                            - CGRectGetHeight(toolBarRect),
                                            CGRectGetWidth(toolBarRect),
                                            CGRectGetHeight(toolBarRect));
            tableViewRect      = CGRectMake(CGRectGetMinX(tableViewRect),
                                            - CGRectGetHeight(extendMenuViewRect),
                                            CGRectGetWidth(tableViewRect),
                                            CGRectGetHeight(tableViewRect));
            emotionViewRect    = CGRectMake(CGRectGetMinX(emotionViewRect),
                                            viewH + CGRectGetHeight(emotionViewRect),
                                            CGRectGetWidth(emotionViewRect),
                                            CGRectGetHeight(emotionViewRect));
            extendMenuViewRect = CGRectMake(CGRectGetMinX(extendMenuViewRect),
                                            viewH - CGRectGetHeight(extendMenuViewRect),
                                            CGRectGetWidth(extendMenuViewRect),
                                            CGRectGetHeight(extendMenuViewRect));
            break;
        }
            
        default:
            break;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:7];
    
    self.chatController.tableView.frame      = tableViewRect;
    self.chatController.inputToolBar.frame   = toolBarRect;
    self.chatController.emotionView.frame    = emotionViewRect;
    self.chatController.extendMenuView.frame = extendMenuViewRect;
    
    [UIView commitAnimations];

}

@end
