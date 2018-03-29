//
//  SelectIconCell.m
//  TaskManage
//
//  Created by zhengnan on 2018/3/29.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "SelectIconCell.h"

@interface SelectIconCell()

@property(nonatomic,strong)UIImageView *iconIamgeView;

@end

@implementation SelectIconCell


-(void)setIconName:(NSString *)iconName{
    _iconName = iconName;
    
    self.iconIamgeView.image = [UIImage imageNamed:iconName];
   
}

-(UIImageView *)iconIamgeView{
    if(_iconIamgeView == nil){
        
        _iconIamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
        [self addSubview:_iconIamgeView];
    }
    return _iconIamgeView;
}

@end
