//
//  Common.h
//  WeiXin
//
//  Created by zhangqipu on 15/5/9.
//  Copyright (c) 2015年 zhangqipu. All rights reserved.
//

#ifndef WeiXin_Common_h
#define WeiXin_Common_h

#define WIDTH(view) view.frame.size.width
#define HEIGHT(view) view.frame.size.height
#define LEFT(view) view.frame.origin.x
#define TOP(view) view.frame.origin.y
#define BOTTOM(view) (view.frame.origin.y + view.frame.size.height)
#define RIGHT(view) (view.frame.origin.x + view.frame.size.width)

#define UIColorFromHexWithAlpha(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]
#define UIColorFromHex(hexValue) UIColorFromHexWithAlpha(hexValue,1.0)
#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(r,g,b) UIColorFromRGBA(r,g,b,1.0)

static inline void AddRedDot(NSUInteger type, UIView *superV, CGPoint dotPnt, NSString *numText)
{
    if ([numText integerValue] > 99)
        numText = @"99+";
    
    CGFloat w     = type == 1 ? 10 : 17;
    NSString *txt = numText == nil ? @"" : numText;
    
    UILabel *label            = [[UILabel alloc] initWithFrame:CGRectMake(dotPnt.x, dotPnt.y, w, w)];
    label.tag                 = 999;
    label.backgroundColor     = UIColorFromRGB(252, 78, 78);
    label.textAlignment       = NSTextAlignmentCenter;
    label.font                = [UIFont systemFontOfSize:10];
    label.textColor           = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius  = WIDTH(label) / 2;
    label.text                = txt;
    
    [superV addSubview:label];
}

#endif
