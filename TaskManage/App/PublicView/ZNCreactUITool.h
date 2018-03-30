//
//  ZNCreactUITool.h
//  TaskManage
//
//  Created by zhengnan on 2018/3/30.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZNCreactUITool : NSObject

+(UIAlertController *)creactAlertControllerTitle:(NSString *)title Message:(NSString *)message AlertAction:(void(^)(NSString *buttonTitle))alertAction;

@end
