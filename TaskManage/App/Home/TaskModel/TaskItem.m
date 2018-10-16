//
//  TaskItem.m
//  TaskManage
//
//  Created by zhengnan on 2018/3/30.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TaskItem.h"

@implementation TaskItem


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init])
    {
        self.taskName = [aDecoder decodeObjectForKey:@"taskName"];
        self.taskIsLose = [aDecoder decodeObjectForKey:@"taskIsLose"];
        self.taskIconName = [aDecoder decodeObjectForKey:@"taskIconName"];
        self.taskStartDate = [aDecoder decodeObjectForKey:@"taskStartDate"];
        self.taskStopDate = [aDecoder decodeObjectForKey:@"taskStopDate"];
        self.taskRemark = [aDecoder decodeObjectForKey:@"taskRemark"];
        self.taskSumDayNumber = [aDecoder decodeObjectForKey:@"taskSumDayNumber"];
        self.taskDateArray = [aDecoder decodeObjectForKey:@"taskDateArray"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.taskName forKey:@"taskName"];
    [aCoder encodeObject:self.taskIsLose forKey:@"taskIsLose"];
    [aCoder encodeObject:self.taskIconName forKey:@"taskIconName"];
    [aCoder encodeObject:self.taskStartDate forKey:@"taskStartDate"];
    [aCoder encodeObject:self.taskStopDate forKey:@"taskStopDate"];
    [aCoder encodeObject:self.taskRemark forKey:@"taskRemark"];
    [aCoder encodeObject:self.taskSumDayNumber forKey:@"taskSumDayNumber"];
    [aCoder encodeObject:self.taskDateArray forKey:@"taskDateArray"];

}


@end
