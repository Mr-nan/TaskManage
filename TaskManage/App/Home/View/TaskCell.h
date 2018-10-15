//
//  TaskCell.h
//  TaskManage
//
//  Created by 郑南 on 2018/3/24.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskItem.h"
#define  taskCellHeight ((SCREEN_WIDTH-50) * 0.47)

@interface TaskCell : UITableViewCell

@property (nonatomic,strong) TaskItem *cellItem;
@property (nonatomic,strong) void(^finisTaskBlock)(TaskItem *finisTaskItem);


@end
