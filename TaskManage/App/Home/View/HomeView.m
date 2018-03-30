//
//  HomeView.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/24.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "HomeView.h"
#import "TaskModel.h"

@interface HomeView ()<UITableViewDelegate,UITableViewDataSource>




@end

@implementation HomeView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addTaskReloadAction) name:@"addTaskReloadAction" object:nil];
        [self addSubview:self.taskTableView];
        self.backgroundColor =[UIColor colorWithRed:0.90f green:0.96f blue:0.98f alpha:1.00f];
        
    }
    return self;
}

#pragma mark -tableViewDelegate

-(void)addTaskReloadAction{
    
    [self.taskTableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [TaskModel getTaskModelArray].count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    TaskItem *item = [[TaskModel getTaskModelArray]objectAtIndex:indexPath.row];
    cell.textLabel.text = item.taskName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"开始时间:%@--结束时间:%@",item.taskStartDate,item.taskStopDate];
    return cell;
}

-(UITableView *)taskTableView{
    if(_taskTableView == nil){
        _taskTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _taskTableView.backgroundColor = [UIColor colorWithRed:0.90f green:0.96f blue:0.98f alpha:1.00f];
        _taskTableView.dataSource = self;
        _taskTableView.delegate = self;
        _taskTableView.tableHeaderView = self.taskHeadView;
    }
    return _taskTableView;
}

-(UIView *)taskHeadView{
    if(_taskHeadView == nil){
        _taskHeadView = [[TaskHeadView alloc]initWithFrame:CGRectMake(0, 0,self.width,self.height * 0.5)];
        _taskHeadView.backgroundColor =[UIColor colorWithRed:0.29f green:0.75f blue:0.96f alpha:1.00f];
    }
    return _taskHeadView;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end
