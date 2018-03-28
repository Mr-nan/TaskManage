//
//  AddTaskCell.h
//  TaskManage
//
//  Created by 郑南 on 2018/3/28.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNTextView.h"

@interface AddTaskCell : UITableViewCell

@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *valueLabel;
@property (nonatomic,strong) UIImageView *valueImage;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) ZNTextView *textView;

@property(nonatomic,strong) NSDictionary *cellData;



@end
