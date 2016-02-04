//
//  QPExtendMenuView.m
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/11.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "QPExtendMenuView.h"

@implementation QPExtendMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.iconArray = @[@"phone", @"font", @"folder", @"group_app",
                           @"red_pack", @"flag", @"picture", @"favorite",
                           @"share", @"music", @"location", @"shake",
                           @"ppt", @"transfer", @"", @""];
        [self createContents];
    }
    
    return self;
}

- (void)createContents
{
    self.scrollView               = [[UIScrollView alloc] initWithFrame:
                                     CGRectMake(0,
                                                0,
                                                CGRectGetWidth(self.frame),
                                                CGRectGetHeight(self.frame))];
    
    self.scrollView.contentSize   = CGSizeMake(CGRectGetWidth(self.frame) * 2, 0);
    self.scrollView.pagingEnabled = YES;
    
    [self addSubview:self.scrollView];

    CGFloat buttonW = 40;
    CGFloat w = CGRectGetWidth(self.frame) / 4;
    CGFloat h = (CGRectGetHeight(self.frame)) / 2;
    CGFloat x = (w - buttonW) / 2;
    CGFloat y = (h - buttonW) / 2;
    
    for (int j = 0; j < 2; j++) {
        
        UIView *pageView = [[UIView alloc] initWithFrame:
                            CGRectMake(CGRectGetWidth(self.frame) * j,
                                       0,
                                       CGRectGetWidth(self.frame),
                                       CGRectGetHeight(self.frame))];
        pageView.userInteractionEnabled = YES;
        
        for (int i = 0; i < 8; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame     = CGRectMake((i % 4) * w + x, (i / 4) * h + y, buttonW, buttonW);
            btn.tag       = ((8 * j) + i);
            
            [btn           setImage:[UIImage imageNamed:self.iconArray[((8 * j) + i)] ]
                           forState:UIControlStateNormal];
            [btn          addTarget:self
                             action:@selector(menuItemAction:)
                   forControlEvents:UIControlEventTouchUpInside];
            [pageView    addSubview:btn];
        }
        
        [self.scrollView addSubview:pageView];
    }

}

- (void)menuItemAction:(UIButton *)sender
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
