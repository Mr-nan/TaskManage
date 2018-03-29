//
//  NSDate+DateTransform.h
//  TaskManage
//
//  Created by zhengnan on 2018/3/29.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateTransform)

// 获取当前时间字符串
+(NSString *)getDateString:(NSString *)dateFormatter;

// 获取时间字符串
+(NSString *)getStringDate:(NSDate *)date FormatterString:(NSString *)string;

// 获取前一天时间
+(NSDate *)getLastDayDate;

// 获取后一天时间
+(NSDate *)getNextDayDate;

@end
