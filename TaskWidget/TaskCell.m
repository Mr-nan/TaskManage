//
//  TaskCell.m
//  TaskWidget
//
//  Created by zhengnan on 2018/11/12.
//  Copyright © 2018 zn. All rights reserved.
//

#import "TaskCell.h"

#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define left_gap 10
#define top_gap 10

@interface TaskCell()

@property (nonatomic,strong) UIImageView    *backImage;
@property (nonatomic,strong) UILabel        *title;
@property (nonatomic,strong) UILabel        *taskInfo;
@property (nonatomic,strong) UILabel        *taskProgress;
@property (nonatomic,strong) UILabel        *taskTime;
@property (nonatomic,strong) UIButton       *taskButton;

@end

@implementation TaskCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self.contentView addSubview:self.backImage];
        [self.backImage addSubview:self.title];
        [self.backImage addSubview:self.taskInfo];
        [self.backImage addSubview:self.taskProgress];
        [self.backImage addSubview:self.taskTime];
        [self.backImage addSubview:self.taskButton];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

-(UIImageView *)backImage{
    if(!_backImage){
        _backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"任务背景1"]];
        _backImage.frame = CGRectMake(25, 0, SCREEN_WIDTH - 50, 113);
       
        
    }
    return _backImage;
}

-(UILabel *)title{
    if(!_title){
        _title = [[UILabel alloc]initWithFrame:CGRectMake(left_gap, top_gap, self.backImage.frame.size.width - 2*left_gap, 20)];
        _title.backgroundColor = [UIColor cyanColor];
        _title.textColor = [UIColor whiteColor];
        _title.font = [UIFont systemFontOfSize:15];
        _title.text = @"task name";
    }
    return _title;
}


-(UILabel *)taskInfo{
    if(!_taskInfo){
        _taskInfo = [[UILabel alloc]initWithFrame:CGRectMake(left_gap, self.title.frame.size.height + self.title.frame.origin.y,self.title.frame.size.width, 40)];
        _taskInfo.backgroundColor = [UIColor cyanColor];
        _taskInfo.textColor = [UIColor whiteColor];
        _taskInfo.font = [UIFont systemFontOfSize:13];
        _taskInfo.text = @"task info content";
    }
    return _taskInfo;
}

-(UILabel *)taskProgress{
    if(!_taskProgress){
        _taskProgress = [[UILabel alloc]initWithFrame:CGRectMake(left_gap, self.taskInfo.frame.size.height + self.taskInfo.frame.origin.y,self.title.frame.size.width, 20)];
        _taskProgress.backgroundColor = [UIColor cyanColor];
        _taskProgress.textColor = [UIColor whiteColor];
        _taskProgress.font = [UIFont systemFontOfSize:13];
        _taskProgress.text = @"task progress 10/20天";
    }
    return _taskProgress;
}

-(UILabel *)taskTime{
    if(!_taskTime){
        _taskTime = [[UILabel alloc]initWithFrame:CGRectMake(left_gap, self.taskProgress.frame.size.height + self.taskProgress.frame.origin.y,self.title.frame.size.width, 20)];
        _taskTime.backgroundColor = [UIColor cyanColor];
        _taskTime.textColor = [UIColor whiteColor];
        _taskTime.font = [UIFont systemFontOfSize:13];
        _taskTime.text = @"task time: 2018-11-09 --无限期";
    }
    return _taskTime;
}

-(UIButton *)taskButton{
    if(!_taskButton){
        _taskButton = [[UIButton alloc]initWithFrame:CGRectMake(self.backImage.frame.size.width - 110, self.backImage.frame.size.height - 40, 100, 30)];
        _taskButton.backgroundColor = [UIColor whiteColor];
        [_taskButton setTitle:@"今日完成" forState:UIControlStateNormal];
        _taskButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _taskButton.layer.cornerRadius = 3;
        _taskButton.layer.masksToBounds = YES;
    }
    return _taskButton;
}

@end
