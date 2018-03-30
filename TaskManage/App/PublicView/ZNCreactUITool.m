//
//  ZNCreactUITool.m
//  TaskManage
//
//  Created by zhengnan on 2018/3/30.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "ZNCreactUITool.h"

@implementation ZNCreactUITool


+(UIAlertController *)creactAlertControllerTitle:(NSString *)title Message:(NSString *)message AlertAction:(void (^)(NSString *))alertAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
        [alert dismissViewControllerAnimated:YES completion:^{
            if(alertAction){
                alertAction(@"确定");
            }
        }];
    }]];
    return alert;
    
}

@end
