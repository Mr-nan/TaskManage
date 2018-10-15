//
//  TaskCell.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/24.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TaskCell.h"
#import "ZNTaskProgressView.h"

#define left_right_Gap 40
#define to_bottom_gap 10
#define content_width (SCREEN_WIDTH - 80)

@interface TaskCell()

@property (nonatomic,strong) UIImageView    *backImage;
@property (nonatomic,strong) UILabel        *title;
@property (nonatomic,strong) UILabel        *infoText;
@property (nonatomic,strong) UILabel        *taskProgressLable;
@property (nonatomic,strong) UILabel        *taskTimeLabel;
@property (nonatomic,strong) UIButton       *finishButton;
@property (nonatomic,strong) UIButton       *taskCloseButton;


@end

@implementation TaskCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = view_backgroundColor;
        [self addSubview:self.backImage];
        [self addSubview:self.taskCloseButton];
        self.title.text = @"任务1";
        self.infoText.text = @"每天坚持一点点";
        self.taskProgressLable.text = @"1天/10天";
        self.taskTimeLabel.text = @"2018-09-01---2018-10-30";
        [self.finishButton setTitle:@"今日完成" forState: UIControlStateNormal];

    }
    return self;
}

-(void)setCellItem:(TaskItem *)cellItem{
    _cellItem = cellItem;
    
//    ZNLog(@"%@: %@---%ld",cellItem.taskName,cellItem.taskSumDayNumber,cellItem.taskDateArray.count);
    
}

-(void)finisTaskBtnClick:(UIButton *)btn{
    
    [btn setHidden:YES];
    if(self.finisTaskBlock){
        
        [_cellItem.taskDateArray addObject:[NSDate getDateString:@"yyyy-MM-dd"]];
        self.finisTaskBlock(_cellItem);
    }
    
}


-(UILabel *)title{
    if(_title == nil){
        _title = [[UILabel alloc]initWithFrame:CGRectMake(left_right_Gap, to_bottom_gap, content_width-25, 30)];
        _title.font = [UIFont systemFontOfSize:18];
        _title.textColor = [UIColor whiteColor];
//        _title.backgroundColor = [UIColor yellowColor];
        _title.numberOfLines = 1;
        [self addSubview:_title];
    }
    return _title;
}

-(UILabel *)infoText{
    if(_infoText == nil){
        _infoText = [[UILabel alloc]initWithFrame:CGRectMake(left_right_Gap, self.title.bottom+5, content_width, 20)];
        _infoText.font = [UIFont systemFontOfSize:13];
        _infoText.textColor = [UIColor whiteColor];
//        _infoText.backgroundColor = [UIColor orangeColor];
        _infoText.numberOfLines = 1;
        [self addSubview:_infoText];
    }
    return _infoText;
}

-(UILabel *)taskProgressLable{
    
    if(!_taskProgressLable){
        _taskProgressLable = [[UILabel alloc]initWithFrame:CGRectMake(left_right_Gap, self.infoText.bottom+10, content_width, 20)];
        _taskProgressLable.font = [UIFont systemFontOfSize:13];
        _taskProgressLable.numberOfLines=1;
        _taskProgressLable.textColor = [UIColor whiteColor];
        [self addSubview:_taskProgressLable];
    }
    return _taskProgressLable;
    
}
-(UIButton *)finishButton{
    if(_finishButton == nil){
        _finishButton = [[UIButton alloc]init];
        _finishButton.frame = CGRectMake(SCREEN_WIDTH - 120, (taskCellHeight- 30)/2, 80, 30);
        _finishButton.backgroundColor = [UIColor whiteColor];
        _finishButton.layer.cornerRadius = 5;
        _finishButton.layer.masksToBounds = YES;
        _finishButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_finishButton setTitleColor:[UIColor colorWithRed:98/255.0f green:98/255.0f blue:98/255.0f alpha:1] forState:UIControlStateNormal];
        [_finishButton addTarget:self action:@selector(finisTaskBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_finishButton];
    }
    return _finishButton;
}

-(UILabel *)taskTimeLabel{
    if(_taskTimeLabel == nil){
        _taskTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(left_right_Gap,taskCellHeight - to_bottom_gap - 20 ,content_width, 20)];
        _taskTimeLabel.font = [UIFont systemFontOfSize:13];
        _taskTimeLabel.textColor = [UIColor whiteColor];
        [self addSubview:_taskTimeLabel];
    }
    return _taskTimeLabel;
}

-(UIButton *)taskCloseButton{
    if(!_taskCloseButton){
        _taskCloseButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-55, to_bottom_gap, 15, 15)];
        [_taskCloseButton setBackgroundImage:[UIImage imageNamed:@"关闭按钮"] forState:UIControlStateNormal];
    }
    return _taskCloseButton;
}

-(UIImageView *)backImage{
    if(!_backImage){
        _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(25, 0, SCREEN_WIDTH - 50, taskCellHeight)];
        _backImage.image = [UIImage imageNamed:@"任务背景1"];
    }
    return _backImage;
}

@end
