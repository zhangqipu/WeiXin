//
//  ChatCell.m
//  WeiXin
//
//  Created by zhangqipu on 15/5/4.
//  Copyright (c) 2015年 zhangqipu. All rights reserved.
//

#import "ChatCell.h"
#import "Macros.h"

#define kTimeLabelTopMargin 8
#define kTimeLabelWidth    130
#define kTimeLabelHeight   20
#define kLabelFont         15

#define kHeadImageLeftMargin 15
#define kHeadImageWidth      44
#define kHeadTimeBetween     10

#define kMsgLabelWidth       160
#define kMsgTimeBetween      20
#define kMsgHeadBetween      30

#define kBubbleMsgMarginTop        10
#define kBubbleMsgMarginLeft       20
#define kBubbleMsgMarginBottom     10
#define kBubbleMsgMarginRight      20

#define kSoundHeadBetween      25
#define kSoundTimeBetween      20
#define kSoundWidth            20

#define kBubbleSoundMarginTop    10
#define kBubbleSoundMarginLeft   15
#define kBubbleSoundMarginBottom 10
#define kBubbleSoundMarginRight  25

#define kPictureHeadBetween 25
#define kPictureWidth       140
#define kPictureHeight      100

@implementation ChatCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createContent];
    }
    
    return self;
}

- (void)createContent
{
    self.timeLabel = [[UILabel alloc] init];
    self.headImage = [[UIImageView alloc] init];
    self.msgBackImage = [[UIImageView alloc] init];
    self.msgLabel = [[UILabel alloc] init];
    self.soundImage = [[UIImageView alloc] init];
    
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.headImage];
    [self.contentView addSubview:self.msgBackImage];
    [self.contentView addSubview:self.msgLabel];
    [self.contentView addSubview:self.soundImage];
}

- (void)layoutContent
{
    // 获取发送方
    NSUInteger side = [self.dataSource[@"side"] integerValue];

    // 设置时间
    self.timeLabel.text  = self.dataSource[@"time"];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel.frame = CGRectMake(LEFT(self.timeLabel), kTimeLabelTopMargin, kTimeLabelWidth, kTimeLabelHeight);
    CenterViewX(self.timeLabel, self.contentView);
    
    // 设置用户头像
    [self.headImage setFrame:CGRectMake(kHeadImageLeftMargin, BOTTOM(self.timeLabel) + kHeadTimeBetween, kHeadImageWidth, kHeadImageWidth)];
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = kHeadImageWidth / 2;
    [self.headImage setImage:[UIImage imageNamed:@"person"]];
    if (side == 1)
    {
        [self.headImage setImage:[UIImage imageNamed:@"set_head"]];
        [self.headImage setFrame:CGRectMake(WIDTH(self) - kHeadImageWidth - kHeadImageLeftMargin, BOTTOM(self.timeLabel) + kHeadTimeBetween, kHeadImageWidth, kHeadImageWidth)];
    }

    // 文字内容
    if ([self.dataSource[@"type"] isEqualToString:@"1"])
    {
        [self layoutTextMsgWithSide:side];
    }

//    // 语音内容
//    if ([self.dataSource[@"type"] isEqualToString:@"2"])
//    {
//        [self layoutSoundMsgWithSide:side];
//    }
//
//    // 图片内容
//    if ([self.dataSource[@"type"] isEqualToString:@"3"])
//    {
//        [self layoutPictureMsgWithSide:side];
//    }
}

/**
 *  文本消息
 *
 *  @param side            自己发送还是对方发送
 */
- (void)layoutTextMsgWithSide:(NSUInteger)side
{
    self.msgLabel.text = self.dataSource[@"content"];
    self.msgLabel.textColor = [UIColor lightGrayColor];
    self.msgLabel.numberOfLines = 0;
    // 获取文字高度
    CGSize s = GetTextSize(self.msgLabel.text, self.msgLabel.font, kMsgLabelWidth);
    self.msgLabel.frame = CGRectMake(LEFT(self.msgLabel), TOP(self.msgLabel), s.width, s.height);

    // 设置消息内容
    self.msgLabel.frame = CGRectMake(RIGHT(self.headImage) + kMsgHeadBetween, BOTTOM(self.timeLabel) + kMsgTimeBetween, WIDTH(self.msgLabel), HEIGHT(self.msgLabel));
    if (side == 1)
    {
        self.msgLabel.textColor = [UIColor whiteColor];
        self.msgLabel.frame = CGRectMake(WIDTH(self) - kHeadImageLeftMargin - kHeadImageWidth - kMsgHeadBetween - WIDTH(self.msgLabel) , BOTTOM(self.timeLabel) + kMsgTimeBetween, WIDTH(self.msgLabel), HEIGHT(self.msgLabel));
    }
    
    // 设置气泡
    self.msgBackImage.frame = CGRectMake(LEFT(self.msgLabel) - kBubbleMsgMarginLeft, TOP(self.msgLabel) - kBubbleMsgMarginTop, WIDTH(self.msgLabel) + kBubbleMsgMarginLeft + kBubbleMsgMarginRight, HEIGHT(self.msgLabel) + kBubbleMsgMarginTop + kBubbleMsgMarginBottom);
    self.msgBackImage.image = [[UIImage imageNamed:@"fromBubble"] stretchableImageWithLeftCapWidth:8 topCapHeight:50];
    if (side == 1)
    {
        self.msgBackImage.frame = CGRectMake(LEFT(self.msgLabel) - (kBubbleMsgMarginLeft), TOP(self.msgLabel) - kBubbleMsgMarginTop, WIDTH(self.msgLabel) + kBubbleMsgMarginLeft + (kBubbleMsgMarginRight + 5), HEIGHT(self.msgLabel) + kBubbleMsgMarginTop + kBubbleMsgMarginBottom);
        self.msgBackImage.image = [[UIImage imageNamed:@"sendBubble"] stretchableImageWithLeftCapWidth:50 topCapHeight:8];
    }
    
    self.SetCellHeightBlock(BOTTOM(self.msgBackImage));
}

/**
 *  语音消息
 *
 *  @param side            自己发送还是对方发送
 */
- (void)layoutSoundMsgWithSide:(NSUInteger)side
{
    // 移除消息label
    [self.msgLabel removeFromSuperview];
    
     // 设置语音图片
    self.soundImage.frame = CGRectMake(RIGHT(self.headImage) + kSoundHeadBetween, BOTTOM(self.timeLabel) + kSoundTimeBetween, kSoundWidth, kSoundWidth);
    self.soundImage.image = [UIImage imageNamed:@"sound"];
    //    if (side == 1)
    //    {
    //        // 图片反转
    //        self.soundImage.transform = CGAffineTransformMakeScale(-1, 1);
    //        self.soundImage.frame = CGRectMake(RIGHT(self.msgBackImage) - 10 - WIDTH(self.soundImage) , TOP(self.soundImage), WIDTH(self.soundImage), HEIGHT(self.soundImage));
    //    }
    
    // 设置气泡
    self.msgBackImage.frame = CGRectMake(LEFT(self.soundImage) - kBubbleSoundMarginLeft, TOP(self.soundImage) - kBubbleSoundMarginTop, WIDTH(self.soundImage) + kBubbleSoundMarginLeft + kBubbleSoundMarginRight, HEIGHT(self.soundImage) + kBubbleSoundMarginTop + kBubbleSoundMarginBottom);
    self.msgBackImage.image = [[UIImage imageNamed:@"fromBubble"] stretchableImageWithLeftCapWidth:50 topCapHeight:8];
//    if (side == 1)
//    {
//        self.msgBackImage.image = [[UIImage imageNamed:@"msgsnd_qipao_d"] stretchableImageWithLeftCapWidth:25 topCapHeight:12];
//        self.msgBackImage.frame = CGRectMake(LEFT(self.headImage) - 10 - WIDTH(self.msgBackImage), TOP(self.msgBackImage), WIDTH(self.msgBackImage), HEIGHT(self.msgBackImage));
//    }
    
    self.SetCellHeightBlock(BOTTOM(self.msgBackImage));
}

/**
 *  图片消息
 *
 *  @param side 自己发送还是对方发送
 */
- (void)layoutPictureMsgWithSide:(NSUInteger)side
{
    [self.msgLabel removeFromSuperview];
    
    // 将气泡作为图像展示框
    self.msgBackImage.frame = CGRectMake(RIGHT(self.headImage) + kPictureHeadBetween, TOP(self.headImage), kPictureWidth, kPictureHeight);
    self.msgBackImage.layer.masksToBounds = YES;
    self.msgBackImage.layer.cornerRadius = 3;
    self.msgBackImage.layer.borderWidth = 0.3;
    self.msgBackImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.msgBackImage.image = [UIImage imageWithContentsOfFile:self.dataSource[@"content"]];

//    if (side == 1)
//    {
//        self.msgBackImage.frame = CGRectMake(LEFT(self.headImage) - 20 - WIDTH(self.msgBackImage), TOP(self.msgBackImage), WIDTH(self.msgBackImage), HEIGHT(self.msgBackImage));
//    }
    self.SetCellHeightBlock(BOTTOM(self.msgBackImage));
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
