//
//  TaskCalendarViewController.m
//  TaskManage
//
//  Created by zhengnan on 2018/4/20.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TaskCalendarViewController.h"
#import "TaskCalendarView.h"
#import "ZNNavigationController.h"
@interface TaskCalendarViewController ()

@property (nonatomic,strong) TaskCalendarView *taskCalendarView;


@end

@implementation TaskCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = view_sub_backgroundColor;
    [self.view addSubview:self.taskCalendarView];
}

-(void)viewWillAppear:(BOOL)animated
{
    ZNNavigationController *nc = (ZNNavigationController *)self.navigationController;
    [nc setNavigationBackColor:[view_backgroundColor colorWithAlphaComponent:0]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    ZNNavigationController *nc = (ZNNavigationController *) self.navigationController;
    [nc setNavigationBackColor:view_backgroundColor ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(TaskCalendarView *)taskCalendarView{
    if(!_taskCalendarView){
        _taskCalendarView = [[TaskCalendarView alloc]initWithTaskItem:self.taskItem];
    }
    return _taskCalendarView;
}




@end
