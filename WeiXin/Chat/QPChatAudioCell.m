//
//  ChatAudioCell.m
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/6.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "QPChatAudioCell.h"
#import "QPChatDefines.h"

@implementation QPChatAudioCell

#pragma mark
#pragma mark Override

- (void)createContents
{
    [super createContents];
    
    self.audioImageView = [UIImageView new];
    self.audioImageView.animationImages = @[[UIImage imageNamed:@"voice0"],
                                            [UIImage imageNamed:@"voice1"],
                                            [UIImage imageNamed:@"voice2"],
                                            [UIImage imageNamed:@"voice3"]];
    self.audioImageView.animationDuration = 0.8;
    [self.bubbleImageView addSubview:self.audioImageView];
    
    self.audioLenLabel = [UILabel new];
    [self.bubbleImageView addSubview:self.audioLenLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(tapGestureAction:)];
    [self.bubbleImageView addGestureRecognizer:tap];
    
    self.bubbleImageView.userInteractionEnabled = YES;
}

- (void)setupContentWithModel:(QPMessageModel *)model
{
    [super setupContentWithModel:model];
    
    self.audioImageView.image = [UIImage imageNamed:@"voice3"];
    self.audioLenLabel.text = [NSString stringWithFormat:@"%@“", self.messageModel.content];
    self.audioLenLabel.font = [UIFont systemFontOfSize:15];
    self.audioLenLabel.textAlignment = NSTextAlignmentCenter;
    self.audioLenLabel.textColor = [UIColor whiteColor];

    switch (self.messageModel.isLeft) {
        case YES:
            self.audioImageView.transform = CGAffineTransformMakeRotation(M_PI);
            break;
        case NO:
            self.audioImageView.transform = CGAffineTransformIdentity;
            break;
            
        default:
            break;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutAudioImageView];
    [self layoutAudioLenLabel];
}

- (void)layoutAudioImageView
{
    if (self.messageModel.isLeft == YES) {
        self.audioImageView.frame = CGRectMake(kAudioImageViewMarginLeft,
                                               kAudioImageViewMarginTop,
                                               kAudioImageViewWidth,
                                               kAudioImageViewHeight);
    } else {
        self.audioImageView.frame = CGRectMake(CGRectGetWidth(self.bubbleImageView.frame)
                                               - kAudioImageViewMarginLeft - kAudioImageViewWidth,
                                               kAudioImageViewMarginTop,
                                               kAudioImageViewWidth,
                                               kAudioImageViewHeight);
    }
}

- (void)layoutAudioLenLabel
{
    if (self.messageModel.isLeft == YES) {
        self.audioLenLabel.frame = CGRectMake(kAudioLenLabelMarginLeft,
                                               kAudioLenLabelMarginTop,
                                               kAudioLenLabelWidth,
                                               kAudioLenLabelHeight);
    } else {
        self.audioLenLabel.frame = CGRectMake(CGRectGetWidth(self.bubbleImageView.frame) - kAudioLenLabelMarginLeft - kAudioLenLabelWidth,
                                               kAudioLenLabelMarginTop,
                                               kAudioLenLabelWidth,
                                               kAudioLenLabelHeight);
    }
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    if ([self.audioImageView isAnimating] == YES) {
        [self.audioImageView stopAnimating];
    } else {
        [self.audioImageView startAnimating];
    }
}

@end
