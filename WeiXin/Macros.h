//
//  Macros.h
//  AshineDoctor
//
//  Created by JiangYue on 15/2/5.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#ifndef AshineDoctor_Macros_h
#define AshineDoctor_Macros_h

#pragma mark -
#pragma mark Base URL

//#define  BASE_URL  @"http://www.yiyee.com"
#define BASE_URL @"http://www.zgwlbjy.cn"
//#define BASE_URL @"http://200.1.1.65:9009"
//#define BASE_URL @"http://200.1.1.44:9009"
#pragma mark -
#pragma mark Log

#define PRETTY_LOG(s) \
NSLog(@"\n---------------------------------------\n%@\n---------------------------------------\n", s)

#pragma mark -
#pragma mark iOS Version

#define IOS_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define IOS_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IOS_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IOS_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define IS_IOS ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending  )

#pragma mark -
#pragma mark UIColor

#define UIColorFromHexWithAlpha(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]
#define UIColorFromHex(hexValue) UIColorFromHexWithAlpha(hexValue,1.0)
#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(r,g,b) UIColorFromRGBA(r,g,b,1.0)

#pragma mark -
#pragma mark Frame Geometry

#define WIDTH(view) view.frame.size.width
#define HEIGHT(view) view.frame.size.height
#define LEFT(view) view.frame.origin.x
#define TOP(view) view.frame.origin.y
#define BOTTOM(view) (view.frame.origin.y + view.frame.size.height)
#define RIGHT(view) (view.frame.origin.x + view.frame.size.width)

#pragma mark -
#pragma mark Screen size

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#pragma mark -
#pragma mark StatusBar + NavigationBar height

#define TOP_HEIGHT \
([UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height)

#pragma mark -
#pragma mark Load View From XIB

#define LOAD_VIEW_FROM_XIB(xibName) \
    [[[NSBundle mainBundle] loadNibNamed:xibName owner:self options:nil] lastObject]

#pragma mark -
#pragma mark Center View

static inline void CenterView(UIView *v, UIView *superV)
{
    CGPoint origin = CGPointMake((WIDTH(superV)-WIDTH(v))/2,
                                 (HEIGHT(superV)-HEIGHT(v))/2);
    
    v.frame = CGRectMake(origin.x, origin.y, WIDTH(v), HEIGHT(v));
}

static inline void CenterViewX(UIView *v, UIView *superV)
{
    CGPoint origin = CGPointMake((WIDTH(superV)-WIDTH(v))/2,
                                 TOP(v));
    
    v.frame = CGRectMake(origin.x, origin.y, WIDTH(v), HEIGHT(v));
}

#pragma mark -
#pragma mark Get Text Height

static inline CGSize GetTextSize(NSString *txtContent, UIFont *f, CGFloat txtWidth)
{
    CGSize s;
    
    if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0") == YES)
    {
        //给一个比较大的高度，宽度不变
        CGSize size = CGSizeMake(txtWidth,CGFLOAT_MAX);
        //    获取当前文本的属性
        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:f, NSFontAttributeName, nil];
        //ios7方法，获取文本需要的size，限制宽度
        s = [txtContent boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    }
    else
    {
        s = [txtContent sizeWithFont:f constrainedToSize:CGSizeMake(txtWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    }

    return s;
}

static inline NSString * GetNowDateString()
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy:MM:dd:hh:mm:ss"];
    
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    return dateStr;
}

#endif
