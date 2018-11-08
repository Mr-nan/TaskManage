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
@property (nonatomic,strong) UILabel *signView;
@property (nonatomic,strong) UIView  *continuousView;


@end

@implementation ZNCalendarItemView


-(void)setTitle:(NSString *)title andMonth:(NSString *)month
{
    NSString *dateSte = [NSString stringWithFormat:@"%@-%.2ld",month,(long)[title integerValue]];

    self.calendarLabel.text = title;
    CGFloat size = self.width * 0.6;
    self.continuousView.frame = CGRectMake(-1, (self.height-size)/2, self.width+2, size);

    for (NSInteger i=0;i<self.taskItem.taskDateArray.count;i++) {
        NSString *taskDate = self.taskItem.taskDateArray[i];
        
        if([taskDate isEqualToString:dateSte]){
            
            NSString *nexDate = [NSDate getStringDate:[NSDate getNextDayDate:taskDate] FormatterString:@"yyyy-MM-dd"];
            NSString *topDate = [NSDate getStringDate:[NSDate getLastDayDate:taskDate] FormatterString:@"yyyy-MM-dd"];
            
            if(i!=0 && i<self.taskItem.taskDateArray.count-1){
    
                if([self.taskItem.taskDateArray[i+1] isEqualToString:nexDate] || [self.taskItem.taskDateArray[i-1] isEqualToString:topDate]){
                    [self.continuousView setHidden:NO];
                    if(![self.taskItem.taskDateArray[i+1] isEqualToString:nexDate] || [dateSte isEqualToString:[NSString stringWithFormat:@"%@-%.2ld", month,[NSDate totaldaysMonth:dateSte]]]){
                        self.continuousView.left = 0;
                        self.continuousView.width = self.continuousView.width/2-1;
                        
                    }else if (![self.taskItem.taskDateArray[i-1] isEqualToString:topDate] || [dateSte isEqualToString:[NSString stringWithFormat:@"%@-01",month]]){
                        self.continuousView.left = self.continuousView.width /2+1;
                        self.continuousView.width = self.continuousView.width /2-1;
                    }
                }
                
            }else{
                
                if(i==0 && [self.taskItem.taskDateArray[i+1] isEqualToString:nexDate]){
                    [self.continuousView setHidden:NO];
                    self.continuousView.left = self.continuousView.width /2+1;
                    self.continuousView.width = self.continuousView.width /2-1;

                }else if(i==self.taskItem.taskDateArray.count-1 && [self.taskItem.taskDateArray[i-1] isEqualToString:topDate]){
                    [self.continuousView setHidden:NO];
                    
                    self.continuousView.left = 0;
                    self.continuousView.width = self.continuousView.width /2-1;
                    
                }else {
                    [self.continuousView setHidden:YES];
                }
                
            }
            
            [self.calendarLabel setHidden:YES];
            [self.signView setHidden:NO];
            self.signView.text = title;
            break;
            
        }else{
            [self.continuousView setHidden:YES];
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

-(UIView *)continuousView{
    if(!_continuousView){
        _continuousView = [[UIView alloc]init];
        _continuousView.backgroundColor = content_color_1;
        [self addSubview:_continuousView];
    }
    return _continuousView;
}



@end
