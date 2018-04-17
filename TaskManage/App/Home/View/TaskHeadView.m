//
//  TaskHeadView.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/24.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TaskHeadView.h"
#import "AddTaskViewController.h"
#import "ZNWaveView.h"
@interface TaskHeadView()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *addTaskView;
@property (nonatomic,strong) ZNWaveView *waveView;

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
    [self addSubview:self.titleLabel];
    [self addSubview:self.addTaskView];
    [self addSubview:self.waveView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.top.equalTo(self).with.offset(10);
        make.height.with.offset(44);
    }];
    
    [self.addTaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(0);
        make.height.with.offset(49);
        make.width.with.offset(self.width);
    }];
    
    self.waveView.progress = 0.5;
}

-(void)addTaskAction{
    
    AddTaskViewController *addTaskVC = [[AddTaskViewController alloc]init];
    [self.controllerID.navigationController pushViewController:addTaskVC animated:YES];
}

-(UILabel *)titleLabel
{
    if(_titleLabel == nil){
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor colorWithRed:0.29f green:0.75f blue:0.96f alpha:1.00f];
//        _titleLabel.text = @"不积跬步，无以至千里；不积小流，无以成江海";
        _titleLabel.layer.cornerRadius = 5;
        _titleLabel.layer.masksToBounds = YES;
        
    }
    return _titleLabel;
}

-(UIView *)addTaskView
{
    if(_addTaskView == nil){
        _addTaskView = [[UIView alloc]init];
        _addTaskView.layer.borderWidth = 1;
        _addTaskView.layer.borderColor = [UIColor colorWithRed:0.88f green:0.95f blue:0.98f alpha:1.00f].CGColor;
        _addTaskView.backgroundColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addTaskAction)];
        [_addTaskView addGestureRecognizer:tap];
        
        UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        addLabel.font = [UIFont systemFontOfSize:15];
        addLabel.textColor = [UIColor colorWithRed:0.23f green:0.69f blue:0.95f alpha:1.00f];
        addLabel.text = @"+ 添加自己的小目标";
        [_addTaskView addSubview:addLabel];
        [addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_addTaskView);
        }];
    }
    return _addTaskView;
}

-(ZNWaveView *)waveView{
    if(!_waveView){
        _waveView = [[ZNWaveView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
        _waveView.center = self.center;
    }
    return _waveView;
}

@end
