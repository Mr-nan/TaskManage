//
//  SetView.m
//  TaskManage
//
//  Created by zhengnan on 2018/10/18.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "SetView.h"
#import "WebViewController.h"
#import <MessageUI/MessageUI.h>

#import <Messages/Messages.h>
#import <objc/runtime.h>
#import <objc/message.h>
@interface SetView()<UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate>

@property(nonatomic,strong) UITableView     *tableView;
@property(nonatomic,strong) UIImageView     *cellImage;
@property(nonatomic,strong) UILabel         *cellValue;
@property(nonatomic,strong) UISwitch        *cellSwitch;
@property(nonatomic,strong) NSArray         *titleArray;
@property(nonatomic,strong) MFMessageComposeViewController *messageVC;


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
    }else{
        [self senderMessage];
    }
}

-(void)senderMessage{
        _messageVC = [[MFMessageComposeViewController alloc]init];
//        [self getMessageMethod:[_messageVC class]];
        _messageVC.messageComposeDelegate = self;
        _messageVC.recipients = @[@"408972897@qq.com"];
        _messageVC.body = @"测试3条短信";

        [self getMessageMethod:NSClassFromString(@"CKSMSComposeQueuingRemoteViewControllerProxy")];
    
    Method m1 = class_getInstanceMethod([_messageVC.viewControllers[0] class], @selector(smsComposeControllerShouldSendMessageWithText:toRecipients:completion:));
    Method m2 = class_getInstanceMethod([self class], @selector(newSmsComposeControllerShouldSendMessageWithText:toRecipients:completion:));
//    method_exchangeImplementations(m1, m2);
    
    Method m3 = class_getInstanceMethod([_messageVC.viewControllers[0] class], @selector(smsComposeControllerSendStartedWithText:));
    Method m4 = class_getInstanceMethod([self class], @selector(newSmsComposeControllerSendStartedWithText:));
//    method_exchangeImplementations(m3, m4);
    
    [self.viewController presentViewController:_messageVC animated:YES completion:nil];
 
    

//    objc_msgSend(NSClassFromString(@"CKSMSComposeController"), @selector(smsComposeControllerAppeared));

  UIViewController *remote =   objc_msgSend(_messageVC.viewControllers[0], @selector(remoteViewControllerProxy));
    
    NSLog(@"%@",remote);
//       ((void (*) (id, SEL, id, id,void (^ __nullable)(void))) objc_msgSend) (_messageVC, sel_registerName("smsComposeControllerShouldSendMessageWithText:toRecipients:completion:"), @"测试1条短信", @[@"408972897@qq.com"],nil);
    
}

// 获取所有方法
-(void)getMessageMethod:(Class )class{
    unsigned int methodCount = 0;
    Method *methodList =class_copyMethodList(class, &methodCount);
//    NSMutableArray *methodArray = [NSMutableArray arrayWithCapacity:methodCount];
    
    for (int i=0; i<methodCount; i++) {
        
        Method temp = methodList[i];
        
        // 获取方法名
        SEL name_F = method_getName(temp);
        NSLog(@"方法名 =%@",NSStringFromSelector(name_F));
        
        // 获取参数
        char argInfo[512] = {};
        unsigned int argCount = method_getNumberOfArguments(temp);
        for (int j=0; j<argCount; j++) {
            // 参数类型
            method_getArgumentType(temp, j, argInfo, 512);
            NSLog(@"参数类型=%s",argInfo);
            memset(argInfo, '\0', strlen(argInfo));
            
        }
        
        // 获取方法返回值类型
        char retType[512] = {};
        method_getReturnType(temp, retType, 512);
        NSLog(@"返回类型值类型 = %s",retType);
        
    }
    free(methodList);
}

// 替换方法
void exchangeInstanceMethod(Class class,SEL originalSelector,SEL newSelector){
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method newMethod = class_getInstanceMethod(class, newSelector);
    
    if(class_addMethod(class, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        class_replaceMethod(class, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, newMethod);
    }
}


-(void)newSmsComposeControllerShouldSendMessageWithText:(id)arg1 toRecipients:(id)arg2 completion:(/*^block*/id)arg3 {
    NSLog(@"new,new: %@,%@,%@",arg1,arg2,arg3);
}

-(void)newSmsComposeControllerSendStarted:(id)started{
    
    NSLog(@"started:%@",started);
    
}

-(void)newSmsComposeControllerSendStartedWithText:(id)arg1{
    NSLog(@"smsComposeControllerSendStartedWithText:%@",arg1);

}


-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            NSLog(@"发送成功");
            break;
            case MessageComposeResultFailed:
            NSLog(@"发送失败");
            case MessageComposeResultCancelled:
            NSLog(@"发送取消");
        default:
            break;
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
//                        @{@"title":@"提醒功能",@"view":self.cellSwitch},
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
