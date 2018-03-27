//
//  AddTaskCell.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/28.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "AddTaskCell.h"

@interface AddTaskCell()

@property (nonatomic,strong) UITextField *textField;

@end

@implementation AddTaskCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
       
    }
    return self;
}

-(void)setCellData:(NSDictionary *)cellData{
    _cellData = cellData;
    self.textLabel.text = cellData[@"title"];
    if([_cellData[@"type"] isEqualToString:@"input"]){
     
        self.accessoryView = self.textField;
        
    }else if([_cellData[@"type"] isEqualToString:@"select"]){
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if([_cellData[@"type"] isEqualToString:@"remark"]){
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
}

-(UITextField *)textField{
    if(_textField == nil){
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 250, 40)];
        _textField.placeholder = [NSString stringWithFormat:@"请输入%@（建议10个字内）",self.textLabel.text];
        _textField.rightViewMode = UITextBorderStyleRoundedRect;
        _textField.backgroundColor = [UIColor colorWithRed:0.90f green:0.96f blue:0.98f alpha:1.00f];
        _textField.textAlignment = NSTextAlignmentRight;
        
    }
    return _textField;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
