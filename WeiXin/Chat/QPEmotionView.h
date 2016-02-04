//
//  QPEmotionView.h
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/11.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QPEmotionViewDelegate <NSObject>

- (void)emotionViewDidSelectedEmoj:(NSString *)emojiString;
- (void)emotionViewDidSendEmoj;

@end

@interface QPEmotionView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray      *emojiArray;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView       *bottomView;

@property (nonatomic, assign) id <QPEmotionViewDelegate> delegate;

@end
