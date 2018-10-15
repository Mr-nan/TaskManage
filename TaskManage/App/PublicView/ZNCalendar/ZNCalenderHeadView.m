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
    _title = title;
    self.titleLbael.text = title;
    [self addSubview:self.titleLbael];
    [self addSubview:self.weekView];
}

-(UILabel *)titleLbael{
    if(!_titleLbael){
        _titleLbael = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        _titleLbael.textColor = [UIColor whiteColor];
        _titleLbael.textAlignment = NSTextAlignmentCenter;
        _titleLbael.font = [UIFont systemFontOfSize:15];
    }
    return _titleLbael;
}

-(UIView *)weekView{
    if(!_weekView){
        _weekView = [[UIView alloc]initWithFrame:CGRectMake(0, 20,SCREEN_WIDTH,40)];
        NSArray *titleArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
        CGFloat weekItemWidth = (SCREEN_WIDTH)/ 7.0f;
        for (int i=0; i<7; i++) {
            UILabel *weekItem = [[UILabel alloc]initWithFrame:CGRectMake(i*weekItemWidth,0, weekItemWidth, 40)];
            weekItem.textAlignment = NSTextAlignmentCenter;
            weekItem.font = [UIFont systemFontOfSize:13];
            weekItem.textColor = [UIColor whiteColor];
            weekItem.text = titleArray[i];
            [_weekView addSubview:weekItem];
        }
    }
    return _weekView;
}

@end
