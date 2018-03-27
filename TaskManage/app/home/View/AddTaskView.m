//
//  AddTaskView.m
//  TaskManage
//
//  Created by zhengnan on 2018/3/27.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "AddTaskView.h"
#import "AddTaskCell.h"
#define addTaskTitleArray (@[@{@"title":@"名称",@"type":@"input",@"height":[NSNumber numberWithFloat:50]},@{@"title":@"图标",@"type":@"select",@"height":[NSNumber numberWithFloat:50]},@{@"title":@"开始时间",@"type":@"select",@"height":[NSNumber numberWithFloat:50]},@{@"title":@"结束时间",@"type":@"select",@"height":[NSNumber numberWithFloat:50]},@{@"title":@"备注",@"type":@"remark",@"height":[NSNumber numberWithFloat:100]}])

@interface AddTaskView()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong) UIButton *addTaskButton;


@end

@implementation AddTaskView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        [self addSubview:self.addTaskTableView];
        
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return addTaskTitleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *number = addTaskTitleArray[indexPath.row][@"height"];
    return number.floatValue;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell = [[AddTaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.cellData = addTaskTitleArray[indexPath.row];
    
    return cell;
}


-(UITableView *)addTaskTableView{
    if(_addTaskTableView == nil){
        _addTaskTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _addTaskTableView.delegate = self;
        _addTaskTableView.dataSource = self;
        _addTaskTableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.00f];
        
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        [footView addSubview:self.addTaskButton];
        [self.addTaskButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(footView);
            make.left.equalTo(footView).with.offset(25);
            make.right.equalTo(footView).with.offset(-25);
            make.height.with.offset(50);
        }];
        
        _addTaskTableView.tableFooterView = footView;
        
    }
    return _addTaskTableView;
}

-(UIButton *)addTaskButton
{
    if(_addTaskButton == nil){
        
        _addTaskButton = [[UIButton alloc]init];
        _addTaskButton.backgroundColor = [UIColor colorWithRed:0.29f green:0.75f blue:0.96f alpha:1.00f];
        _addTaskButton.layer.masksToBounds = YES;
        _addTaskButton.layer.cornerRadius = 10;
        _addTaskButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_addTaskButton setTitle:@"+添加到小目标栏" forState:UIControlStateNormal];
        [_addTaskButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }
    return _addTaskButton;
}

@end
