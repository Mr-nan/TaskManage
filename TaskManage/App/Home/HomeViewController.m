//
//  HomeViewController.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/24.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"
#import "SetViewController.h"
@interface HomeViewController ()
@property (nonatomic,strong) HomeView *homeView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Task";
    self.view = self.homeView;
    [self addNavigationButton];
}

-(void)navigationBtnClick{
    
    SetViewController *setVC = [[SetViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
}

-(void)addNavigationButton{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"更多"] style:UIBarButtonItemStyleDone target:self action:@selector(navigationBtnClick)];
    self.navigationItem.rightBarButtonItem = item;
}


-(HomeView *)homeView{
    if (_homeView==nil) {
        _homeView = [[HomeView alloc]initWithFrame:self.view.bounds];
        _homeView.controllerID = self;
        
    }
    return _homeView;
}



@end
