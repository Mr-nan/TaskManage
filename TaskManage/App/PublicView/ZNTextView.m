//
//  ZNTextView.m
//  TaskManage
//
//  Created by zhengnan on 2018/3/28.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "ZNTextView.h"

@interface ZNTextView()

@end

@implementation ZNTextView

-(instancetype)init{
    if(self=[super init]){
        [self initPlaceholder];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initPlaceholder];

    }
    return self;
}

-(void)initPlaceholder{
    self.font = [UIFont systemFontOfSize:15];
    self.placeholderColor = [UIColor colorWithRed:0.70f green:0.75f blue:0.78f alpha:1.00f];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

-(void)textDidChange:(NSNotification *)note{
    [self setNeedsDisplay];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}

-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    if(self.hasText) return;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    [self.placeholder drawInRect:CGRectMake(0, 10, self.width, self.height) withAttributes:attrs];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
