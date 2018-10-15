//
//  ZNNavigationController.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/24.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "ZNNavigationController.h"

@interface ZNNavigationController ()

@end

@implementation ZNNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = view_backgroundColor;
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setShadowImage:[[UIImage alloc]init]];//清楚导航下面的分割线
    self.navigationBar.translucent = NO;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    if(self.viewControllers.count>1){
        viewController.navigationItem.hidesBackButton = YES;
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStyleDone target:self action:@selector(navigationItemClick)];
        viewController.navigationItem.leftBarButtonItem = btnItem;
    }
}

-(void)navigationItemClick{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
