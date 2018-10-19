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
       

    }
    return self;
}

-(void)setCellItem:(TaskItem *)cellItem{
    
    [self.finishButton setHidden:YES];
    [self setTitleColor:[UIColor whiteColor]];
    self.backImage.image = [UIImage imageNamed:@"任务背景1"];

    _cellItem = cellItem;
    ZNLog(@"%@: %@---%lu",cellItem.taskName,cellItem.taskSumDayNumber,(unsigned long)cellItem.taskDateArray.count);
    self.title.text = cellItem.taskName;
    self.infoText.text = cellItem.taskRemark;
    if([cellItem.taskSumDayNumber isEqualToString:@"无限期"]){
        self.taskProgressLable.text = [NSString stringWithFormat:@"%lu天 / %@",(unsigned long)cellItem.taskDateArray.count,cellItem.taskSumDayNumber];

    }else{
        self.taskProgressLable.text = [NSString stringWithFormat:@"%lu天 / %@天",(unsigned long)cellItem.taskDateArray.count,cellItem.taskSumDayNumber];

    }
    self.taskTimeLabel.text = [NSString stringWithFormat:@"%@--%@",cellItem.taskStartDate,cellItem.taskStopDate];
    
    if([cellItem.taskIsLose isEqualToString:@"1"]){
        
        self.backImage.image = [UIImage imageNamed:@"任务背景2"];
        [self setTitleColor:[UIColor colorWithRed:98/255.0 green:98/255.0 blue:98/255.0 alpha:1.00f]];
        return;
    }
    
    if(cellItem.taskDateArray.count>0){
        
        NSString *taskFinallyDate = [cellItem.taskDateArray lastObject];
        ZNLog(@"%@",taskFinallyDate);
        if([NSDate compareDateStr:[NSDate getDateString:@"yyyy-MM-dd"] withNewDateStr:taskFinallyDate]==-1){
            [self.finishButton setHidden:NO];
        }
        
    }else{
        [self.finishButton setHidden:NO];
    }
    
}

-(void)setTitleColor:(UIColor *)titleColor{
    self.title.textColor = titleColor;
    self.infoText.textColor = titleColor;
    self.taskProgressLable.textColor = titleColor;
    self.taskTimeLabel.textColor = titleColor;
}

-(void)finisTaskBtnClick:(UIButton *)btn{
    
    [btn setHidden:YES];
    if(self.finisTaskBlock){
        
        NSString *currentDate = [NSDate getDateString:@"yyyy-MM-dd"];
        if([currentDate isEqualToString:[_cellItem.taskDateArray lastObject]])
        {
            return;
        }
        
        [_cellItem.taskDateArray addObject:currentDate];
        [TaskModel showHintTask:_cellItem];
        
        self.finisTaskBlock(_cellItem);
    }
    
}

-(void)closeTaskBtnClick{
    
    if(self.finishButton){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否删除" message:_cellItem.taskName preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.closeTaskBlocl(self->_cellItem);
        }]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
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
        [_finishButton setTitle:@"今日完成" forState: UIControlStateNormal];
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
        UIImage *image = [UIImage imageNamed:@"删除按钮"];
        _taskCloseButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-image.size.width-25, 0, image.size.width, image.size.height)];
        [_taskCloseButton setBackgroundImage:image forState:UIControlStateNormal];
        [_taskCloseButton addTarget:self action:@selector(closeTaskBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
