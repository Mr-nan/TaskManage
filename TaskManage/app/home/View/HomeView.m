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
        _taskTableView.dataSource = self;
        _taskTableView.delegate = self;
        _taskTableView.tableHeaderView = self.taskHeadView;
    }
    return _taskTableView;
}

-(UIView *)taskHeadView{
    if(_taskHeadView == nil){
        _taskHeadView = [[TaskHeadView alloc]initWithFrame:CGRectMake(0, 0,self.width,self.height * 0.5)];
        _taskHeadView.backgroundColor = [UIColor yellowColor];
    }
    return _taskHeadView;
}

@end
