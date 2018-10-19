//
//  AddTaskView.m
//  TaskManage
//
//  Created by zhengnan on 2018/3/27.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "AddTaskView.h"
#import "AddTaskCell.h"
#import "ZNDatePickerView.h"
#import "ZNSelectIconView.h"
#import "TaskModel.h"
#import "ZNCreactUITool.h"
@interface AddTaskView()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    NSMutableArray *_addTaskTitleArray;
    UITextField *_nameField;
    ZNTextView  *_remarkField;
    NSString *_startDate;
    NSString *_stopDate;
}
@property (nonatomic,strong) ZNDatePickerView *znDatePickerView;
@property (nonatomic,strong) UIAlertController *alertController;

@property(nonatomic,strong) UIButton *addTaskButton;

@end

@implementation AddTaskView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
    
        _startDate = [NSDate getDateString:@"yyyy-MM-dd"];
        _stopDate = [NSDate getStringDate:[NSDate getNextDayDate] FormatterString:@"yyyy-MM-dd"];
        _addTaskTitleArray = [NSMutableArray arrayWithArray:@[
                              @{@"title":@"任务",@"type":@"input",@"height":[NSNumber numberWithFloat:50]},
                              @{@"title":@"开始时间",@"type":@"select",@"height":[NSNumber numberWithFloat:50],@"value":_startDate},
                              @{@"title":@"结束时间",@"type":@"select",@"height":[NSNumber numberWithFloat:50],@"value":_stopDate},
                              @{@"title":@"说明",@"type":@"remark",@"height":[NSNumber numberWithFloat:155]}
                              ]];
        [self addSubview:self.addTaskTableView];
        
    }
    return self;
}

-(void)addTaskAction{
    
    NSString *errorMsg = nil;
    if([_nameField.text removWhitespace].length<=0){
        errorMsg=@"请填写任务";
    }else if(![_stopDate isEqualToString:@"无限期"]){
        if([NSDate compareDateStr:_startDate withNewDateStr:_stopDate]!=1){
            errorMsg = @"结束时间必须大于开始时间";
        }
    }
    
    if(errorMsg){
      UIAlertController *alert = [ZNCreactUITool creactAlertControllerTitle:@"提示" Message:errorMsg AlertAction:nil];
        [self.viewControllerID presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    
    TaskItem *item = [[TaskItem alloc]init];
    item.taskIsLose = @"0";
    item.taskName = _nameField.text;
    item.taskStartDate = _startDate;
    item.taskStopDate = _stopDate;
    
    if(_remarkField.text.length<=0){
         item.taskRemark =@"每天坚持一点点！！！";
    }else{
         item.taskRemark = _remarkField.text;
    }
    
   
    if([_stopDate isEqualToString:@"无限期"]){
        item.taskSumDayNumber = @"无限期";
    }else{
        item.taskSumDayNumber = [NSString stringWithFormat:@"%ld",(long)[NSDate getNumberOfDaysWithDate:_startDate toDate:_stopDate]];
    }
   
    item.taskDateArray = [NSMutableArray array];
    [TaskModel addTaskItem:item];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addTaskReloadAction" object:self];
    [self.viewControllerID.navigationController popViewControllerAnimated:YES];
    [MBProgressHUDTool showToastTitle:@"添加成功！每天都要坚持完成哦！"];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _addTaskTitleArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *number = _addTaskTitleArray[indexPath.section][@"height"];
    return number.floatValue;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell = [[AddTaskCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    if([_addTaskTitleArray[indexPath.section][@"title"] isEqualToString:@"任务"]){
        _nameField = cell.textField;
        _nameField.delegate = self;
        _nameField.returnKeyType = UIReturnKeyDone;
    }else if([_addTaskTitleArray[indexPath.section][@"title"] isEqualToString:@"说明"]){
        _remarkField = cell.textView;
        _remarkField.delegate = self;
        _remarkField.returnKeyType = UIReturnKeyDone;
    }
   
    cell.cellData = _addTaskTitleArray[indexPath.section];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self endEditing:YES];
    
    NSString *cellTitle = _addTaskTitleArray[indexPath.section][@"title"];
    if([cellTitle isEqualToString:@"结束时间"]){
        
        [self.viewControllerID presentViewController:self.alertController animated:YES completion:nil];
        
    }else if([cellTitle isEqualToString:@"开始时间"]){
        self.znDatePickerView.title = @"开始时间";
        self.znDatePickerView.currentDate = [NSDate date];
        [self.znDatePickerView setHidden:NO];
    }
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self endEditing:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.addTaskTableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.addTaskTableView setContentOffset:CGPointMake(0, 230) animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

-(UITableView *)addTaskTableView{
    if(_addTaskTableView == nil){
        _addTaskTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _addTaskTableView.delegate = self;
        _addTaskTableView.dataSource = self;
        _addTaskTableView.backgroundColor = view_backgroundColor;
        _addTaskTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH-50)*0.128)];
        [footView addSubview:self.addTaskButton];
        [self.addTaskButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footView).with.offset(25);
            make.right.equalTo(footView).with.offset(-25);
            make.height.with.offset((SCREEN_WIDTH-50)*0.128);
        }];
        _addTaskTableView.tableFooterView = footView;
        
    }
    return _addTaskTableView;
}

-(UIButton *)addTaskButton
{
    if(_addTaskButton == nil){
        _addTaskButton = [[UIButton alloc]init];
        [_addTaskButton setBackgroundImage:[UIImage imageNamed:@"添加按钮"] forState:UIControlStateNormal];
        [_addTaskButton addTarget:self action:@selector(addTaskAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addTaskButton;
}
-(UIAlertController *)alertController{
    if(_alertController == nil){
        _alertController = [UIAlertController alertControllerWithTitle:@"选择结束模式" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        [_alertController addAction:[UIAlertAction actionWithTitle:@"有限期" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.znDatePickerView.title = @"结束时间";
            NSDate *date = [[NSDate alloc]init];
            NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];
            self.znDatePickerView.currentDate = nextDay;
            [self.znDatePickerView setHidden:NO];
        }]];
        
        [_alertController addAction:[UIAlertAction actionWithTitle:@"无限期" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self->_stopDate = @"无限期";
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self->_addTaskTitleArray[2]] ;
            [dict setValue:@"无限期" forKey:@"value"];
            [self->_addTaskTitleArray replaceObjectAtIndex:2 withObject:dict];
            [self.addTaskTableView reloadData];
            
        }]];
        
        [_alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self->_alertController dismissViewControllerAnimated:YES completion:nil];
        }]];
    }
    return _alertController;
}

-(ZNDatePickerView *)znDatePickerView{
    if(_znDatePickerView == nil){
        _znDatePickerView = [[ZNDatePickerView alloc]init];
        
        __weak NSMutableArray *addTaskTitleArray = _addTaskTitleArray;
        __weak typeof(self) weakSelf = self;
        _znDatePickerView.datePickerBlock=^(NSString *title,NSInteger toolButtonType,NSDate *date){
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"yyyy-MM-dd";
            NSString *dateStr = [formatter stringFromDate:date];
            
            if([title isEqualToString:@"开始时间"]){
                self->_startDate = dateStr;
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:addTaskTitleArray[1]] ;
                [dict setValue:dateStr forKey:@"value"];
                [addTaskTitleArray replaceObjectAtIndex:1 withObject:dict];
                [weakSelf.addTaskTableView reloadData];
                
            }else{
                self->_stopDate = dateStr;
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:addTaskTitleArray[2]] ;
                [dict setValue:dateStr forKey:@"value"];
                [addTaskTitleArray replaceObjectAtIndex:2 withObject:dict];
                [weakSelf.addTaskTableView reloadData];
            }
        };
        [self addSubview:_znDatePickerView];
        [_znDatePickerView setHidden:YES];

    }
    return _znDatePickerView;
}






@end
