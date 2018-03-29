//
//  ZNSelectIconView.h
//  TaskManage
//
//  Created by zhengnan on 2018/3/29.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNSelectIconView : UIView

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSArray *iconNameArray;
@property(nonatomic,strong) void(^selectIconAction)(UIImage *iamge,NSString *iamgeName);

@end
