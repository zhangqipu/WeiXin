//
//  QPInputToolBar.m
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/8.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "QPInputToolBar.h"
#import "QPChatDefines.h"
#import "TextVoiceInputView.h"

#import <objc/runtime.h>

@implementation QPInputToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.translucent = YES;
        
        [self createContents];
    }
    
    return self;
}

- (void)createContents
{
    UIView *leftView                   = [UIView new];
    UIView *rightFirstView             = [UIView new];
    UIView *rightSecondView            = [UIView new];
    UIButton *leftButtonView           = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *rightButtonView1         = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *rightButtonView2         = [UIButton buttonWithType:UIButtonTypeCustom];
    TextVoiceInputView *inputView      = [[TextVoiceInputView alloc] initWithFrame:CGRectMake(0, 0, kTextVoiceInputViewWidth, kBarButtonItemWidth)];
    UIBarButtonItem *itemFlexibleSpace = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                          target:nil
                                          action:nil];
    
    leftView.frame         = CGRectMake(0, 0, kBarButtonItemWidth, kBarButtonItemWidth);
    leftButtonView.frame   = CGRectMake(0, 0, kBarButtonItemWidth, kBarButtonItemWidth);
    rightFirstView.frame   = CGRectMake(0, 0, kBarButtonItemWidth, kBarButtonItemWidth);
    rightSecondView.frame  = CGRectMake(0, 0, kBarButtonItemWidth, kBarButtonItemWidth);
    rightButtonView1.frame = CGRectMake(0, 0, kBarButtonItemWidth, kBarButtonItemWidth);
    rightButtonView2.frame = CGRectMake(0, 0, kBarButtonItemWidth, kBarButtonItemWidth);
    
    [leftButtonView    setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    [leftButtonView    setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateSelected];
    [rightButtonView1  setImage:[UIImage imageNamed:@"emotion"] forState:UIControlStateNormal];
    [rightButtonView2  setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    
    [leftView        addSubview:leftButtonView];
    [rightFirstView  addSubview:rightButtonView1];
    [rightSecondView addSubview:rightButtonView2];
    
    objc_setAssociatedObject(leftView, "leftButton", leftButtonView, OBJC_ASSOCIATION_RETAIN);
    
    [inputView.layer setCornerRadius:6];
    [inputView.layer setMasksToBounds:YES];
    [inputView.layer setBorderWidth:1];
    [inputView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [leftButtonView addTarget:self
                       action:@selector(leftBarButtonItemAction:)
             forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView1 addTarget:self
                       action:@selector(rightFirstButtonItemAction:)
             forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView2 addTarget:self
                       action:@selector(rightSecondButtonItemAction:)
             forControlEvents:UIControlEventTouchUpInside];
    
    inputView.sendTextBlock = ^(NSString *text) {
        if (self.inputToolBarDelegate
            && [self.inputToolBarDelegate respondsToSelector:@selector(inputToolBarSendText:)]) {
            [self.inputToolBarDelegate inputToolBarSendText:self];
        }
    };
    
    inputView.textViewDidBeginEditinggBlock = ^(UITextView *textView) {
        if (self.inputToolBarDelegate
            && [self.inputToolBarDelegate respondsToSelector:@selector(inputToolBarBeginTextInput:)]) {
            [self.inputToolBarDelegate inputToolBarBeginTextInput:self];
        }
    };
    
    self.leftBarButtonItem     = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.middleBarButtonItem   = [[UIBarButtonItem alloc] initWithCustomView:inputView];
    self.rightFirstButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:rightFirstView];
    self.rightSecondButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightSecondView];
    
    self.items = @[itemFlexibleSpace,
                   self.leftBarButtonItem, itemFlexibleSpace,
                   self.middleBarButtonItem, itemFlexibleSpace,
                   self.rightFirstButtonItem, itemFlexibleSpace,
                   self.rightSecondButtonItem, itemFlexibleSpace];
}

- (void)leftBarButtonItemAction:(UIButton *)button
{
    [button setSelected:!button.isSelected];
    
    TextVoiceInputView *textVoiceInputView = self.middleBarButtonItem.customView;
    [textVoiceInputView changeState];
    
    if (self.inputToolBarDelegate && [self.inputToolBarDelegate respondsToSelector:@selector(inputToolBarLeftBarButtonItemClicked:)]) {
        [self.inputToolBarDelegate inputToolBarLeftBarButtonItemClicked:self];
    }

}

- (void)rightFirstButtonItemAction:(UIButton *)button
{
    TextVoiceInputView *textVoiceInputView = self.middleBarButtonItem.customView;
    if (textVoiceInputView.isInputViewAbove == NO) {
        UIButton *leftButton = objc_getAssociatedObject(self.leftBarButtonItem.customView, "leftButton");
        [leftButton setSelected:!leftButton.isSelected];

        [textVoiceInputView changeState];
    }
    
    if (self.inputToolBarDelegate && [self.inputToolBarDelegate respondsToSelector:@selector(inputToolBarRightFirstBarButtonItemClicked:)]) {
        [self.inputToolBarDelegate inputToolBarRightFirstBarButtonItemClicked:self];
    }

}

- (void)rightSecondButtonItemAction:(UIButton *)button
{
    TextVoiceInputView *textVoiceInputView = self.middleBarButtonItem.customView;
    if (textVoiceInputView.isInputViewAbove == NO) {
        UIButton *leftButton = objc_getAssociatedObject(self.leftBarButtonItem.customView, "leftButton");
        [leftButton setSelected:!leftButton.isSelected];

        [textVoiceInputView changeState];
    }

    if (self.inputToolBarDelegate && [self.inputToolBarDelegate respondsToSelector:@selector(inputToolBarRightSecondBarButtonItemClicked:)]) {
        [self.inputToolBarDelegate inputToolBarRightSecondBarButtonItemClicked:self];
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
