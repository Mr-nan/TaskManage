//
//  MBProgressHUDTool.h
//  TaskManage
//
//  Created by zhengnan on 2018/10/19.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface MBProgressHUDTool : NSObject

+(void)showToastTitle:(NSString *)title;
+(void)showToastTitle:(NSString *)title andToView:(UIView *)toView;

+(MBProgressHUD *)showLoad;
+(MBProgressHUD *)showLoadTitle:(NSString *)title;
+(MBProgressHUD *)showLoadTitle:(NSString *)title andToView:(UIView *)toView;

+(void)showCustomView:(UIView *)view;
+(void)showCustomView:(UIView *)view andToView:(UIView *)toView;

@end

