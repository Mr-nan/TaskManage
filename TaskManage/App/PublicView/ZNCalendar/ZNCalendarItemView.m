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
@property (nonatomic,strong) UILabel  *signView;


@end

@implementation ZNCalendarItemView


-(void)setTitle:(NSString *)title andMonth:(NSString *)month
{
    NSString *dateSte = [NSString stringWithFormat:@"%@-%.2ld",month,(long)[title integerValue]];
    self.calendarLabel.text = title;

    for (NSString *taskDate in self.taskItem.taskDateArray) {
        NSLog(@"%@--%@",taskDate,dateSte);

        if([taskDate isEqualToString:dateSte]){
            [self.calendarLabel setHidden:YES];
            [self.signView setHidden:NO];
            self.signView.text = title;
            break;
            
        }else{
            [self.calendarLabel setHidden:NO];
            [self.signView setHidden:YES];
        }
    }

    
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

-(UILabel *)signView{
    if(!_signView){
        CGFloat size = self.width * 0.6;
        _signView = [[UILabel alloc]initWithFrame:CGRectMake((self.width - size)/2, (self.height-size)/2, size, size)];
        _signView.backgroundColor = content_color_1;
        _signView.layer.cornerRadius = _signView.height*0.5;
        _signView.layer.masksToBounds = YES;
        _signView.textColor = [UIColor whiteColor];
        _signView.textAlignment = NSTextAlignmentCenter;
        _signView.font = [UIFont systemFontOfSize:15];
        [self addSubview:_signView];
        
    }
    return _signView;
}

@end
