//
//  TaskModel.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/29.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TaskModel.h"

#define kPath ([[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"taskModel.plist"])


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
    
   return  [[self class] defaultTaskModel].taskModelArray;
    
}

+(void)addTaskItem:(TaskItem *)taskItem{
    
    NSMutableArray *taskModelArray = [TaskModel getTaskModelArray];
    [taskModelArray addObject:taskItem];
    ZNLog(@"%@",taskModelArray);
    ZNLog(@"=%@",kPath);
    
    BOOL sucess = [NSKeyedArchiver archiveRootObject:taskModelArray toFile:kPath];
    if(sucess){
        ZNLog(@"归档成功");
    }else{
        ZNLog(@"归档失败");
    }
}

+(void)moveTaskItemIndex:(NSInteger)index{
    
    NSMutableArray *taskModelArray = [TaskModel getTaskModelArray];
    if(index>taskModelArray.count) return;
    [taskModelArray removeObjectAtIndex:index];
    
    BOOL sucess = [NSKeyedArchiver archiveRootObject:taskModelArray toFile:kPath];
    if(sucess){
        ZNLog(@"归档成功");
    }else{
        ZNLog(@"归档失败");
    }
}



@end



