//
//  TaskHeadView.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/24.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TaskHeadView.h"

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
    
    [self.titleView ];
    
}

-(UIView *)titleView
{
    if(_titleView == nil){
        
        _titleView = [[UIView alloc]init];

    }
    return _titleView;
}

-(UIView *)addTaskView
{
    if(_addTaskView == nil){
        _addTaskView = [[UIView alloc]init];
    }
    return _addTaskView;
}

@end
