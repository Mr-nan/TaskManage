//
//  TaskCalendarViewController.m
//  TaskManage
//
//  Created by zhengnan on 2018/4/20.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TaskCalendarViewController.h"
#import "ZNCalendarView.h"

@interface TaskCalendarViewController ()

@property (nonatomic,strong) ZNCalendarView *calendarView;

@end

@implementation TaskCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.calendarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(ZNCalendarView *)calendarView{
    if(!_calendarView){
        _calendarView = [[ZNCalendarView alloc]initWithFrame:self.view.bounds];
    }
    return _calendarView;
}


@end
