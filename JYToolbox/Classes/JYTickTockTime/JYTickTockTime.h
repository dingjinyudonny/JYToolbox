//
//  JYTickTockTime.h
//  JYToolbox
//
//  Created by 丁进宇 on 2022/3/26 15:49.
//  Copyright © 2022 丁进宇. All rights reserved.
//
//  Remark: 查看代码的执行时间
//
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define JYTICK     CFAbsoluteTime tickTime = CFAbsoluteTimeGetCurrent();
#define JYTOCK     (CFAbsoluteTimeGetCurrent() - tickTime)
#define JYTOCKLOG  NSLog(@"Time: %.2f", JYTOCK)

#define JYTICKTIME     [[JYTickTockTime sharedInstance] tick];
#define JYTICKLAZY     [[JYTickTockTime sharedInstance] tickLazy];
#define JYTICKRESET    [[JYTickTockTime sharedInstance] tickReset];
#define JYTOCKTIME     [JYTickTockTime sharedInstance].tockTime
#define JYTOCKTIMELOG  NSLog(@"Time: %.2f", JYTOCKTIME)

@interface JYTickTockTime : NSObject

/// 执行时间
@property (nonatomic, assign, readonly) CFAbsoluteTime tockTime;

+ (instancetype)sharedInstance;

- (void)deallocNetSpeed;

/// 开始计时(重置)
- (void)tick;

/// 开始计时(不重置)
- (void)tickLazy;

/// 重置计时
- (void)tickReset;

/// 结束计时
- (CFAbsoluteTime)tock;

/// 结束计时
- (CFAbsoluteTime)tockTime;


@end

NS_ASSUME_NONNULL_END
