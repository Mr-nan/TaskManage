//
//  NSString+StringTool.m
//  TaskManage
//
//  Created by zhengnan on 2018/3/28.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "NSString+StringTool.h"

@implementation NSString (StringTool)

-(CGSize)getStringSizeFont:(UIFont *)font{
    
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}

-(CGSize)getStringSizeFont:(UIFont *)font MaxWidth:(CGFloat)maxWidth{
    
    return [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,  nil]
                              context:nil].size;
}

-(CGRect)getStringRectFont:(UIFont *)font MaxSize:(CGSize)maxSize{
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading attributes: @{NSFontAttributeName:font} context:nil];
}

@end
