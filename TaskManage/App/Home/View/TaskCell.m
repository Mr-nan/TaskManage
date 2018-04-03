//
//  TaskCell.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/24.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TaskCell.h"

#define left_right_Gap 15
#define to_bottom_gap 10

@interface TaskCell()

@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *infoText;

@property (nonatomic,strong) UIView     *taskProgressView;
@property (nonatomic,strong) UIButton   *finishButton;


@end

@implementation TaskCell


-(void)setCellItem:(TaskItem *)cellItem{
    _cellItem = cellItem;
    CGSize titleSize = [cellItem.taskName getStringSizeFont:self.title.font MaxWidth:100];
    self.title.frame = CGRectMake(left_right_Gap, to_bottom_gap, titleSize.width, titleSize.height);
    self.title.text  = cellItem.taskName;
    
    CGSize infonSize = [cellItem.taskRemark getStringSizeFont:self.infoText.font MaxWidth:200];
    self.infoText.frame = CGRectMake(self.title.right+3, self.title.bottom-infonSize.height, infonSize.width, infonSize.height);
    self.infoText.text = cellItem.taskRemark;
    
    self.taskProgressView.backgroundColor = [UIColor orangeColor];
    [self.finishButton setBackgroundImage:[UIImage imageNamed:cellItem.taskIconName] forState:UIControlStateNormal];
}


-(UILabel *)title{
    if(_title == nil){
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_title];
    }
    return _title;
}

-(UILabel *)infoText{
    if(_infoText == nil){
        _infoText = [[UILabel alloc]init];
        _infoText.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_infoText];
    }
    return _infoText;
}

-(UIView *)taskProgressView{
    if(_taskProgressView == nil){
        _taskProgressView = [[UIView alloc]initWithFrame:CGRectMake(left_right_Gap, taskCellHeight - to_bottom_gap-30,self.finishButton.left-left_right_Gap-10, 30)];
        _taskProgressView.layer.cornerRadius = 15;
        [self.contentView addSubview:_taskProgressView];
    }
    return _taskProgressView;
}

-(UIButton *)finishButton{
    if(_finishButton == nil){
        _finishButton = [[UIButton alloc]init];
        _finishButton.frame = CGRectMake(SCREEN_WIDTH-left_right_Gap-35, (taskCellHeight-35)/2, 35, 35);
        [self.contentView addSubview:_finishButton];
    }
    return _finishButton;
}


@end
