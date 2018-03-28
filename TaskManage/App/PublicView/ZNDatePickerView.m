//
//  ZNDatePickerView.m
//  TaskManage
//
//  Created by zhengnan on 2018/3/28.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "ZNDatePickerView.h"

@interface ZNDatePickerView()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,strong) UIView *dateToolView;

@end

@implementation ZNDatePickerView

-(instancetype)init{
    self = [super init];
    if(self){
        self.frame = SCREEN_BOUNDS;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self addSubview:self.dateToolView];
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

-(void)dateChange:(UIDatePicker *)datePicker{
    
    _currentDate = datePicker.date;
    
}

-(void)setCurrentDate:(NSDate *)currentDate{
    _currentDate = currentDate;
    self.datePicker.minimumDate = _currentDate;
}

-(void)toolButtenAction:(UIButton *)btn{
    
    [self setHidden:YES];
    if(self.datePickerBlock){
        self.datePickerBlock(self.title,btn.tag, _currentDate);
    }
}

-(UIDatePicker *)datePicker{
    if(_datePicker == nil){
        _datePicker = [[UIDatePicker alloc]init];
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker setDate:[NSDate date] animated:YES];
        [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

-(UIView *)dateToolView{
    if(_dateToolView == nil){
        
        _dateToolView= [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 300, SCREEN_WIDTH, 300)];
        _dateToolView.backgroundColor = [UIColor whiteColor];
        self.datePicker.frame = CGRectMake(0, 50, SCREEN_WIDTH, 250);
        [_dateToolView addSubview:self.datePicker];
        
        UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        toolView.backgroundColor = [UIColor colorWithRed:0.88f green:0.95f blue:0.98f alpha:1.00f];
        [toolView addSubview:self.titleLabel];
        [_dateToolView addSubview:toolView];
        
        UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 90, 30)];
        cancelBtn.backgroundColor = [UIColor colorWithRed:0.23f green:0.69f blue:0.95f alpha:1.00f];
        cancelBtn.layer.cornerRadius = 10;
        cancelBtn.tag = 0;
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(toolButtenAction:) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:cancelBtn];
        
        UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 10, 90, 30)];
        confirmBtn.backgroundColor = [UIColor colorWithRed:0.23f green:0.69f blue:0.95f alpha:1.00f];
        confirmBtn.layer.cornerRadius = 10;
        confirmBtn.tag = 1;
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(toolButtenAction:) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:confirmBtn];
        
    }
    return _dateToolView;
}

-(UILabel *)titleLabel{
    if(_titleLabel == nil){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 120)/2, 5, 120, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:0.70f green:0.75f blue:0.78f alpha:1.00f];
    }
    return _titleLabel;
}

@end
