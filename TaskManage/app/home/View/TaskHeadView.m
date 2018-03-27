//
//  TaskHeadView.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/24.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TaskHeadView.h"
#import "AddTaskViewController.h"
@interface TaskHeadView()

@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) UIView *addTaskView;

@end

@implementation TaskHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        [self createUI];
    }
    return self;
}

-(void)createUI{
    [self addSubview:self.titleView];
    [self addSubview:self.addTaskView];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.top.equalTo(self).with.offset(0);
        make.height.with.offset(44);
    }];
    
    [self.addTaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(0);
        make.height.with.offset(49);
        make.width.with.offset(self.width);
    }];
    
}

-(void)addTaskAction{
    
    AddTaskViewController *addTaskVC = [[AddTaskViewController alloc]init];
    [self.controllerID.navigationController pushViewController:addTaskVC animated:YES];
}

-(UIView *)titleView
{
    if(_titleView == nil){
        
        _titleView = [[UIView alloc]init];
        _titleView.backgroundColor=[UIColor redColor];

    }
    return _titleView;
}

-(UIView *)addTaskView
{
    if(_addTaskView == nil){
        _addTaskView = [[UIView alloc]init];
        _addTaskView.backgroundColor = [UIColor orangeColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addTaskAction)];
        [_addTaskView addGestureRecognizer:tap];
        
        UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        addLabel.font = [UIFont systemFontOfSize:15];
        addLabel.textColor = [UIColor whiteColor];
        addLabel.text = @"+ 添加自己的小目标";
        [_addTaskView addSubview:addLabel];
        [addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_addTaskView);
        }];
    }
    return _addTaskView;
}

@end
