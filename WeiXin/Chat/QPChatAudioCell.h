//
//  ChatAudioCell.h
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/6.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "QPChatBaseCell.h"

@interface QPChatAudioCell : QPChatBaseCell

// 音频动画图标
@property (nonatomic, strong) UIImageView *audioImageView;

// 音频时长
@property (nonatomic, strong) UILabel *audioLenLabel;

@end
