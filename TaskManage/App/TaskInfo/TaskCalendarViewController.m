//
//  TaskCalendarViewController.m
//  TaskManage
//
//  Created by zhengnan on 2018/4/20.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TaskCalendarViewController.h"
#import "TaskCalendarView.h"
#import "ZNNavigationController.h"
#import "AppDelegate.h"
#import <Photos/PHPhotoLibrary.h>
#import <Photos/PHAssetChangeRequest.h>

@interface TaskCalendarViewController ()

@property (nonatomic,strong) TaskCalendarView *taskCalendarView;


@end

@implementation TaskCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = view_sub_backgroundColor;
    [self.view addSubview:self.taskCalendarView];
    [self addSharedButton];
}



-(void)viewWillAppear:(BOOL)animated
{
    ZNNavigationController *nc = (ZNNavigationController *)self.navigationController;
    [nc setNavigationBackColor:[view_backgroundColor colorWithAlphaComponent:0]];

}

-(void)viewWillDisappear:(BOOL)animated
{
    ZNNavigationController *nc = (ZNNavigationController *) self.navigationController;
    [nc setNavigationBackColor:view_backgroundColor ];
}

-(void)addSharedButton{
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"分享"] style:UIBarButtonItemStyleDone target:self action:@selector(sharedBtnClick)];
    self.navigationItem.rightBarButtonItem = barBtn;
    
}

-(void)sharedBtnClick{
   [self saveImage:[self screenImageWithSize:self.view.bounds.size]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(TaskCalendarView *)taskCalendarView{
    if(!_taskCalendarView){
        _taskCalendarView = [[TaskCalendarView alloc]initWithTaskItem:self.taskItem];
    }
    return _taskCalendarView;
}

-(UIImage *)screenImageWithSize:(CGSize)imageSize{
    UIGraphicsBeginImageContext(imageSize);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)saveImage:(UIImage *)image{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
         [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"success = %d, error = %@", success, error);
    }];
}



@end
