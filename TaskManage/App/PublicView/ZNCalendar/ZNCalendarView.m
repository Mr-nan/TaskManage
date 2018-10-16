//
//  ZNCalendarView.m
//  TaskManage
//
//  Created by zhengnan on 2018/4/20.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "ZNCalendarView.h"
#import "ZNCalendarItemView.h"
#import "ZNCalenderHeadView.h"

#define left_gap 25
#define content_width (SCREEN_WIDTH-left_gap *2)

@interface ZNCalendarView() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *calendarCollectionView;
@property (nonatomic,strong) ZNCalendarItemView *calendarItemCell;
@property (nonatomic,strong) NSMutableArray *calendarModeArray;
@end

@implementation ZNCalendarView



-(void)setTaskItem:(TaskItem *)taskItem{
    _taskItem = taskItem;
    
    self.calendarModeArray = [NSMutableArray array];
    if([taskItem.taskStopDate isEqualToString:@"无限期"]){
        [self setCalendarModelStartDate:taskItem.taskStartDate stopDate:[NSDate getDateString:@"yyyy-MM-dd"]];
        
    }else{
        [self setCalendarModelStartDate:taskItem.taskStartDate stopDate:taskItem.taskStopDate];
    }
    
    [self addSubview:self.calendarCollectionView];

}

-(void)setCalendarModelStartDate:(NSString *)startDate stopDate:(NSString *)stopDate{
    
    NSInteger sumMonthNumber = [NSDate getNumberOfMonthWithDate:startDate toDate:stopDate];
    
    ZNLog(@"start:%@--stop:%@---------%ld",startDate,stopDate,(long)sumMonthNumber);
    
    for (NSInteger i=0; i<sumMonthNumber; i++) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *currentMonthDate = [NSDate getNextMonthDate:[dateFormatter dateFromString:startDate] toNumber:i];
        NSString *currentMonthDateStr = [dateFormatter stringFromDate:currentMonthDate];
        NSInteger firstWeekday = [NSDate firstWeekdayInThisMonth:currentMonthDateStr];
        NSInteger sumDayNumber = [NSDate totaldaysMonth:currentMonthDateStr] + firstWeekday;
        NSMutableArray *dayArray = [NSMutableArray array];
        
        ZNLog(@"currentMonthDateStr:%@,firstWeekday:%ld,sumDayNumber:%ld",currentMonthDateStr,(long)firstWeekday,(long)sumDayNumber);
        
        for (NSInteger day =0;day<sumDayNumber; day++) {
            
            NSString *dayStr = [NSString string];
            if(day>=firstWeekday){
                dayStr = [NSString stringWithFormat:@"%d",day+1-firstWeekday];
            }
            [dayArray addObject:dayStr];
        }
        
        NSDateFormatter *monthFormatter = [[NSDateFormatter alloc]init];
        [monthFormatter setDateFormat:@"yyyy-MM"];
        NSString *monthStr = [monthFormatter stringFromDate:currentMonthDate];
        
        [self.calendarModeArray addObject:@{
                                            @"currentMonth":monthStr,
                                            @"dayArray":dayArray
                                            }];
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.calendarModeArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *dayArray = [[self.calendarModeArray objectAtIndex:section] objectForKey:@"dayArray"];
    return dayArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZNCalendarItemView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    NSDictionary *calendarDict = [self.calendarModeArray objectAtIndex:indexPath.section];
    NSArray *dayArray = [calendarDict objectForKey:@"dayArray"];
    cell.calendarText = [dayArray objectAtIndex:indexPath.row];
    return cell;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    ZNCalenderHeadView *reusableView = nil;
    
    if(kind == UICollectionElementKindSectionHeader){
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        NSDictionary *calendarDict = [self.calendarModeArray objectAtIndex:indexPath.section];
        reusableView.title = calendarDict[@"currentMonth"];
        reusableView.backgroundColor = [UIColor orangeColor];
    }
   
    return reusableView;
    
}

-(UICollectionView *)calendarCollectionView{
    
    if(!_calendarCollectionView){
        // 创建collectionView flowLayout;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        // 设置layout滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 设置cell的size
        layout.itemSize = CGSizeMake((content_width)/ 7.0f, (content_width) / 7.0f);
        // 设置cell行间距
        layout.minimumLineSpacing = 0;
        // 设置cell列间距
        layout.minimumInteritemSpacing = 0;
        // 设置headViewSize
        layout.headerReferenceSize = CGSizeMake(content_width, 60);
        
        // 创建collectionView
        _calendarCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(25, 0, content_width, SCREEN_HEIGHT-64) collectionViewLayout:layout];
        _calendarCollectionView.backgroundColor = [UIColor whiteColor];
        _calendarCollectionView.dataSource = self;
        _calendarCollectionView.delegate = self;
        
        //注册collectionView-cell
        [_calendarCollectionView registerClass:[ZNCalendarItemView class] forCellWithReuseIdentifier:@"cellID"];
        
        //注册collection-headView
        [_calendarCollectionView registerClass:[ZNCalenderHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
                
    
    }
    return _calendarCollectionView;
    
}

@end
