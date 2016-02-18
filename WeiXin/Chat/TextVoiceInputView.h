//
//  TextVoiceInputView.h
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/9.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SendTextBlock)(NSString *text);
typedef void(^TextViewDidBeginEditinggBlock)(UITextView *textView);

@interface TextVoiceInputView : UIView <UITextViewDelegate>

// 输入框
@property (nonatomic, strong) UITextView    *inputTextView;

// 录音按钮
@property (nonatomic, strong) UIButton      *recordButton;

@property (nonatomic, assign) BOOL          isInputViewAbove;

// 发送文字Block
@property (nonatomic, copy)   SendTextBlock sendTextBlock;

@property (nonatomic, copy) TextViewDidBeginEditinggBlock textViewDidBeginEditinggBlock;

// 调整输入框录音按钮的显示隐藏
- (void)changeState;

@end
