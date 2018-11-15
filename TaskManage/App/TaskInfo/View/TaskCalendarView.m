//
//  TaskCalendarView.m
//  TaskManage
//
//  Created by zhengnan on 2018/10/17.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TaskCalendarView.h"
#import "ZNCalendarView.h"
#import "TaskModel.h"
#define left_gap 25

@interface TaskCalendarView()

@property (nonatomic,strong) ZNCalendarView *znCalendarView;
@property (nonatomic,strong) UIImageView    *taskBackView;
@property (nonatomic,strong) UILabel        *title;
@property (nonatomic,strong) UILabel        *infoText;
@property (nonatomic,strong) UILabel        *taskProgressLable;
@property (nonatomic,strong) UILabel        *taskTimeLabel;
@property (nonatomic,strong) UIButton       *finishButton;
@property (nonatomic,strong) TaskItem *taskItem;
@end

@implementation TaskCalendarView

-(instancetype)initWithTaskItem:(TaskItem *)item{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubview:self.taskBackView];
        self.taskItem = item;

    }
    return self;
}

-(void)setTitleColor:(UIColor *)color{
    
    self.title.textColor = color;
    self.infoText.textColor = color;
    self.taskProgressLable.textColor = color;
    self.taskTimeLabel.textColor = color;
}

-(void)setTaskItem:(TaskItem *)taskItem{
    _taskItem = taskItem;
    self.znCalendarView.taskItem = taskItem;
    [self setTintColor:title_color_2];
    self.taskBackView.image = [UIImage imageNamed:@"taskHead1"];
    [self.finishButton setHidden:YES];
    self.title.text = taskItem.taskName;
    self.infoText.text = taskItem.taskRemark;
    if([taskItem.taskSumDayNumber isEqualToString:@"无限期"]){
        self.taskProgressLable.text = [NSString stringWithFormat:@"%lu天 / %@",(unsigned long)taskItem.taskDateArray.count,taskItem.taskSumDayNumber];
        
    }else{
        self.taskProgressLable.text = [NSString stringWithFormat:@"%lu天 / %@天",(unsigned long)taskItem.taskDateArray.count,taskItem.taskSumDayNumber];
        
    }
    self.taskTimeLabel.text = [NSString stringWithFormat:@"%@--%@",taskItem.taskStartDate,taskItem.taskStopDate];
    
    if([taskItem.taskIsLose isEqualToString:@"1"]){
        
        self.taskBackView.image = [UIImage imageNamed:@"taskHead2"];
        [self setTitleColor:title_color_3];
        return;
    }
    
    if([NSDate compareDateStr:taskItem.taskStartDate withNewDateStr:[NSDate getDateString:@"yyyy-MM-dd"]]==-1){
        [self.finishButton setHidden:NO];
        [self.finishButton setTitle:@"未开始" forState:UIControlStateNormal];
        self.finishButton.userInteractionEnabled = NO;
        return;
    }

    
    if(taskItem.taskDateArray.count>0){
        NSString *taskFinallyDate = [taskItem.taskDateArray lastObject];
        if([NSDate compareDateStr:[NSDate getDateString:@"yyyy-MM-dd"] withNewDateStr:taskFinallyDate]==-1){
            [self.finishButton setHidden:NO];
        }
        
    }else{
        [self.finishButton setHidden:NO];
    }
    
    
}

-(void)finishButtonClick{
    
    [self.finishButton setHidden:YES];
    NSString *currentDate = [NSDate getDateString:@"yyyy-MM-dd"];
    if(![currentDate isEqualToString: [self.taskItem.taskDateArray lastObject]]){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"addTaskReloadAction" object:nil userInfo:nil];
        TaskItem *item = self.taskItem;
        [item.taskDateArray addObject:currentDate];
        [TaskModel showHintTask:item];
        [TaskModel setTaskItem:item];
        self.taskItem = item;
    }
}


-(UIImageView *)taskBackView
{
    if(!_taskBackView){
        _taskBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.6)];
        _taskBackView.userInteractionEnabled = YES;
    }
    return _taskBackView;
}

-(ZNCalendarView *)znCalendarView
{
    if(!_znCalendarView){
        _znCalendarView = [[ZNCalendarView alloc]initWithFrame:CGRectMake(0, self.taskBackView.bottom-20, SCREEN_WIDTH, SCREEN_HEIGHT-self.taskBackView.height)];
        [self addSubview:_znCalendarView];
    }
    return _znCalendarView;
}

-(UILabel *)title{
    if(!_title){
        _title = [[UILabel alloc]initWithFrame:CGRectMake(left_gap, NAVIGATION_HEIGHT, SCREEN_WIDTH - left_gap*2 - self.finishButton.width, 30)];
        _title.font = [UIFont systemFontOfSize:20];
        _title.textColor = title_color_2;
//        _title.backgroundColor = [UIColor redColor];
        [self.taskBackView addSubview:_title];
    }
    return _title;
}

-(UILabel *)infoText{
    if(!_infoText){
        _infoText = [[UILabel alloc]initWithFrame:CGRectMake(left_gap, self.title.bottom + 5, SCREEN_WIDTH - left_gap*2 - self.finishButton.width, 20)];
        _infoText.font = [UIFont systemFontOfSize:13];
        _infoText.textColor = title_color_2;
//        _infoText.backgroundColor = [UIColor redColor];
        [self.taskBackView addSubview:_infoText];
    }
    return _infoText;
}

-(UILabel *)taskProgressLable{
    if(!_taskProgressLable){
        _taskProgressLable = [[UILabel alloc]initWithFrame:CGRectMake(left_gap,self.infoText.bottom+10, 100, 20)];
        _taskProgressLable.font = [UIFont systemFontOfSize:13];
        _taskProgressLable.textColor = title_color_2;
//        _taskProgressLable.backgroundColor = [UIColor redColor];
        [self.taskBackView addSubview:_taskProgressLable];
    }
    return _taskProgressLable;
}

-(UILabel *)taskTimeLabel
{
    if(!_taskTimeLabel)
    {
        _taskTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(left_gap, self.taskBackView.bottom-45, 200, 20)];
        _taskTimeLabel.textColor = title_color_2;
        _taskTimeLabel.font = [UIFont systemFontOfSize:11];
//        _taskTimeLabel.backgroundColor = [UIColor redColor];
        [self.taskBackView addSubview:_taskTimeLabel];
    }
    return _taskTimeLabel;
}

-(UIButton *)finishButton
{
    if(!_finishButton){
        _finishButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 75 - 10,(self.taskBackView.height+NAVIGATION_HEIGHT-25-30)/2, 75, 30)];
        _finishButton.backgroundColor = [UIColor whiteColor];
        [_finishButton setTitle:@"今天完成" forState:UIControlStateNormal];
        [_finishButton setTitleColor:title_color_3 forState:UIControlStateNormal];
        _finishButton.layer.cornerRadius = 5;
        _finishButton.layer.masksToBounds = YES;
        _finishButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_finishButton addTarget:self action:@selector(finishButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.taskBackView addSubview:_finishButton];
    
    }
    return _finishButton;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
