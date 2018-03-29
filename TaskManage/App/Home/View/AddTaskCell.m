//
//  AddTaskCell.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/28.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "AddTaskCell.h"

@interface AddTaskCell()


@end

@implementation AddTaskCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.valueLabel];
        [self.contentView addSubview:self.valueImage];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setCellData:(NSDictionary *)cellData{
    
    _cellData = cellData;
    self.title.text= cellData[@"title"];
    NSNumber *height = cellData[@"height"];
    self.title.frame =CGRectMake(15, (height.floatValue-30)/2, 200, 30);
    [self.textField setHidden:YES];
    [self.textView setHidden:YES];
    [self.valueLabel setHighlighted:YES];
    [self.valueImage setHighlighted:YES];
    
    if([_cellData[@"type"] isEqualToString:@"input"]){
     
        self.textField.frame = CGRectMake(0, 0, 250, 35);
        self.accessoryView = self.textField;
        self.textField.placeholder = [NSString stringWithFormat:@"请输入%@（建议10个字内）",self.title.text];
        self.textField.textAlignment = NSTextAlignmentRight;
        [self.textField setHidden:NO];
        
    }else if([_cellData[@"type"] isEqualToString:@"select"]){
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if([_cellData[@"type"] isEqualToString:@"remark"]){
        
        self.title.frame =CGRectMake(15, 10, 200, 30);
        self.textView.frame = CGRectMake(15, self.title.bottom+5, SCREEN_WIDTH - 30, 90);
        self.textView.placeholder =@" 写点激励自己的话吧";
        self.textView.textAlignment = NSTextAlignmentLeft;
        [self.textView setHidden:NO];
    }
    
    if([_cellData[@"value"] isKindOfClass: [UIImage class]]){
        
        [self.valueImage setHighlighted:NO];
        self.valueImage.frame = CGRectMake(SCREEN_WIDTH - 58, (height.floatValue-30)/2, 30, 30);
        self.valueImage.image = _cellData[@"value"];
        
    }else if([_cellData[@"value"] isKindOfClass: [NSString class]]){
        [self.valueLabel setHighlighted:NO];
        NSString *value = _cellData[@"value"];
        self.valueLabel.text = value;
        CGSize size = [value getStringSizeFont:self.valueLabel.font];
        self.valueLabel.frame = CGRectMake(SCREEN_WIDTH - 38-size.width, (height.floatValue-size.height)/2, size.width, size.height);
    }
    

}



-(UITextField *)textField{
    if(_textField == nil){
        _textField = [[UITextField alloc]init];
        _textField.rightViewMode = UITextBorderStyleRoundedRect;
        _textField.backgroundColor = [UIColor colorWithRed:0.90f green:0.96f blue:0.98f alpha:1.00f];
        
    }
    return _textField;
}

-(UILabel *)title{
    
    if(_title == nil){
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:14];
    }
    return _title;
}

-(UITextView *)textView{
    if(_textView == nil){
        _textView = [[ZNTextView alloc]init];
        _textView.backgroundColor = [UIColor colorWithRed:0.90f green:0.96f blue:0.98f alpha:1.00f];
        
    }
    return _textView;
}

-(UILabel *)valueLabel{
    if(_valueLabel == nil){
        _valueLabel = [[UILabel alloc]init];
        _valueLabel.font = [UIFont systemFontOfSize:14];
    }
    return _valueLabel;
}

-(UIImageView *)valueImage{
    if(_valueImage == nil){
        _valueImage = [[UIImageView alloc]init];
    }
    return _valueImage;
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
