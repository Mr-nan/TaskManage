//
//  AddTaskCell.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/28.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "AddTaskCell.h"


#define left_right_gap (15)
#define inside_gap (10)
#define content_width (SCREEN_WIDTH-left_right_gap*2-inside_gap*2)

@interface AddTaskCell()

@property (nonatomic,strong) UIView *backView;

@end

@implementation AddTaskCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
    
        [self addSubview:self.backView];
        [self.backView addSubview:self.title];
        [self.backView addSubview:self.textField];
        [self.backView addSubview:self.textView];
        [self.backView addSubview:self.valueLabel];
        [self.backView addSubview:self.valueImage];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = view_backgroundColor;
        
    }
    return self;
}

-(void)setCellData:(NSDictionary *)cellData{
    
    _cellData = cellData;
    
    NSNumber *height = cellData[@"height"];
    NSString *titleStr = cellData[@"title"];
    self.backView.frame = CGRectMake(left_right_gap,0, SCREEN_WIDTH-left_right_gap*2, height.floatValue);
    self.valueImage.frame = CGRectMake(content_width+inside_gap-10, (height.floatValue-20)/2, 10, 20);

    self.title.text= cellData[@"title"];
    CGSize titleSize = [titleStr getStringSizeFont:self.title.font];
    
    self.title.frame =CGRectMake(left_right_gap, (height.floatValue-titleSize.height)/2, titleSize.width, titleSize.height);
    
    [self.textField setHidden:YES];
    [self.textView setHidden:YES];
    [self.valueLabel setHidden:YES];
    [self.valueImage setHidden:YES];
    
    if([_cellData[@"type"] isEqualToString:@"input"]){
     
        CGFloat textFielWidth = content_width -self.valueImage.width-self.title.width-10;
        self.textField.frame = CGRectMake(content_width- textFielWidth, (height.floatValue-35)/2,textFielWidth , 35);
        self.textField.placeholder = [NSString stringWithFormat:@"请输入%@（建议10个字内）",self.title.text];
        self.textField.textAlignment = NSTextAlignmentRight;
        [self.textField setHidden:NO];
        
    }else if([_cellData[@"type"] isEqualToString:@"select"]){
        
        [self.valueImage setHidden:NO];
        
    }else if([_cellData[@"type"] isEqualToString:@"remark"]){
        
        self.title.frame =CGRectMake(inside_gap, 10, 200, 30);
        self.textView.frame = CGRectMake(inside_gap, self.title.bottom+10, content_width, 90);
        self.textView.placeholder =@"每天坚持一点点！！！";
        self.textView.textAlignment = NSTextAlignmentLeft;
        [self.textView setHidden:NO];
    }
    
    if([_cellData[@"value"] isKindOfClass: [NSString class]]){
        [self.valueLabel setHidden:NO];
        NSString *value = _cellData[@"value"];
        self.valueLabel.text = value;
        CGSize size = [value getStringSizeFont:self.valueLabel.font];
        self.valueLabel.frame = CGRectMake( self.valueImage.left-size.width-5, (height.floatValue-size.height)/2, size.width, size.height);
    }
    

}


-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc]init];
        _backView.layer.cornerRadius = 5;
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}


-(UITextField *)textField{
    if(_textField == nil){
        _textField = [[UITextField alloc]init];
        _textField.font = [UIFont systemFontOfSize:16];
        _textField.textColor = title_color_1;

    }
    return _textField;
}

-(UILabel *)title{
    
    if(_title == nil){
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:16];
        _title.textColor = title_color_1;
    }
    return _title;
}

-(ZNTextView *)textView{
    if(_textView == nil){
        _textView = [[ZNTextView alloc]init];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.textColor = title_color_1;
    }
    return _textView;
}

-(UILabel *)valueLabel{
    if(_valueLabel == nil){
        _valueLabel = [[UILabel alloc]init];
        _valueLabel.font = [UIFont systemFontOfSize:16];
        _valueLabel.textColor = title_color_1;
    }
    return _valueLabel;
}

-(UIImageView *)valueImage{
    if(_valueImage == nil){
        _valueImage = [[UIImageView alloc]init];
        _valueImage.image = [UIImage imageNamed:@"选择箭头"];
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
