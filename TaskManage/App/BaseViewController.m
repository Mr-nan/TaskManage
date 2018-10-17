//
//  BaseViewController.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/24.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property(nonatomic,strong) UILabel *navigationTitleLabel;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = view_backgroundColor;
    
}

-(void)setTitle:(NSString *)title{
    
    self.navigationTitleLabel.text = title;
    [self.navigationTitleLabel sizeToFit];
    self.navigationItem.titleView = self.navigationTitleLabel;
    
}

-(UILabel *)navigationTitleLabel{
    if(_navigationTitleLabel == nil){
        _navigationTitleLabel = [[UILabel alloc]init];
        _navigationTitleLabel.textColor = [UIColor whiteColor];
        _navigationTitleLabel.textAlignment = NSTextAlignmentCenter;
        _navigationTitleLabel.font = [UIFont fontWithName:@"Courier" size:18];
        [_navigationTitleLabel sizeToFit];
    }
    return _navigationTitleLabel;
}


@end
