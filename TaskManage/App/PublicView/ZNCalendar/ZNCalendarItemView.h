//
//  ZNCalendarItemView.h
//  TaskManage
//
//  Created by zhengnan on 2018/4/20.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskItem.h"

@interface ZNCalendarItemView : UICollectionViewCell


@property(nonatomic,strong) TaskItem *taskItem;

-(void)setTitle:(NSString *)title andMonth:(NSString *)month;

@end
