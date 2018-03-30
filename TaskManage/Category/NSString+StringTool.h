//
//  NSString+StringTool.h
//  TaskManage
//
//  Created by zhengnan on 2018/3/28.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringTool)

-(CGSize)getStringSizeFont:(UIFont *)font;
-(CGSize)getStringSizeFont:(UIFont *)font MaxWidth:(CGFloat)maxWidth;
-(CGRect)getStringRectFont:(UIFont *)font MaxSize:(CGSize)maxSize;

// 去除字符串空格
-(NSString *)removWhitespace;

@end
