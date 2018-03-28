//
//  HomeView.m
//  TaskManage
//
//  Created by 郑南 on 2018/3/24.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "HomeView.h"

@interface HomeView ()<UITableViewDelegate,UITableViewDataSource>




@end

@implementation HomeView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        [self addSubview:self.taskTableView];
        self.backgroundColor =[UIColor colorWithRed:0.90f green:0.96f blue:0.98f alpha:1.00f];
        
    }
    return self;
}

#pragma mark -tableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    }
    return cell;
}

-(UITableView *)taskTableView{
    if(_taskTableView == nil){
        _taskTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _taskTableView.backgroundColor = [UIColor colorWithRed:0.90f green:0.96f blue:0.98f alpha:1.00f];
        _taskTableView.dataSource = self;
        _taskTableView.delegate = self;
        _taskTableView.tableHeaderView = self.taskHeadView;
    }
    return _taskTableView;
}

-(UIView *)taskHeadView{
    if(_taskHeadView == nil){
        _taskHeadView = [[TaskHeadView alloc]initWithFrame:CGRectMake(0, 0,self.width,self.height * 0.5)];
        _taskHeadView.backgroundColor =[UIColor colorWithRed:0.29f green:0.75f blue:0.96f alpha:1.00f];
    }
    return _taskHeadView;
}

@end
