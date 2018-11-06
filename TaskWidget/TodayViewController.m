//
//  TodayViewController.m
//  TaskWidget
//
//  Created by zhengnan on 2018/10/24.
//  Copyright © 2018 zn. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    self.preferredContentSize = CGSizeMake(self.preferredContentSize.width, self.preferredContentSize.height);
    [self setUI];
}

-(void)setUI{
    self.titleLabel.textColor = [UIColor colorWithRed:90.0/255.0f green:90.0/255.0f blue:90.0/255.0f alpha:1.00f];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.titleLabel sizeToFit];
    
    
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    NSLog(@"button.tag=%ld",sender.tag);
    
    if(sender.tag ==0){
        NSURL *url = [NSURL URLWithString:@"taskManage://left"];
        [self.extensionContext openURL:url completionHandler:nil];

    }else{
        NSURL *url = [NSURL URLWithString:@"taskManage://right"];
        [self.extensionContext openURL:url completionHandler:nil];


    }
}


-(void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{
    NSLog(@"maxWidth %f maxHeight %f",maxSize.width,maxSize.height);
    if(activeDisplayMode == NCWidgetDisplayModeCompact){
        self.preferredContentSize = CGSizeMake(maxSize.width, maxSize.height);
    }else{
        self.preferredContentSize = CGSizeMake(maxSize.width, maxSize.height);
    }
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
