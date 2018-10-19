//
//  MBProgressHUDTool.m
//  TaskManage
//
//  Created by zhengnan on 2018/10/19.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "MBProgressHUDTool.h"

@implementation MBProgressHUDTool


+(UIView *)getWindowRootView{
    return [UIApplication sharedApplication].delegate.window.rootViewController.view;
}

+(void)showToastTitle:(NSString *)title{
    
    [MBProgressHUDTool showToastTitle:title andToView:[MBProgressHUDTool getWindowRootView]];
}

+(void)showToastTitle:(NSString *)title andToView:(UIView *)toView{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    [hud hideAnimated:YES afterDelay:3.f];
}


+(MBProgressHUD *)showLoad{
    return [MBProgressHUDTool showLoadTitle:nil];
}

+(MBProgressHUD *)showLoadTitle:(NSString *)title{
    
    return [MBProgressHUDTool showLoadTitle:title andToView:[MBProgressHUDTool getWindowRootView]];
}

+(MBProgressHUD *)showLoadTitle:(NSString *)title andToView:(UIView *)toView{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    if(title.length){
        hud.label.text = title;
    }
    return hud;
    
}

+(void)showCustomView:(UIView *)view{
    [MBProgressHUDTool showCustomView:view andToView:[MBProgressHUDTool getWindowRootView]];
}

+(void)showCustomView:(UIView *)view andToView:(UIView *)toView{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = view;
    hud.square = YES;
    [hud hideAnimated:YES afterDelay:3.f];
}

@end
