//
//  HomeView.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/24.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "HomeView.h"
#import "TaskModel.h"
#import "TaskCell.h"
#import "TaskCalendarViewController.h"

@interface HomeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) TaskHeadView *taskHeadView;
@property (nonatomic,strong) UITableView *taskTableView;


@end

@implementation HomeView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addTaskReloadAction) name:@"addTaskReloadAction" object:nil];
        [self addSubview:self.taskTableView];        
    }
    return self;
}

-(void)setControllerID:(UIViewController *)controllerID{
    
    _controllerID = controllerID;
    self.taskHeadView.controllerID = controllerID;
    
}

#pragma mark -tableViewDelegate

-(void)addTaskReloadAction{
    
    [self.taskTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [TaskModel getTaskModelArray].count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return taskCellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell = [[TaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    TaskItem *item = [[TaskModel getTaskModelArray]objectAtIndex:indexPath.section];
    cell.cellItem = item;
    cell.finisTaskBlock=^(TaskItem *finisTaskItem){
        [TaskModel setTaskItem:finisTaskItem];
        [tableView reloadData];
    };
    cell.closeTaskBlocl = ^(TaskItem *taskItem) {
        if([taskItem.taskIsLose isEqualToString:@"1"]){
            [TaskModel moveTaskLoseItem:taskItem];
        }else{
            [TaskModel moveTaskItem:taskItem];

        }
        [tableView reloadData];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskCalendarViewController *taskCalendarVC = [[TaskCalendarViewController alloc]init];
    TaskItem *item = [[TaskModel getTaskModelArray]objectAtIndex:indexPath.section];
    taskCalendarVC.title = item.taskName;
    taskCalendarVC.taskItem = item;
    [self.controllerID.navigationController pushViewController:taskCalendarVC animated:YES];
}


-(UITableView *)taskTableView{
    if(_taskTableView == nil){
        _taskTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
        _taskTableView.backgroundColor = view_backgroundColor;
        _taskTableView.dataSource = self;
        _taskTableView.delegate = self;
        _taskTableView.tableHeaderView = self.taskHeadView;
        _taskTableView.separatorColor = view_backgroundColor;
    }
    return _taskTableView;
}

-(UIView *)taskHeadView{
    if(_taskHeadView == nil){
        _taskHeadView = [[TaskHeadView alloc]init];
        _taskHeadView.backgroundColor =view_backgroundColor;
    }
    return _taskHeadView;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end
