//
//  ZNCalendarView.m
//  TaskManage
//
//  Created by zhengnan on 2018/4/20.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "ZNCalendarView.h"
#import "ZNCalendarItemView.h"

@interface ZNCalendarView() <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *calendarCollectionView;
@property (nonatomic,strong) ZNCalendarItemView *calendarItemCell;
@end

@implementation ZNCalendarView



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.calendarCollectionView];
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 31;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZNCalendarItemView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.calendarText = [NSString stringWithFormat:@"%ld",indexPath.row +1];
    return cell;
}

-(UICollectionView *)calendarCollectionView{
    
    if(!_calendarCollectionView){
        // 创建collectionView flowLayout;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        // 设置layout滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 设置cell的size
        layout.itemSize = CGSizeMake(self.width/7.0f, self.width/7.0f);
        
        // 创建collectionView
        _calendarCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _calendarCollectionView.backgroundColor = [UIColor whiteColor];
        _calendarCollectionView.dataSource = self;
        _calendarCollectionView.delegate = self;
        
        //注册collectionView-cell
        [_calendarCollectionView registerClass:[ZNCalendarItemView class] forCellWithReuseIdentifier:@"cellID"];
    
    }
    return _calendarCollectionView;
    
}

@end
