//
//  TaskModel.h
//  TaskManage
//
//  Created by 郑南 on 2018/3/29.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskItem.h"

@interface TaskModel : NSObject

+(NSMutableArray *)getTaskModelArray;

+(void)addTaskItem:(TaskItem *)taskItem;
+(void)setTaskItem:(TaskItem *)taskItem;
+(void)moveTaskItem:(TaskItem *)taskItem;
+(void)moveTaskLoseItem:(TaskItem *)taskItem;

+(void)showHintTask:(TaskItem *)taskItem;
@end



