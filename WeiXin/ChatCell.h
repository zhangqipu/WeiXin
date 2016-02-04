//
//  ChatCell.h
//  WeiXin
//
//  Created by zhangqipu on 15/5/4.
//  Copyright (c) 2015年 zhangqipu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell

@property (strong, nonatomic) NSDictionary *dataSource;

@property (copy, nonatomic) void(^SetCellHeightBlock)(CGFloat cellHeight);

// 消息发送时间
@property (strong, nonatomic)  UILabel *timeLabel;
// 头像
@property (strong, nonatomic)  UIImageView *headImage;
// 消息内容
@property (strong, nonatomic)  UILabel *msgLabel;
// 消息背景图片
@property (strong, nonatomic)  UIImageView *msgBackImage;
// 语音图片
@property (strong, nonatomic)  UIImageView *soundImage;
// cell高度
@property (assign, nonatomic) CGFloat cellHeight;

- (void)layoutContent;

@end
