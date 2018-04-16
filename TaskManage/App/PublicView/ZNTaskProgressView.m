//
//  ZNTaskProgressView.m
//  TaskManage
//
//  Created by zhengnan on 2018/4/16.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "ZNTaskProgressView.h"

@interface ZNTaskProgressView()

@property (nonatomic,strong) UIView *subProgressView;

@end

@implementation ZNTaskProgressView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.height / 2;
        self.layer.borderColor = [UIColor colorWithRed:0.29f green:0.75f blue:0.96f alpha:1.00f].CGColor;
        self.layer.borderWidth = 1;
        self.clipsToBounds = YES;
    }
    return self;
    
}


-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    if(progress){
        self.subProgressView.frame = CGRectMake(2, 2, self.width * progress-4, self.height-4);

    }else{
        self.subProgressView.frame = CGRectMake(0, 0, 0, 0);
    }
    self.subProgressView.layer.cornerRadius = self.subProgressView.height / 2;
    self.subProgressView.layer.masksToBounds = YES;
}

-(UIView *)subProgressView{
    if(!_subProgressView){
        _subProgressView = [[UIView alloc]init];
        _subProgressView.backgroundColor = [UIColor colorWithRed:0.29f green:0.75f blue:0.96f alpha:1.00f];
        [self addSubview:_subProgressView];

    }
    return _subProgressView;
}

@end
