//
//  ChatImageCell.m
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/6.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "QPChatImageCell.h"
#import "QPChatDefines.h"

#import <objc/runtime.h>

@implementation QPChatImageCell

- (void)setupContentWithModel:(QPMessageModel *)model
{
    [super setupContentWithModel:model];
    
    // 先清除气泡图片数据，将BubbleImageView作为消息图片展示的载体，
    self.bubbleImageView.image = nil;
    self.bubbleImageView.image = [UIImage imageNamed: model.content];
    self.bubbleImageView.layer.borderColor = kImageViewBorderColor.CGColor;
    self.bubbleImageView.layer.borderWidth = 1;
    self.bubbleImageView.layer.masksToBounds = YES;
    self.bubbleImageView.layer.cornerRadius = 10;
    
    self.bubbleImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(tapGestureAction:)];
    [self.bubbleImageView addGestureRecognizer:tap];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self relayoutBubbleImageView];
}

- (void)relayoutBubbleImageView
{
    if (self.messageModel.isLeft == YES) {
        self.bubbleImageView.frame = CGRectMake(kContentImageViewMarginLeft,
                                                kContentImageViewMarginTop + self.timeLabelOffsetY,
                                                kContentImageViewWidth,
                                                kContentImageViewHeight);
    } else {
        self.bubbleImageView.frame = CGRectMake(CGRectGetWidth(self.frame)
                                                - kContentImageViewMarginRight - kContentImageViewWidth,
                                                kContentImageViewMarginTop + self.timeLabelOffsetY,
                                                kContentImageViewWidth,
                                                kContentImageViewHeight);
    }
    
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    UIView *superView = self.superview.superview.superview;
    CGRect rectOnView = [self.bubbleImageView.superview convertRect:self.bubbleImageView.frame toView:superView];
    
    UIImageView *detailImageView = [[UIImageView alloc] initWithFrame:rectOnView];
    detailImageView.image = self.bubbleImageView.image;
    detailImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(dismissDetailImageView:)];
    [detailImageView addGestureRecognizer:dismissTap];
    [superView addSubview:detailImageView];
    
    objc_setAssociatedObject(dismissTap,
                             @"detailImageView",
                             detailImageView,
                             OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(dismissTap,
                             @"rectOnView",
                             [NSValue valueWithCGRect:rectOnView],
                             OBJC_ASSOCIATION_RETAIN);
    
    [UIView animateWithDuration:0.8
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:1
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
        detailImageView.frame = CGRectMake(0,
                                           0,
                                           [UIScreen mainScreen].bounds.size.width,
                                           [UIScreen mainScreen].bounds.size.height);

    } completion:nil];
}

- (void)dismissDetailImageView:(UITapGestureRecognizer *)tap
{
    UIImageView *detailImageView = objc_getAssociatedObject(tap, @"detailImageView");
    CGRect rectOnView = [objc_getAssociatedObject(tap, @"rectOnView") CGRectValue];

    [UIView animateWithDuration:0.8
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:1
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         detailImageView.frame = rectOnView;
                     } completion:^(BOOL finished) {
                         [detailImageView removeFromSuperview];
                     }];
}

// 绘制小弧角
- (void)drawRect:(CGRect)rect
{
    CGContextRef ct = UIGraphicsGetCurrentContext();
    
    CGFloat dx1, dy1, dx2, dy2, dx3, dy3, dx4, dy4, dx5, dy5;
    CGPoint bubbleOrigin = CGPointZero;
    
    if (self.messageModel.isLeft == YES) {
        bubbleOrigin = self.bubbleImageView.frame.origin;
        dx1 = -10; dy1 = +5;  // 起点偏离原点变量
        dx2 = 0  ; dy2 = +8;  // 终点一偏离原点变量
        dx3 = -5 ; dy3 = +5;  // 中间点一偏离中线点变量
        dx4 = 0  ; dy4 = +15; // 终点二偏离原点变量
        dx5 = -5 ; dy5 = +5;  // 中间点二偏离中线点变量
    } else {
        bubbleOrigin = CGPointMake(CGRectGetMaxX(self.bubbleImageView.frame),
                                   CGRectGetMinY(self.bubbleImageView.frame));
        dx1 = +10; dy1 = +5;  // 起点偏离原点变量
        dx2 = 0  ; dy2 = +8;  // 终点一偏离原点变量
        dx3 = +5 ; dy3 = +5;  // 中间点一偏离中线点变量
        dx4 = 0  ; dy4 = +15; // 终点二偏离原点变量
        dx5 = +5 ; dy5 = +5;  // 中间点二偏离中线点变量
    }
    
    CGPoint tailStartPoint = CGPointMake(bubbleOrigin.x + dx1, bubbleOrigin.y + dy1);
    CGPoint tailEndPoint1 = CGPointMake(bubbleOrigin.x + dx2, bubbleOrigin.y + dy2);
    CGPoint tailMidPoint1 = CGPointMake(tailStartPoint.x + (tailEndPoint1.x - tailStartPoint.x) / 2 + dx3,
                                        tailStartPoint.y + (tailEndPoint1.y - tailStartPoint.y) / 2 + dy3);
    CGPoint tailEndPoint2 = CGPointMake(bubbleOrigin.x + dx4, bubbleOrigin.y + dy4);
    CGPoint tailMidPoint2 = CGPointMake(tailStartPoint.x + (tailEndPoint2.x - tailStartPoint.x) / 2 + dx5,
                                        tailStartPoint.y + (tailEndPoint2.y - tailStartPoint.y) / 2 + dy5);
    
    CGContextSetLineWidth(ct, 1);
    CGContextSetStrokeColorWithColor(ct, kImageViewBorderColor.CGColor);
    CGContextSetFillColorWithColor(ct, kImageViewBorderColor.CGColor);
    
    CGContextMoveToPoint(ct, tailStartPoint.x, tailStartPoint.y);
    CGContextAddCurveToPoint(ct,
                             tailStartPoint.x, tailStartPoint.y,
                             tailMidPoint1.x, tailMidPoint1.y,
                             tailEndPoint1.x, tailEndPoint1.y);
    CGContextAddLineToPoint(ct, tailEndPoint2.x, tailEndPoint2.y);
    CGContextAddCurveToPoint(ct,
                             tailEndPoint2.x, tailEndPoint2.y,
                             tailMidPoint2.x, tailMidPoint2.y,
                             tailStartPoint.x, tailStartPoint.y);
    
    CGContextClosePath(ct);
    CGContextFillPath(ct);
    CGContextStrokePath(ct);
}

@end
