//
//  TextVoiceInputView.m
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/9.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "TextVoiceInputView.h"
#import "QPInputToolBar.h"

@interface TextVoiceInputView ()

@property (nonatomic, copy) NSString *tmpStr;

@end

@implementation TextVoiceInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createContents];
    }
    
    return self;
}

- (void)createContents
{
    self.inputTextView               = [[UITextView alloc] initWithFrame:self.bounds];
    self.inputTextView.returnKeyType = UIReturnKeySend;
    self.inputTextView.delegate      = self;
    self.recordButton                = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordButton.frame          = self.bounds;
    
    [self.recordButton setTitle:@"请按住说话" forState:UIControlStateNormal];
    [self.recordButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.recordButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.recordButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.inputTextView setBackgroundColor:[UIColor whiteColor]];
    [self.inputTextView setFont:[UIFont systemFontOfSize:14]];
    [self.inputTextView setTextColor:[UIColor darkGrayColor]];
    [self.recordButton  setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:self.inputTextView];
    [self addSubview:self.recordButton];
    
    [self bringSubviewToFront:self.inputTextView];
    self.isInputViewAbove = YES;
}

- (void)changeState
{
    if (self.isInputViewAbove == NO) {
        [self bringSubviewToFront:self.inputTextView];
        self.isInputViewAbove = YES;
        [self.inputTextView setText:self.tmpStr];
        [self textViewDidChange:self.inputTextView];
        [self.inputTextView becomeFirstResponder];
    } else {
        [self bringSubviewToFront:self.recordButton];
        self.isInputViewAbove = NO;
        self.tmpStr = self.inputTextView.text;
        [self.inputTextView setText:nil];
        [self textViewDidChange:self.inputTextView];
        [self.inputTextView resignFirstResponder];
    }
}

#pragma mark
#pragma mark TextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if (self.sendTextBlock) {
            self.sendTextBlock(self.inputTextView.text);
        }
        
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGSize size             = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textView.frame), CGFLOAT_MAX)];
    CGFloat dy              = size.height - CGRectGetHeight(textView.frame);
    UIView *sv              = textView.superview;
    QPInputToolBar *toolBar = (QPInputToolBar *)textView.superview.superview;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    
    textView.frame          = CGRectMake(CGRectGetMinX(textView.frame),
                                         CGRectGetMinY(textView.frame),
                                         CGRectGetWidth(textView.frame),
                                         size.height);
    sv.frame                = CGRectMake(CGRectGetMinX(sv.frame),
                                         CGRectGetMinY(sv.frame),
                                         CGRectGetWidth(sv.frame),
                                         size.height);
    toolBar.frame           = CGRectMake(CGRectGetMinX(toolBar.frame),
                                         CGRectGetMinY(toolBar.frame) - dy,
                                         CGRectGetWidth(toolBar.frame),
                                         CGRectGetHeight(toolBar.frame) + dy);
    
    [UIView commitAnimations];
    
    UIView *leftView        = toolBar.leftBarButtonItem.customView;
    UIView *rightFirstView  = toolBar.rightFirstButtonItem.customView;
    UIView *rightSecondView = toolBar.rightSecondButtonItem.customView;
    
    leftView.frame          = CGRectMake(CGRectGetMinX(leftView.frame),
                                         CGRectGetMinY(leftView.frame),
                                         CGRectGetWidth(leftView.frame),
                                         CGRectGetHeight(leftView.frame) + dy);
    rightFirstView.frame    = CGRectMake(CGRectGetMinX(rightFirstView.frame),
                                         CGRectGetMinY(rightFirstView.frame),
                                         CGRectGetWidth(rightFirstView.frame),
                                         CGRectGetHeight(rightFirstView.frame) + dy);
    rightSecondView.frame   = CGRectMake(CGRectGetMinX(rightSecondView.frame),
                                         CGRectGetMinY(rightSecondView.frame),
                                         CGRectGetWidth(rightSecondView.frame),
                                         CGRectGetHeight(rightSecondView.frame) + dy);
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.textViewShouldBeginEditingBlock) {
        self.textViewShouldBeginEditingBlock(textView);
    }
    
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
