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
    self.title = @"add Task";
    self.view = self.addTaskView;

}

-(AddTaskView *)addTaskView
{
    if(_addTaskView == nil){
        _addTaskView = [[AddTaskView alloc]initWithFrame:self.view.bounds];
        _addTaskView.backgroundColor = view_backgroundColor;
        _addTaskView.viewControllerID = self;
    }
    return _addTaskView;
}


@end
