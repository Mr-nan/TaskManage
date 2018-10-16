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

+(NSMutableArray *)getTaskModelArray{
    
    
    NSMutableArray *taskArray = [TaskModel defaultTaskModel].taskModelArray ;
    
    if(taskArray.count>1){
        
        return (NSMutableArray *) [[taskArray reverseObjectEnumerator] allObjects];
        
    }
    
   return  taskArray;
    
}

+(void)addTaskItem:(TaskItem *)taskItem{
    
    NSMutableArray *taskModelArray = [TaskModel defaultTaskModel].taskModelArray;
    [taskModelArray addObject:taskItem];
    BOOL sucess = [NSKeyedArchiver archiveRootObject:taskModelArray toFile:kPath];
    if(sucess){
        ZNLog(@"归档成功");
    }else{
        ZNLog(@"归档失败");
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
        ZNLog(@"归档成功");
    }else{
        ZNLog(@"归档失败");
    }
}

+(void)moveTaskItemIndex:(NSInteger)index{
    
    NSMutableArray *taskModelArray = [TaskModel defaultTaskModel].taskModelArray;
    if(index>taskModelArray.count) return;
    [taskModelArray removeObjectAtIndex:taskModelArray.count - (index+1)];
    
    BOOL sucess = [NSKeyedArchiver archiveRootObject:taskModelArray toFile:kPath];
    if(sucess){
        ZNLog(@"归档成功");
    }else{
        ZNLog(@"归档失败");
    }
    
}



@end



