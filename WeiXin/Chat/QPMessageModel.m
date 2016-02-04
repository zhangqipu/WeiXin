//
//  MessageModel.m
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/6.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "QPMessageModel.h"
#import "QPChatDefines.h"

static UIEdgeInsets TextContentViewEdgeInsets = {5, 12, 6, 2}; // 距离BubbleImageView 上 左 下 右 外边距(相对气泡尾巴朝向)

@implementation QPMessageModel

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)setContent:(NSString *)content
{
    if (!content) return ;
    
    _content = [content copy];
    
    CGFloat timeLabelOffsetY = self.time ? (kTimeLabelMarginTop + kTimeLabelHeight) : 0;
    
    switch (self.messageType)
    {
        case MessageTypeText: {
            UITextView *txtView = [UITextView new];
            txtView.text = content;
            txtView.font = [UIFont systemFontOfSize:14];
            
            CGSize txtSize = [txtView sizeThatFits:CGSizeMake(kTextContentViewWidth, CGFLOAT_MAX)];
            
            self.cellHeight = kBubbleImageViewMarginTop
            + timeLabelOffsetY
            + TextContentViewEdgeInsets.top
            + txtSize.height
            + TextContentViewEdgeInsets.bottom
            + kBubbleImageViewMarginBottom;
            
            break;
        }
        case MessageTypeAudio: {
            self.cellHeight = kBubbleImageViewMarginTop
            + timeLabelOffsetY
            + kBubbleImageViewHeight
            + kBubbleImageViewMarginBottom;
            break;
        }
        case MessageTypeImage: {
            self.cellHeight = kContentImageViewMarginTop
            + timeLabelOffsetY
            + kContentImageViewHeight
            + kBubbleImageViewMarginBottom;
            break;
        }
            
        default:
            break;
    }
    
}

@end
