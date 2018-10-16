//
//  ZNCalendarItemView.m
//  TaskManage
//
//  Created by zhengnan on 2018/4/20.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "ZNCalendarItemView.h"

@interface ZNCalendarItemView()

@property (nonatomic,strong) UILabel *calendarLabel;

@end

@implementation ZNCalendarItemView

-(void)setCalendarText:(NSString *)calendarText{
    _calendarText = calendarText;
    self.calendarLabel.text = calendarText;
    self.backgroundColor = [UIColor whiteColor];
}

-(UILabel *)calendarLabel{
    if(!_calendarLabel){
        _calendarLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _calendarLabel.textAlignment = NSTextAlignmentCenter;
        _calendarLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_calendarLabel];
    }
    return _calendarLabel;
}

@end
