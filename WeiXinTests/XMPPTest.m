//
//  XMPPTest.m
//  WeiXin
//
//  Created by 张齐朴 on 16/2/4.
//  Copyright © 2016年 zhangqipu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XMPPManager.h"

@interface XMPPTest : XCTestCase

@end

@implementation XMPPTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XMPPManager *xmppManager = [XMPPManager sharedXMPPManager];
    
    [xmppManager setUserName:@""];
    [xmppManager setUserName:@""];
    
    [xmppManager loginUser];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
