//
//  ChatTextCell.m
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/6.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "QPChatTextCell.h"
#import "QPChatDefines.h"

static UIEdgeInsets TextContentViewEdgeInsets = {5, 12, 6, 2}; // 距离BubbleImageView 上 左 下 右 外边距(相对气泡尾巴朝向)

@implementation QPChatTextCell

#pragma mark
#pragma mark Override

- (void)createContents
{
    [super createContents];
    
    self.textContentView = [UITextView new];
}

- (void)setupContentWithModel:(QPMessageModel *)model
{
    [super setupContentWithModel:model];
    
    self.textContentView.font = [UIFont systemFontOfSize:14];
    self.textContentView.backgroundColor = [UIColor clearColor];
    self.textContentView.editable = NO;
    self.textContentView.text = model.content;
    [self.bubbleImageView addSubview:self.textContentView];
    
    if (self.messageModel.isLeft == YES) {
        self.textContentView.textAlignment = NSTextAlignmentLeft;
        self.textContentView.textColor = [UIColor whiteColor];
    } else {
        self.textContentView.textAlignment = NSTextAlignmentRight;
        self.textContentView.textColor = [UIColor whiteColor];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutTextContentView];
}

- (void)layoutTextContentView
{
    CGSize txtSize = [self.textContentView sizeThatFits:CGSizeMake(kTextContentViewWidth, CGFLOAT_MAX)];
    // 计算textView的Frame
    if (self.messageModel.isLeft == YES) {
        self.textContentView.frame = CGRectMake(TextContentViewEdgeInsets.left,
                                                TextContentViewEdgeInsets.top,
                                                txtSize.width,
                                                txtSize.height);
    } else {
        self.textContentView.frame = CGRectMake(TextContentViewEdgeInsets.right,
                                                TextContentViewEdgeInsets.top,
                                                txtSize.width,
                                                txtSize.height);
    }

    // 重置BubbleImageView的Frame
    [self resizeBubbleImageViewFrame];
}

// 重置BubbleImageView 的Frame
- (void)resizeBubbleImageViewFrame
{
    if (self.messageModel.isLeft == YES) {
        self.bubbleImageView.frame = CGRectMake(CGRectGetMinX(self.bubbleImageView.frame),
                                                CGRectGetMinY(self.bubbleImageView.frame),
                                                CGRectGetWidth(self.textContentView.frame)
                                                + TextContentViewEdgeInsets.left
                                                + TextContentViewEdgeInsets.right,
                                                CGRectGetHeight(self.textContentView.frame)
                                                + TextContentViewEdgeInsets.top
                                                + TextContentViewEdgeInsets.bottom);
    } else {
        self.bubbleImageView.frame = CGRectMake(CGRectGetWidth(self.bounds)
                                                - kBubbleImageViewMarginRight
                                                - TextContentViewEdgeInsets.right
                                                - CGRectGetWidth(self.textContentView.frame)
                                                - TextContentViewEdgeInsets.left,
                                                CGRectGetMinY(self.bubbleImageView.frame),
                                                CGRectGetWidth(self.textContentView.frame)
                                                + TextContentViewEdgeInsets.left
                                                + TextContentViewEdgeInsets.right,
                                                CGRectGetHeight(self.textContentView.frame)
                                                + TextContentViewEdgeInsets.top
                                                + TextContentViewEdgeInsets.bottom);
    }
}

@end
