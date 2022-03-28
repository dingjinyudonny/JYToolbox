//
//  JYNetSpeed.h
//  JYToolbox
//
//  Created by 丁进宇 on 2022/3/26 14:00.
//  Copyright © 2022 丁进宇. All rights reserved.
//
//  Remark: 网速
//
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYNetSpeed : NSObject

/// 当前下载网速bytes
@property (nonatomic, assign, readonly) int iBytes;

/// 当前上传网速bytes
@property (nonatomic, assign, readonly) int oBytes;

/// 当前下载网速
@property (nonatomic, copy, readonly) NSString *downloadNetSpeed;

/// 当前上传网速
@property (nonatomic, copy, readonly) NSString *uploadNetSpeed;

+ (instancetype)sharedInstance;

- (void)deallocNetSpeed;
/// 开始获取网速
- (void)start;

/// 停止获取网速
- (void)stop;



@end

NS_ASSUME_NONNULL_END
