//
//  TaskCell.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/24.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TaskCell.h"
#import "ZNTaskProgressView.h"
#define left_right_Gap 15
#define to_bottom_gap 10

@interface TaskCell()

@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *infoText;

@property (nonatomic,strong) ZNTaskProgressView     *taskProgressView;
@property (nonatomic,strong) UILabel    *taskInfiniteLabel;
@property (nonatomic,strong) UIButton   *finishButton;


@end

@implementation TaskCell


-(void)setCellItem:(TaskItem *)cellItem{
    _cellItem = cellItem;
    
    ZNLog(@"%@: %@---%ld",cellItem.taskName,cellItem.taskSumDayNumber,cellItem.taskDateArray.count);
    
    CGFloat titleMaxWidth = SCREEN_WIDTH - left_right_Gap * 2 - self.finishButton.width - 10;
    if(cellItem.taskRemark.length>0){
        titleMaxWidth = 100;
    }
    
    CGSize titleSize = [cellItem.taskName getStringSizeFont:self.title.font MaxWidth:titleMaxWidth];
    self.title.frame = CGRectMake(left_right_Gap, to_bottom_gap, titleSize.width, 30);
    self.title.text  = cellItem.taskName;
    
    CGFloat remarkMaxWidth = SCREEN_WIDTH - self.title.width - self.finishButton.width - left_right_Gap * 2-5;
    CGSize infonSize = [cellItem.taskRemark getStringSizeFont:self.infoText.font MaxWidth:remarkMaxWidth];
    self.infoText.frame = CGRectMake(self.title.right+3, to_bottom_gap, infonSize.width, 30);
    self.infoText.text = cellItem.taskRemark;
    
    if([cellItem.taskStopDate isEqualToString:@"无限期"]){
        [self.taskProgressView setHidden:YES];
        [self.taskInfiniteLabel setHidden:NO];
        self.taskInfiniteLabel.text = [NSString stringWithFormat:@"坚持%ld天 / 无限期",cellItem.taskDateArray.count];
    }else if(cellItem.taskSumDayNumber){
        [self.taskProgressView setHidden:NO];
        [self.taskInfiniteLabel setHidden:YES];
        self.taskProgressView.progress = cellItem.taskDateArray.count / [cellItem.taskSumDayNumber floatValue];
    }
    
    [self.finishButton setBackgroundImage:[UIImage imageNamed:cellItem.taskIconName] forState:UIControlStateNormal];
    if(cellItem.taskDateArray.count>0){
        if([cellItem.taskStopDate isEqualToString:@"无限期"]){
            
            if([NSDate compareDateStr:[NSDate getDateString:@"yyyy-MM-dd"] withNewDateStr:[cellItem.taskDateArray lastObject]]==-1){
                [self.finishButton setHidden:NO];
                
            }else{
                [self.finishButton setHidden:YES];
            }
            
        }else{
            
            if([NSDate compareDateStr:[NSDate getDateString:@"yyyy-MM-dd"] withNewDateStr:cellItem.taskStartDate]==-1){
                [self.finishButton setHidden:YES];

            }else{
                if([NSDate compareDateStr:[NSDate getDateString:@"yyyy-MM-dd"] withNewDateStr:[cellItem.taskDateArray lastObject]]==-1){
                    [self.finishButton setHidden:NO];
                    
                }else{
                    [self.finishButton setHidden:YES];
                }
            }
            
        }
        
    }else{
        [self.finishButton setHidden:NO];
    }
    
    
    
  
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
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:18];
//        _title.backgroundColor = [UIColor yellowColor];
        _title.numberOfLines = 1;
        [self.contentView addSubview:_title];
    }
    return _title;
}

-(UILabel *)infoText{
    if(_infoText == nil){
        _infoText = [[UILabel alloc]init];
        _infoText.font = [UIFont systemFontOfSize:13];
//        _infoText.backgroundColor = [UIColor orangeColor];
        _infoText.numberOfLines = 1;
        [self.contentView addSubview:_infoText];
    }
    return _infoText;
}

-(UIView *)taskProgressView{
    if(_taskProgressView == nil){
        _taskProgressView = [[ZNTaskProgressView alloc]initWithFrame:CGRectMake(left_right_Gap, 50,self.finishButton.left-left_right_Gap-50, 20)];
        _taskProgressView.layer.cornerRadius = 10;
        [self.contentView addSubview:_taskProgressView];
    }
    return _taskProgressView;
}

-(UIButton *)finishButton{
    if(_finishButton == nil){
        _finishButton = [[UIButton alloc]init];
        _finishButton.frame = CGRectMake(SCREEN_WIDTH-left_right_Gap-35, (taskCellHeight-35)/2, 35, 35);
        [_finishButton addTarget:self action:@selector(finisTaskBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_finishButton];
    }
    return _finishButton;
}

-(UILabel *)taskInfiniteLabel{
    if(_taskInfiniteLabel == nil){
        _taskInfiniteLabel = [[UILabel alloc]initWithFrame:CGRectMake(left_right_Gap,50,self.finishButton.left-left_right_Gap-50, 20)];
        _taskInfiniteLabel.font = [UIFont systemFontOfSize:14];
        _taskInfiniteLabel.textColor = [UIColor colorWithRed:0.29f green:0.75f blue:0.96f alpha:1.00f];
        [self.contentView addSubview:_taskInfiniteLabel];
    }
    return _taskInfiniteLabel;
}

@end
