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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)setTitle:(NSString *)title{
    
    CGSize size = [title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.navigationTitleLabel.font} context:nil].size;
    self.navigationTitleLabel.frame = CGRectMake(0, 0, size.width, size.height);
    self.navigationTitleLabel.text = title;
    self.navigationItem.titleView = self.navigationTitleLabel;
    
}

-(UILabel *)navigationTitleLabel{
    if(_navigationTitleLabel == nil){
        
        _navigationTitleLabel = [[UILabel alloc]init];
        _navigationTitleLabel.textColor = [UIColor whiteColor];
        _navigationTitleLabel.textAlignment = NSTextAlignmentCenter;
        _navigationTitleLabel.font = [UIFont fontWithName:@"Courier" size:18];
    }
    return _navigationTitleLabel;
}


@end
