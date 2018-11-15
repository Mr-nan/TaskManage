//
//  TodayViewController.m
//  TaskWidget
//
//  Created by zhengnan on 2018/10/24.
//  Copyright © 2018 zn. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "TaskCell.h"

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *addButton;


@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);
    [self setUI];
}

-(void)setUI{
  
    self.titleLabel.text = @"给自己新增一个Task吧";
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.addButton];
    
}

- (void)buttonClick:(UIButton *)sender {
    
    
    if(sender.tag ==0){
        NSURL *url = [NSURL URLWithString:@"taskManage://add"];
        [self.extensionContext openURL:url completionHandler:nil];

    }else{
        NSURL *url = [NSURL URLWithString:@"taskManage://right"];
        [self.extensionContext openURL:url completionHandler:nil];

    }
}



-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, self.preferredContentSize.width - 30, 30)];
//        _titleLabel.backgroundColor = [UIColor yellowColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        
    }
    return _titleLabel;
}

-(UIButton *)addButton{
    if(!_addButton){
        UIImage *addImage = [UIImage imageNamed:@"add"];
        _addButton = [[UIButton alloc]initWithFrame:CGRectMake((self.preferredContentSize.width-addImage.size.width)/2, 50, addImage.size.width, addImage.size.height)];
        _addButton.tag = 0;
        [_addButton setBackgroundImage:addImage forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}


@end
