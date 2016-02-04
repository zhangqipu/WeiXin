//
//  QPEmotionView.m
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/11.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "QPEmotionView.h"

#define kBottomViewHeigt (36)
#define kSendButtonWidth (50)

@interface QPEmotionView ()

@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, assign) BOOL     isPresseDowned;

@end

@implementation QPEmotionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.emojiArray =
        @[@"😄", @"😃", @"😀", @"😊", @"☺️", @"😉", @"😍",  // 0
          @"😘", @"😚", @"😗", @"😙", @"😜", @"😝", @"😛",
          @"😳", @"😁", @"😔", @"😌", @"😒", @"😞", @"😣",
          @"😢", @"😂", @"😭", @"😪", @"😥", @"😰", @"😅",  // 1
          @"😓", @"😩", @"😫", @"😨", @"😱", @"😠", @"😡",
          @"😤", @"😖", @"😆", @"😋", @"😷", @"😎", @"😴",
          @"😲", @"😟", @"😦", @"😧", @"😈", @"👿", @"😮",  // 2
          @"😬", @"😐", @"😕", @"😯", @"😶", @"😇", @"😏",
          @"😑", @"👲", @"👳", @"👮", @"👷", @"💂", @"👶",
          @"👦", @"👧", @"👨", @"👩", @"👴", @"👵", @"👱",  // 3
          @"👼", @"👸", @"😺", @"😸", @"😻", @"😽", @"😼",
          @"🙀", @"😿", @"👂", @"👀", @"👃", @"👅", @"👄",
          @"👍", @"👎", @"👌", @"👊", @"✊", @"✌️", @"👋",  // 4
          @"✋", @"👐", @"👆", @"👇", @"👉", @"👈", @"🙌",
          @"🙏", @"☝️", @"👏", @"💪", @"🚶", @"🏃", @"💃",
          @"👫", @"👪", @"👬", @"👭", @"💏", @"💑", @"👯",  // 5
          @"🙆", @"🙅", @"💁", @"🙋", @"💆", @"💇", @"💅",
          @"👰", @"🙎", @"🙍", @"🙇", @"🎩", @"👑", @"👒",
          @"👟", @"👞", @"👡", @"👠", @"👢", @"👕", @"👔",  // 6
          @"👚", @"👗", @"🎽", @"👖", @"👘", @"👙", @"💼",
          @"👜", @"👝", @"👛", @"👓", @"🎀", @"🌂", @"💄",
          @"💛", @"💙", @"💜", @"💚", @"❤️", @"💔", @"💗",  // 7
          @"💓", @"💕", @"💖", @"💞", @"💘", @"💌", @"💋",
          @"💍", @"💎", @"👤", @"👥", @"💬", @"👣", @"💭"];
    }
    
    [self createContents];
    
    return self;
}

- (void)createContents
{
    [self createScrollView];
    [self createBottomView];
}

- (void)createScrollView
{
    self.scrollView               = [[UIScrollView alloc] initWithFrame:
                                     CGRectMake(0,
                                                0,
                                                CGRectGetWidth(self.frame),
                                                CGRectGetHeight(self.frame) - kBottomViewHeigt)];
    
    self.scrollView.delegate      = self;
    self.scrollView.contentSize   = CGSizeMake(CGRectGetWidth(self.frame) * 8, 0);
    self.scrollView.pagingEnabled = YES;
    
    [self addSubview:self.scrollView];
    
    CGFloat w = CGRectGetWidth(self.frame) / 7;
    CGFloat h = (CGRectGetHeight(self.frame) - kBottomViewHeigt) / 3;
    
    for (int j = 0; j < 8; j++) {
        
        UIView *pageView = [[UIView alloc] initWithFrame:
                            CGRectMake(CGRectGetWidth(self.frame) * j,
                                       0,
                                       CGRectGetWidth(self.frame),
                                       CGRectGetHeight(self.frame) - kBottomViewHeigt)];
        pageView.userInteractionEnabled = YES;
        
        for (int i = 0; i < 21; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame     = CGRectMake((i % 7) * w , (i / 7) * h, w, h);
            btn.tag       = ((21 * j) + i);
            
            [btn.titleLabel setFont:[UIFont systemFontOfSize:22]];
            [btn           setTitle:self.emojiArray[((21 * j) + i)]
                           forState:UIControlStateNormal];
            [btn          addTarget:self
                             action:@selector(emojiItemAction:)
                   forControlEvents:UIControlEventTouchUpInside];
            [btn          addTarget:self
                             action:@selector(emojiItemButtonTouchUpDown:)
                   forControlEvents:UIControlEventTouchDown];
            [pageView    addSubview:btn];
        }
        
        [self.scrollView addSubview:pageView];
    }

}

- (void)emojiItemButtonTouchUpDown:(UIButton *)sender
{
    self.selectedButton = sender;
    self.isPresseDowned = YES;
    
    [self setNeedsDisplay];
}

- (void)emojiItemAction:(UIButton *)emojiItem
{
    self.isPresseDowned = NO;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(emotionViewDidSelectedEmoj:)]) {
        [self.delegate emotionViewDidSelectedEmoj:emojiItem.titleLabel.text];
    }
}

- (void)createBottomView
{
    self.bottomView      = [[UIView alloc] initWithFrame:
                            CGRectMake(0,
                                       CGRectGetHeight(self.frame) - kBottomViewHeigt + 1,
                                       CGRectGetWidth(self.frame),
                                       kBottomViewHeigt)];

    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame     = CGRectMake(CGRectGetWidth(self.frame) - kSendButtonWidth,
                                      0,
                                      kSendButtonWidth,
                                      kBottomViewHeigt);
    
    [sendButton           setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [sendButton setBackgroundColor:[UIColor colorWithRed:30.0 / 255 green:144.0 / 255 blue:1 alpha:1]];
    [sendButton      setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton addTarget:self
                   action:@selector(emojSendButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    
    sendButton.layer.shadowOffset  = CGSizeMake(-3, 0);
    sendButton.layer.shadowColor   = [UIColor grayColor].CGColor;
    sendButton.layer.shadowOpacity = 1;
    
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:sendButton];
}

- (void)emojSendButtonAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(emotionViewDidSendEmoj)]) {
        [self.delegate emotionViewDidSendEmoj];
    }
}

#pragma mark
#pragma mark ScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ct = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ct, 1);
    CGContextSetStrokeColorWithColor(ct, [UIColor colorWithWhite:0.88 alpha:1].CGColor);
    
    CGContextMoveToPoint(ct, 0, CGRectGetHeight(self.frame) - kBottomViewHeigt);
    CGContextAddLineToPoint(ct, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - kBottomViewHeigt);
    
    CGContextStrokePath(ct);
}

@end
