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
@property (nonatomic,strong) UIImageView *signView;
@property (nonatomic,strong) UILabel     *signLabel;
@property (nonatomic,strong) UIView  *continuousView;


@end

@implementation ZNCalendarItemView


-(void)setTitle:(NSString *)title andMonth:(NSString *)month
{
    NSString *dateSte = [NSString stringWithFormat:@"%@-%.2ld",month,(long)[title integerValue]];

    self.calendarLabel.text = title;
    self.calendarLabel.textColor = title_color_1;
    
    CGFloat size = self.width * 0.6-4;
    self.continuousView.frame = CGRectMake(-1, (self.height-size)/2, self.width+2, size);
    [self.continuousView setHidden:YES];
    [self.signView setHighlighted:YES];
    [self.signLabel setHidden:YES];

    for (NSInteger i=0;i<self.taskItem.taskDateArray.count;i++) {
        NSString *taskDate = self.taskItem.taskDateArray[i];
        if([taskDate isEqualToString:dateSte]){
            [self.calendarLabel setHidden:YES];
            [self.signView setHidden:NO];
            [self.signLabel setHidden:NO];
            self.signLabel.text = title;
            
            NSString *nexDate = [NSDate getStringDate:[NSDate getNextDayDate:taskDate] FormatterString:@"yyyy-MM-dd"];
            NSString *topDate = [NSDate getStringDate:[NSDate getLastDayDate:taskDate] FormatterString:@"yyyy-MM-dd"];
            
            if(i!=0 && i<self.taskItem.taskDateArray.count-1){
    
                if([self.taskItem.taskDateArray[i+1] isEqualToString:nexDate] || [self.taskItem.taskDateArray[i-1] isEqualToString:topDate]){
                    [self.continuousView setHidden:NO];
                    [self.signView setHidden:YES];

                    // 尾部
                    if(![self.taskItem.taskDateArray[i+1] isEqualToString:nexDate] || [dateSte isEqualToString:[NSString stringWithFormat:@"%@-%.2ld", month,(long)[NSDate totaldaysMonth:dateSte]]]){
                        self.continuousView.left = 0;
                        self.continuousView.width = self.continuousView.width/2-1;
                        [self.signView setHidden:NO];

                    // 开头
                    }else if (![self.taskItem.taskDateArray[i-1] isEqualToString:topDate] || [dateSte isEqualToString:[NSString stringWithFormat:@"%@-01",month]]){
                        self.continuousView.left = self.continuousView.width /2+1;
                        self.continuousView.width = self.continuousView.width /2-1;
                        [self.signView setHidden:NO];
                    }
                }
                
            }else{
                if(i==0 && i+1< self.taskItem.taskDateArray.count){
                    if([self.taskItem.taskDateArray[i+1] isEqualToString:nexDate]){
                        [self.continuousView setHidden:NO];
                        self.continuousView.left = self.continuousView.width /2+1;
                        self.continuousView.width = self.continuousView.width /2-1;
                    }
                   

                }else if(i==self.taskItem.taskDateArray.count-1 && i!=0){
                    if([self.taskItem.taskDateArray[i-1] isEqualToString:topDate]){
                        [self.continuousView setHidden:NO];
                        self.continuousView.left = 0;
                        self.continuousView.width = self.continuousView.width /2-1;
                    }
                    
                }else {
                    [self.continuousView setHidden:YES];
                }
                
            }
            
           
            break;
            
        }else{
            [self.calendarLabel setHidden:NO];
            [self.continuousView setHidden:YES];
            [self.signView setHidden:YES];
            [self.signLabel setHidden:YES];
        }
    }
    
    if([NSDate compareDateStr:dateSte withNewDateStr:self.taskItem.taskStartDate]==1 || [NSDate compareDateStr:dateSte withNewDateStr:self.taskItem.taskStopDate]==-1){
        [self.calendarLabel setHidden:NO];
        self.calendarLabel.textColor = title_color_4;
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

-(UIImageView *)signView{
    if(!_signView){
        CGFloat size = self.width;
        _signView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size, size)];
        _signView.image = [UIImage imageNamed:@"圆"];
        _signView.hidden = YES;
        [self addSubview:_signView];
        
    }
    return _signView;
}

-(UILabel *)signLabel{
    if(!_signLabel){
        CGFloat size = self.width;
        _signLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, size, size)];
        _signLabel.textColor = [UIColor whiteColor];
        _signLabel.textAlignment = NSTextAlignmentCenter;
        _signLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_signLabel];
    }
    return _signLabel;
}

-(UIView *)continuousView{
    if(!_continuousView){
        _continuousView = [[UIView alloc]init];
        _continuousView.backgroundColor = content_color_1;
        [self addSubview:_continuousView];
    }
    return _continuousView;
}



@end
