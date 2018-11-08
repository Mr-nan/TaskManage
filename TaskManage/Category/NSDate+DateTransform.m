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

+(NSDate *)getLastDayDate:(NSString *)dateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:dateStr];
    return [NSDate dateWithTimeInterval:-24 * 60 *60 sinceDate:date];
}



// 获取后一天时间
+(NSDate *)getNextDayDate{
    NSDate *date = [NSDate date];
    return date = [NSDate dateWithTimeInterval:24 * 60 *60 sinceDate:date];
}

+(NSDate *)getNextDayDate:(NSString *)dateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:dateStr];
    return [NSDate dateWithTimeInterval:24 * 60 *60 sinceDate:date];
}

// 获取上一个月
+(NSDate *)getLastMonthDate:(NSDate *)date{
   
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    [comp setMonth:-1];
    
    NSDate *newDate = [calendar dateByAddingComponents:comp toDate:date options:0];
    return newDate;
}

// 获取下一个月
+(NSDate *)getNextMonthDate:(NSDate *)date{
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    [comp setMonth:1];
    NSDate *newDate = [calendar dateByAddingComponents:comp toDate:date options:0];
    return newDate;
    
}

// 获取下N个月
+(NSDate *)getNextMonthDate:(NSDate *)date toNumber:(NSInteger)number{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    [comp setMonth:number];
    NSDate *newDate = [calendar dateByAddingComponents:comp toDate:date options:0];
    return newDate;
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

+(NSInteger)getNumberOfMonthWithDate:(NSString *)dateStr toDate:(NSString *)toDateStr{
   /* NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [[NSDate alloc]init];
    NSDate *toDate = [[NSDate alloc]init];
    date = [formatter dateFromString:dateStr];
    toDate = [formatter dateFromString:toDateStr];
    NSDateComponents *comp = [calender components:NSCalendarUnitMonth fromDate:date toDate:toDate options:NSCalendarWrapComponents];
    return comp.month+1; */
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [[NSDate alloc]init];
    NSDate *toDate = [[NSDate alloc]init];
    date = [formatter dateFromString:dateStr];
    toDate = [formatter dateFromString:toDateStr];

    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    NSDateComponents *toDateComponents = [calendar components:unitFlags fromDate:toDate];
    
    NSInteger dateYear = dateComponents.year;
    NSInteger dateMonth = dateComponents.month;
    
    NSInteger toYear = toDateComponents.year;
    NSInteger toMonth = toDateComponents.month;
        
    return (toYear - dateYear)*12 + (toMonth-dateMonth)+1;
}

//获取当月有多少天
+(NSInteger)totaldaysMonth:(NSString *)dateStr{
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate: date];
    return daysInLastMonth.length;
}

//获取当月第一天是周几
+(NSInteger)firstWeekdayInThisMonth:(NSString *)dateStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate date];
    date = [formatter dateFromString:dateStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 设置每周的第一天从周几开始，默认为1，从周日开始
    [calendar setFirstWeekday:1]; // sun,mon,thes,wed,thur,fri,sat
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    
    NSDate *firstDayofMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayofMonthDate];
    return firstWeekday - 1;
}

@end
