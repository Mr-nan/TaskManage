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

@property (nonatomic,strong) ZNWaveView *waveView;
@property (nonatomic,strong) UIButton     *addView;

@end

@implementation TaskHeadView

-(instancetype)init{
    self = [super init];
    if(self){
        
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.frame = CGRectMake(0, 30,SCREEN_WIDTH, self.addView.bottom+30);
    [self addSubview:self.waveView];
    [self addSubview:self.addView];
}

-(UIButton *)addView
{
    if(!_addView){
        _addView = [[UIButton alloc]initWithFrame:CGRectMake(20, self.waveView.height +40, SCREEN_WIDTH-40, (SCREEN_WIDTH-40)*0.128)];
        [_addView setBackgroundImage:[UIImage imageNamed:@"添加按钮"] forState:0];
        
    }
    return _addView;
}

-(ZNWaveView *)waveView{
    if(!_waveView){
        _waveView = [[ZNWaveView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 0, 150, 150)];
    }
    return _waveView;
}

@end
