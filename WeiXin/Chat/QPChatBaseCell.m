//
//  ChatBaseCell.m
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/6.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "QPChatBaseCell.h"

@interface QPChatBaseCell()
@end

@implementation QPChatBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContents];
    }
    
    return self;
}

- (void)createContents
{
    self.nicknameLabel = [UILabel new];
    self.avatarImageView = [UIImageView new];
    self.timeLabel = [UILabel new];
    self.bubbleImageView = [UIImageView new];
    
    [self.contentView addSubview:self.nicknameLabel];
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.bubbleImageView];
}

- (void)setupContentWithModel:(QPMessageModel *)model
{
    self.messageModel = model;
    
    self.nicknameLabel.font = [UIFont systemFontOfSize:15];
    self.nicknameLabel.text = self.messageModel.nickname;
    
    self.avatarImageView.image = [UIImage imageNamed:@"avatar"];
    
    if (self.messageModel.time) { // 显示时间
        self.timeLabelOffsetY = kTimeLabelMarginTop + kTimeLabelHeight;
        self.timeLabel.text = @"2016-01-01 13:13";
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.timeLabel.textColor = [UIColor grayColor];

    } else { // 不显示时间
        self.timeLabelOffsetY = 0;
    }
    
    if (self.messageModel.isLeft == YES) {
        self.nicknameLabel.textAlignment = NSTextAlignmentLeft;
        self.bubbleImageView.image = [[UIImage imageNamed:@"bubble-flat-incoming-selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 20.0f, 15.0f, 20.0f) resizingMode:UIImageResizingModeStretch];
    } else {
        self.nicknameLabel.textAlignment = NSTextAlignmentRight;
        self.bubbleImageView.image = [[UIImage imageNamed:@"bubble-flat-outgoing-selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(14.0f, 15.0f, 14.0f, 20.0f) resizingMode:UIImageResizingModeStretch];
    }
}

- (void)layoutSubviews
{
    [self layoutNicknameLabel];
    [self layoutAvatarImageView];
    [self layoutBubbleImageView];
    [self layoutTimeLabel];
}

- (void)layoutNicknameLabel
{
    if (self.messageModel.isLeft == YES) {
        self.nicknameLabel.frame = CGRectMake(kNicknameLabelMarginLeft,
                                              kNicknameLabelMarginTop + self.timeLabelOffsetY,
                                              kNicknameLabelWidth,
                                              kNickNameLabelHeight);
    } else {
        self.nicknameLabel.frame = CGRectMake(CGRectGetWidth(self.bounds)
                                              - kNicknameLabelMarginRight - kNicknameLabelWidth,
                                              kNicknameLabelMarginTop + self.timeLabelOffsetY,
                                              kNicknameLabelWidth,
                                              kNickNameLabelHeight);
    }
}

- (void)layoutAvatarImageView
{
    if (self.messageModel.isLeft == YES) {
        self.avatarImageView.frame = CGRectMake(kAvatarImageViewMarginLeft,
                                                kAvatarImageViewMarginTop + self.timeLabelOffsetY,
                                                kAvatarImageViewWidth,
                                                kAvatarImageViewHeight);
    } else {
        self.avatarImageView.frame = CGRectMake(CGRectGetWidth(self.bounds)
                                                - kAvatarImageViewMarginRight - kAvatarImageViewWidth,
                                                kAvatarImageViewMarginTop + self.timeLabelOffsetY,
                                                kAvatarImageViewWidth,
                                                kAvatarImageViewHeight);
    }
}

- (void)layoutTimeLabel
{
    self.timeLabel.frame = CGRectMake((CGRectGetWidth(self.frame) - kTimeLabelWidth) / 2,
                                      kTimeLabelMarginTop,
                                      kTimeLabelWidth,
                                      kTimeLabelHeight);
}

- (void)layoutBubbleImageView
{
    if (self.messageModel.isLeft == YES) {
        self.bubbleImageView.frame = CGRectMake(kBubbleImageViewMarginLeft,
                                                kBubbleImageViewMarginTop + self.timeLabelOffsetY,
                                                kBubbleImageViewWidth,
                                                kBubbleImageViewHeight);

    } else {
        self.bubbleImageView.frame = CGRectMake(CGRectGetWidth(self.bounds)
                                                - kBubbleImageViewMarginRight - kBubbleImageViewWidth,
                                                kBubbleImageViewMarginTop + self.timeLabelOffsetY,
                                                kBubbleImageViewWidth,
                                                kBubbleImageViewHeight);
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
