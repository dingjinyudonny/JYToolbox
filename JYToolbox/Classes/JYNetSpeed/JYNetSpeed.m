//
//  JYNetSpeed.m
//  JYToolbox
//
//  Created by 丁进宇 on 2022/3/26 14:00.
//  Copyright © 2022 丁进宇. All rights reserved.
//
//  Remark:
//
    

#import "JYNetSpeed.h"
#include <arpa/inet.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <net/if_dl.h>

@interface JYNetSpeed ()

/// 计时器
@property (nonatomic, strong) NSTimer *timer;

/// 当前下载网速bytes
@property (nonatomic, assign, readwrite) int iBytes;

/// 当前上传网速bytes
@property (nonatomic, assign, readwrite) int oBytes;

/// 当前下载网速
@property (nonatomic, copy, readwrite) NSString *downloadNetSpeed;

/// 当前上传网速
@property (nonatomic, copy, readwrite) NSString *uploadNetSpeed;

@end

@implementation JYNetSpeed

#pragma mark - Public methods

static dispatch_once_t onceToken;
static JYNetSpeed *instance = nil;

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)sharedInstance{
    dispatch_once(&onceToken, ^{
        instance = [[JYNetSpeed alloc] init];
    });
    return instance;
}

- (void)deallocNetSpeed{
    [self.timer  invalidate];
    self.timer = nil;
    instance = nil;
    onceToken = 0;
}

/// 开始获取网速
- (void)start{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self currentNetSpeed];
    });
    [self.timer setFireDate:[NSDate distantPast]];
}

/// 停止获取网速
- (void)stop{
    [self.timer setFireDate:[NSDate distantFuture]];
}

#pragma mark - Private methods

/// 当前网速
- (void)currentNetSpeed{
    struct ifaddrs *ifa_list = 0, *ifa;
        if (getifaddrs(&ifa_list) == -1) return;
        
        uint32_t iBytes = 0;
        uint32_t oBytes = 0;
        uint32_t allFlow = 0;

        for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
            if (AF_LINK != ifa->ifa_addr->sa_family) continue;
            if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING)) continue;
            if (ifa->ifa_data == 0) continue;
            
            // network
            if (strncmp(ifa->ifa_name, "lo0", 2)) {
                struct if_data* if_data = (struct if_data*)ifa->ifa_data;
                iBytes += if_data->ifi_ibytes;
                oBytes += if_data->ifi_obytes;
                allFlow = iBytes + oBytes;
            }
        }
        
        freeifaddrs(ifa_list);
        if (_iBytes != 0) {
            _downloadNetSpeed = [[self stringWithbytes:iBytes - _iBytes] stringByAppendingString:@"/s"];
        }
        _iBytes = iBytes;
        
        if (_oBytes != 0) {
            _uploadNetSpeed = [[self stringWithbytes:oBytes - _oBytes] stringByAppendingString:@"/s"];
        }
        _oBytes = oBytes;
}

/// 转换
- (NSString *)stringWithbytes:(int)bytes {
    if (bytes < 1024) { // B
        return [NSString stringWithFormat:@"%dB", bytes];
    } else if (bytes >= 1024 && bytes < 1024 * 1024) { // KB
        return [NSString stringWithFormat:@"%.0fKB", (double)bytes / 1024];
    } else if (bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024) { // MB
        return [NSString stringWithFormat:@"%.1fMB", (double)bytes / (1024 * 1024)];
    } else { // GB
        return [NSString stringWithFormat:@"%.1fGB", (double)bytes / (1024 * 1024 * 1024)];
    }
}

#pragma mark - Lazy
- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(currentNetSpeed) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantFuture]];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    return _timer;
}

@end
