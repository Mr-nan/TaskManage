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

// 日期字符串比较: （0-相等    1-小于  -1-大于）
+(NSInteger)compareDateStr:(NSString *)dateStr withNewDateStr:(NSString *)newDateSt;

// 获取两个日期之间的天数
+(NSInteger)getNumberOfDaysWithDate:(NSString *)dateStr toDate:(NSString *)toDateStr;

// 获取两个日期隔的月数
+(NSInteger)getNumberOfMonthWithDate:(NSString *)dateStr toDate:(NSString *)toDateStr;

@end
