//
//  TaskItem.h
//  TaskManage
//
//  Created by zhengnan on 2018/3/30.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskItem : NSObject<NSCoding>

@property(nonatomic,strong) NSString *taskName;
@property(nonatomic,strong) NSString *taskIconName;
@property(nonatomic,strong) NSString *taskStartDate;
@property(nonatomic,strong) NSString *taskStopDate;
@property(nonatomic,strong) NSString *taskRemark;
@property(nonatomic,strong) NSString *taskSumDayNumber;
@property(nonatomic,strong) NSMutableArray *taskDateArray;

@end
