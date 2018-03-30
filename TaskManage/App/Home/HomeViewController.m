//
//  HomeViewController.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/24.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"
@interface HomeViewController ()
@property (nonatomic,strong) HomeView *homeView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = self.homeView;
    
}


-(HomeView *)homeView{
    if (_homeView==nil) {
        _homeView = [[HomeView alloc]initWithFrame:self.view.bounds];
        _homeView.taskHeadView.controllerID = self;
        
    }
    return _homeView;
}


@end
