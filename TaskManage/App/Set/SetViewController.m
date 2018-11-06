//
//  SetViewController.m
//  TaskManage
//
//  Created by zhengnan on 2018/10/18.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "SetViewController.h"
#import "SetView.h"

@interface SetViewController ()

@property (nonatomic,strong) SetView *setView;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    self.view.backgroundColor = view_backgroundColor;
    [self.view addSubview:self.setView];
}

-(SetView *)setView{
    if(!_setView){
        _setView = [[SetView alloc]initWithFrame:self.view.bounds];
        _setView.viewController = self;
    }
    return _setView;
}


@end
