//
//  ChatBaseCell.h
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/6.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QPMessageModel.h"
#import "QPChatDefines.h"

@interface QPChatBaseCell : UITableViewCell

// 消息内容
@property (nonatomic, strong) QPMessageModel *messageModel;

// 昵称
@property (nonatomic, strong) UILabel *nicknameLabel;

// 头像
@property (nonatomic, strong) UIImageView *avatarImageView;

// 时间
@property (nonatomic, strong) UILabel *timeLabel;

// 气泡
@property (nonatomic, strong) UIImageView *bubbleImageView;

// 时间Label Y偏移
@property (nonatomic, assign) CGFloat timeLabelOffsetY;

- (void)createContents;

- (void)setupContentWithModel:(QPMessageModel *)model;

@end
