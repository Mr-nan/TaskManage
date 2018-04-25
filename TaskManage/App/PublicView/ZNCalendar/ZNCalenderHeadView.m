//
//  ZNCalenderHeadView.m
//  TaskManage
//
//  Created by zhengnan on 2018/4/23.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "ZNCalenderHeadView.h"

@interface ZNCalenderHeadView()

@property(nonatomic,strong) UILabel *titleLbael;
@property(nonatomic,strong) UIView *weekView;

@end

@implementation ZNCalenderHeadView

-(void)setTitle:(NSString *)title{
    
}

-(UIView *)weekView{
    if(!_weekView){
        _weekView = [[UIView alloc]initWithFrame:CGRectMake(0, 20,SCREEN_WIDTH,40)];
        for (int i=0; i<7; i++) {
            UILabel *weekItem = [[UILabel alloc]initWithFrame:CGRectMake(i*40+1, 20, SCREEN_WIDTH/7-6, 40)];
            weekItem.textAlignment = NSTextAlignmentCenter;
            weekItem.font = [UIFont systemFontOfSize:13];
            [_weekView addSubview:weekItem];
        
        }
    }
    return _weekView;
}

@end
