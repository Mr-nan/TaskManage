//
//  AddTaskViewController.m
//  TaskManage
//
//  Created by zhengnan on 2018/3/27.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "AddTaskViewController.h"
#import "AddTaskView.h"

@interface AddTaskViewController ()

@property (nonatomic,strong) AddTaskView *addTaskView;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加小目标";
    self.view = self.addTaskView;
    
    
}

-(AddTaskView *)addTaskView
{
    if(_addTaskView == nil){
        _addTaskView = [[AddTaskView alloc]initWithFrame:self.view.bounds];
        _addTaskView.backgroundColor = [UIColor colorWithRed:0.88f green:0.95f blue:0.98f alpha:1.00f];
    }
    return _addTaskView;
}


@end
