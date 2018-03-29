//
//  NSDate+DateTransform.m
//  TaskManage
//
//  Created by zhengnan on 2018/3/29.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "NSDate+DateTransform.h"

@implementation NSDate (DateTransform)

// 获取时间字符串
+(NSString *)getDateString:(NSString *)dateFormatter{
    return [NSDate getStringDate:[NSDate date] FormatterString:dateFormatter];
}

// 获取时间字符串
+(NSString *)getStringDate:(NSDate *)date FormatterString:(NSString *)string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:string];
    return [formatter stringFromDate:date];
}

// 获取前一天时间
+(NSDate *)getLastDayDate{
    NSDate *date = [NSDate date];
    return date = [NSDate dateWithTimeInterval:-24 * 60 *60 sinceDate:date];
}

// 获取后一天时间
+(NSDate *)getNextDayDate{
    NSDate *date = [NSDate date];
    return date = [NSDate dateWithTimeInterval:24 * 60 *60 sinceDate:date];
}

@end
