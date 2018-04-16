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

// 日期字符串比较: （0-相等    1-小于  -1-大于）
+(NSInteger)compareDateStr:(NSString *)dateStr withNewDateStr:(NSString *)newDateStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [[NSDate alloc]init];
    NSDate *newDate = [[NSDate alloc]init];
 
    date = [formatter dateFromString:dateStr];
    newDate = [formatter dateFromString:newDateStr];
    
    NSComparisonResult result = [date compare:newDate];
    if(result==NSOrderedSame){
        return 0;
    }else if(result == NSOrderedAscending){
        return 1;
    }else{
        return -1;
    }
}

// 获取两个日期之间的天数
+(NSInteger)getNumberOfDaysWithDate:(NSString *)dateStr toDate:(NSString *)toDateStr{
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [[NSDate alloc]init];
    NSDate *toDate = [[NSDate alloc]init];
    date = [formatter dateFromString:dateStr];
    toDate = [formatter dateFromString:toDateStr];
    NSDateComponents *comp = [calender components:NSCalendarUnitDay fromDate:date toDate:toDate options:NSCalendarWrapComponents];
    return comp.day;
}

@end
