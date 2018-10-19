//
//  SetView.m
//  TaskManage
//
//  Created by zhengnan on 2018/10/18.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "SetView.h"
#import "WebViewController.h"
@interface SetView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView     *tableView;
@property(nonatomic,strong) UIImageView     *cellImage;
@property(nonatomic,strong) UILabel         *cellValue;
@property(nonatomic,strong) UISwitch        *cellSwitch;
@property(nonatomic,strong) NSArray         *titleArray;
@end

@implementation SetView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.tableView];
        
    }
    return self;
}

-(void)cellSwitchClick:(UISwitch *)cellSwitch{
    ZNLog(@"%d",cellSwitch.on);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = title_color_1;
        cell.layer.cornerRadius = 5;
        cell.layer.masksToBounds = YES;
    }
    NSDictionary *dict = self.titleArray[indexPath.section];
    cell.textLabel.text = dict[@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryView = dict[@"view"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.titleArray[indexPath.section];
    NSString *title = dict[@"title"];
    
    
    if([title isEqualToString:@"关于我们"]){
        WebViewController *webVC = [[WebViewController alloc]init];
        webVC.loadURL = @"http://www.qq.com";
        webVC.title = @"关于我们";
        [self.viewController.navigationController pushViewController:webVC animated:YES];
    }
}

-(UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(25, 0, SCREEN_WIDTH-50, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = view_backgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

-(NSArray *)titleArray{
    if(!_titleArray){
        
        _titleArray = @[
                        @{@"title":@"提醒功能",@"view":self.cellSwitch},
                        @{@"title":@"关于我们",@"view":self.cellImage},
                        @{@"title":@"版本号",@"view":self.cellValue},
                        ];
    }
    return _titleArray;
}

-(UISwitch *)cellSwitch
{
    if(!_cellSwitch){
        _cellSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        _cellSwitch.on = YES;
        _cellSwitch.tintColor = title_color_4;
        _cellSwitch.onTintColor = content_color_1;
        _cellSwitch.thumbTintColor = title_color_4;
        [_cellSwitch addTarget:self action:@selector(cellSwitchClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _cellSwitch;
}

-(UIImageView *)cellImage{
    if(!_cellImage){
        _cellImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
        _cellImage.image = [UIImage imageNamed:@"选择箭头"];
    }
    return _cellImage;
}
-(UILabel *)cellValue{
    if(!_cellValue){
        _cellValue = [[UILabel alloc]init];
        _cellValue.textColor = title_color_1;
        _cellValue.font = [UIFont systemFontOfSize:14];
        NSDictionary *infoData = [[NSBundle mainBundle] infoDictionary];
        _cellValue.text = [NSString stringWithFormat:@"v %@", [infoData objectForKey:@"CFBundleShortVersionString"]];
        [_cellValue sizeToFit];
    }
    return _cellValue;
}

@end
