//
//  ZNDatePickerView.h
//  TaskManage
//
//  Created by zhengnan on 2018/3/28.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNDatePickerView : UIView

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSDate *currentDate;
@property (nonatomic,strong) void(^datePickerBlock)(NSString *title,NSInteger dateToolButtonType,NSDate *date); // dateToolButtonType:0-取消，1-确定

@end
