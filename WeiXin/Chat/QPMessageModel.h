//
//  MessageModel.h
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/6.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MessageType) {
    MessageTypeText,
    MessageTypeAudio,
    MessageTypeImage
};

@interface QPMessageModel : NSObject

// 时间(为空不显示时间)
@property (nonatomic, copy) NSString *time;

// 昵称
@property (nonatomic, copy) NSString *nickname;

// 图像
@property (nonatomic, copy) NSString *avatar;

// 消息类型
@property (nonatomic, assign) MessageType messageType;

// 消息内容
@property (nonatomic, copy) NSString *content;

// 消息是否放左边(YES -> left)
@property (nonatomic, assign) BOOL isLeft;

// 行高
@property (nonatomic, assign) CGFloat cellHeight;

@end
