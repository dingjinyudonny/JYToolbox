//
//  JYTickTockTime.m
//  JYToolbox
//
//  Created by 丁进宇 on 2022/3/26 15:49.
//  Copyright © 2022 丁进宇. All rights reserved.
//
//  Remark:
//
    

#import "JYTickTockTime.h"

@interface JYTickTockTime ()

/// 计时时间
@property (nonatomic, assign, readwrite) CFAbsoluteTime tickTime;

/// 结束时间
@property (nonatomic, assign, readwrite) CFAbsoluteTime tockTime;

@end

@implementation JYTickTockTime

#pragma mark - Public methods

static dispatch_once_t onceToken;
static JYTickTockTime *instance = nil;

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)sharedInstance{
    dispatch_once(&onceToken, ^{
        instance = [[JYTickTockTime alloc] init];
    });
    return instance;
}

- (void)deallocNetSpeed{
    instance = nil;
    onceToken = 0;
}

/// 开始计时(重置)
- (void)tick{
    self.tickTime = CFAbsoluteTimeGetCurrent();
}

/// 开始计时(不重置)
- (void)tickLazy{
    if (!self.tickTime) {
        self.tickTime = CFAbsoluteTimeGetCurrent();
    }
}

/// 重置计时
- (void)tickReset{
    self.tickTime = 0;
}

/// 结束计时
- (CFAbsoluteTime)tock{
    self.tockTime = CFAbsoluteTimeGetCurrent() - self.tickTime;
    return self.tockTime;
}

/// 结束计时
- (CFAbsoluteTime)tockTime{
    if (!self.tickTime) {
        [self tick];
    }
    _tockTime = CFAbsoluteTimeGetCurrent() - self.tickTime;
    return _tockTime;
}


@end
