//
//  ZNWaveView.m
//  TaskManage
//
//  Created by zhengnan on 2018/4/17.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "ZNWaveView.h"

#define KHWWaveFillColor [UIColor groupTableViewBackgroundColor] //填充颜色
#define KHWWaveTopColor [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1.0f] //前面波浪颜色
#define KHWWaveBottomColor [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:0.4f] //后面波浪颜色

@interface ZNWaveView()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat wave_amplitude;//振幅a（y = asin(wx+φ) + k）
@property (nonatomic, assign) CGFloat wave_cycle;//周期w
@property (nonatomic, assign) CGFloat wave_h_distance;//两个波水平之间偏移
@property (nonatomic, assign) CGFloat wave_v_distance;//两个波竖直之间偏移
@property (nonatomic, assign) CGFloat wave_scale;//水波速率
@property (nonatomic, assign) CGFloat wave_offsety;//波峰所在位置的y坐标
@property (nonatomic, assign) CGFloat wave_move_width;//移动的距离，配合速率设置
@property (nonatomic, assign) CGFloat wave_offsetx;//偏移
@property (nonatomic, assign) CGFloat offsety_scale;//上升的速度

@end

@implementation ZNWaveView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = frame.size.height *0.5;
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        self.layer.borderWidth = 2;
        self.layer.borderColor = KHWWaveBottomColor.CGColor;
        [self initInfo];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {

    [self drawWaveColor:KHWWaveTopColor offsetX:0 offsetY:0];
    [self drawWaveColor:KHWWaveBottomColor offsetX:_wave_h_distance offsetY:_wave_v_distance];
}

-(void)initInfo{
    _progress = 0 ;
    _wave_amplitude = self.frame.size.height / 25;
    _wave_cycle = 2 * M_PI / (self.frame.size.width * 0.9);
    _wave_h_distance = 2 * M_PI / _wave_cycle * 0.6;
    _wave_v_distance = _wave_amplitude * 0.4;
    _wave_move_width = 0.5;
    _wave_scale = 0.4;
    _offsety_scale = 0.1;
    _wave_offsety = (1-_progress) * (self.frame.size.height + 2 * _wave_amplitude);
    [self addDisplayLinkAction] ;
}

-(void)addDisplayLinkAction{
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)displayLinkAction{
    _wave_offsetx+=_wave_move_width * _wave_scale;
    
    //完成
    if(_wave_offsetx<=0.01){
        [self removeDisplayLinkAction];
    }
    
    [self setNeedsDisplay];
}

-(void)removeDisplayLinkAction{
    [_displayLink invalidate];
    _displayLink = nil;
}

-(void)drawWaveColor:(UIColor *)color offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY{
    
    CGFloat end_offY = (1 - _progress) * (self.frame.size.height + 2 * _wave_amplitude);
    if(_wave_offsety != end_offY){
        if(end_offY < _wave_offsety){
            _wave_offsety = MAX(_wave_offsety -=(_wave_offsety - end_offY) * _offsety_scale, end_offY);
        }else{
            _wave_offsety = MIN(_wave_offsety+=(end_offY - _wave_offsety) * _offsety_scale, end_offY);
        }
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (float next_x = 0.f; next_x <= self.frame.size.width; next_x++) {
        CGFloat next_y = _wave_amplitude *sin(_wave_cycle * next_x + _wave_offsetx +offsetX / self.bounds.size.width *2 *M_PI) + _wave_offsety +offsetY;
        
        if(next_x == 0){
            [path moveToPoint:CGPointMake(next_x, next_y - _wave_amplitude)];
        }else{
            [path addLineToPoint:CGPointMake(next_x, next_y - _wave_amplitude)];
        }
    }
    
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [color set];
    [path fill];
}


@end
