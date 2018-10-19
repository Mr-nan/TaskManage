//
//  TaskModel.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/29.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TaskModel.h"

#define kPath ([[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"taskModel.plist"])
#define klose_Path ([[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"taskLoseModel.plist"])



@interface TaskModel()

@property(nonatomic,strong) NSMutableArray *taskModelArray;
@property(nonatomic,strong) NSMutableArray *taskLoseModelArray;

@end

@implementation TaskModel

+(TaskModel *)defaultTaskModel{
    static TaskModel *taskModel = nil;
    @synchronized(self){
        
        if(!taskModel){
            taskModel = [[TaskModel alloc]init];
        }
    }
    return taskModel;
}

-(NSMutableArray *)taskModelArray{
    
    if(_taskModelArray==nil){
        if([[NSFileManager defaultManager] fileExistsAtPath:kPath]){
            _taskModelArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:kPath]];
            
        }else{
            _taskModelArray = [NSMutableArray array];
        }
    }
    
    return _taskModelArray;
}

-(NSMutableArray *)taskLoseModelArray{
    if(_taskLoseModelArray == nil){
        if([[NSFileManager defaultManager] fileExistsAtPath:klose_Path])
        {
            _taskLoseModelArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:klose_Path]];
        }else{
            _taskLoseModelArray = [NSMutableArray array];
        }
    }
    return _taskLoseModelArray;
}

+(NSMutableArray *)getTaskModelArray{
    
    NSMutableArray *taskArray = [TaskModel defaultTaskModel].taskModelArray;
    NSMutableArray *taskLoseArray = [TaskModel defaultTaskModel].taskLoseModelArray;
    
    for (NSInteger i=0; i<taskArray.count; i++) {
        TaskItem *item = [taskArray objectAtIndex:i];
        if(![item.taskStopDate isEqualToString:@"无限期"]){
            if([NSDate compareDateStr:item.taskStopDate withNewDateStr:[NSDate getDateString:@"yyyy-MM-dd"]]==1){
                item.taskIsLose = @"1";
                [TaskModel addTaskLoseItem:item];
                [taskArray removeObject:item];
                BOOL sucess = [NSKeyedArchiver archiveRootObject:taskArray toFile:kPath];
                if(sucess){
                    ZNLog(@"归档task成功");
                }else{
                    ZNLog(@"归档task失败");
                }
            }
        }
        
    }
    
    if(taskArray.count>1){
        
        taskArray =  (NSMutableArray *) [[taskArray reverseObjectEnumerator] allObjects];
    }
    
    if(taskLoseArray.count>1){
        
        taskLoseArray = (NSMutableArray *) [[taskLoseArray reverseObjectEnumerator] allObjects];
    }
    
    NSMutableArray *sumArray = [[NSMutableArray alloc]initWithArray:taskArray];
    [sumArray addObjectsFromArray:taskLoseArray];

   return  sumArray;
    
}

+(void)addTaskItem:(TaskItem *)taskItem{
    
    NSMutableArray *taskModelArray = [TaskModel defaultTaskModel].taskModelArray;
    [taskModelArray addObject:taskItem];
    BOOL sucess = [NSKeyedArchiver archiveRootObject:taskModelArray toFile:kPath];
    if(sucess){
        ZNLog(@"归档task成功");
    }else{
        ZNLog(@"归档task失败");
    }
}

+(void)addTaskLoseItem:(TaskItem *)taskItem{
    
    NSMutableArray *taskLoseModelArray = [TaskModel defaultTaskModel].taskLoseModelArray;
    [taskLoseModelArray addObject:taskItem];
    BOOL sucess = [NSKeyedArchiver archiveRootObject:taskLoseModelArray toFile:klose_Path];
    if(sucess){
        ZNLog(@"归档taskLose成功");
    }else{
        ZNLog(@"归档taskLose失败");
    }
}

+(void)setTaskItem:(TaskItem *)taskItem{
    
    NSMutableArray *taskModelArray = [TaskModel defaultTaskModel].taskModelArray;
    for (NSInteger i=0; i<taskModelArray.count; i++) {
        TaskItem *item = [taskModelArray objectAtIndex:i];
        if(item == taskItem){
            item = taskItem;
            break;
        }
    }
    BOOL sucess = [NSKeyedArchiver archiveRootObject:taskModelArray toFile:kPath];
    if(sucess){
        ZNLog(@"归档task成功");
    }else{
        ZNLog(@"归档task失败");
    }
}

+(void)moveTaskItem:(TaskItem *)taskItem{
    
    NSMutableArray *taskModelArray = [TaskModel defaultTaskModel].taskModelArray;
    [taskModelArray removeObject:taskItem];
    
    BOOL sucess = [NSKeyedArchiver archiveRootObject:taskModelArray toFile:kPath];
    if(sucess){
        ZNLog(@"归档task成功");
    }else{
        ZNLog(@"归档task失败");
    }
    
}

+(void)moveTaskLoseItem:(TaskItem *)taskItem{
    
    NSMutableArray *taskLoseModelArray = [TaskModel defaultTaskModel].taskLoseModelArray;
    [taskLoseModelArray removeObject:taskItem];
    
    BOOL sucess = [NSKeyedArchiver archiveRootObject:taskLoseModelArray toFile:klose_Path];
    if(sucess){
        ZNLog(@"归档taskLose成功");
    }else{
        ZNLog(@"归档taskLose失败");
    }
    
}

+(void)showHintTask:(TaskItem *)taskItem{
    
    NSString *hintTitle = nil;
    NSArray *hintTitleArray = @[
                                @"哇，离目标更近了",
                                @"加油哦，继续坚持！",
                                @"希望明天还能坚持",
                                @"干巴爹！",
                                @"给你赞个👍",
                                @"不错哦，不要放弃哦",
                                @"你已经超越了从前",
                                @"你每天都在改变哦",
                                @"是不是感觉到自己的变化？"
                                ];
    if(taskItem.taskDateArray.count==1){
        hintTitle = @"已经坚持了1天,好棒^_^";

    }else{
        hintTitle = hintTitleArray[arc4random()%hintTitleArray.count];
    }
    
    if(hintTitle.length){
        [MBProgressHUDTool showToastTitle:hintTitle];
    }
    
}



@end



