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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [TaskModel getTaskModelArray].count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return taskCellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell = [[TaskCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    TaskItem *item = [[TaskModel getTaskModelArray]objectAtIndex:indexPath.row];
    cell.cellItem = item;
    cell.finisTaskBlock=^(TaskItem *finisTaskItem){
        [TaskModel setTaskItem:finisTaskItem];
        [tableView reloadData];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskCalendarViewController *taskCalendarVC = [[TaskCalendarViewController alloc]init];
    TaskItem *item = [[TaskModel getTaskModelArray]objectAtIndex:indexPath.row];
    taskCalendarVC.title = item.taskName;
    taskCalendarVC.taskItem = item;
    [self.controllerID.navigationController pushViewController:taskCalendarVC animated:YES];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [TaskModel moveTaskItemIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }

}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}


-(UITableView *)taskTableView{
    if(_taskTableView == nil){
        _taskTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _taskTableView.backgroundColor = view_backgroundColor;
        _taskTableView.dataSource = self;
        _taskTableView.delegate = self;
        _taskTableView.tableHeaderView = self.taskHeadView;
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
