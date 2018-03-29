//
//  ZNSelectIconView.m
//  TaskManage
//
//  Created by zhengnan on 2018/3/29.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "ZNSelectIconView.h"
#import "SelectIconCell.h"
@interface ZNSelectIconView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIView  *iconToolView;
@property(nonatomic,strong) UICollectionView *iconView;
@property(nonatomic,strong) SelectIconCell *selectIconCell;
@end

@implementation ZNSelectIconView

-(instancetype)init{
    self = [super init];
    if(self){
        self.frame = SCREEN_BOUNDS;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self addSubview:self.iconToolView];
        self.iconNameArray = [NSArray array];
    }
    return self;
}



-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

-(void)setIconNameArray:(NSArray *)iconNameArray{
    _iconNameArray = iconNameArray;
    [self.iconView reloadData];
}

-(void)toolButtenAction:(UIButton *)btn{
    [self setHidden:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.iconNameArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectIconCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.iconName = [self.iconNameArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.selectIconAction){
        self.selectIconAction([UIImage imageNamed:self.iconNameArray[indexPath.row]],self.iconNameArray[indexPath.row]);
        [self setHidden:YES];
    }
}


-(UIView *)iconToolView{
    if(_iconToolView == nil){
        
        _iconToolView= [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 300, SCREEN_WIDTH, 300)];
        _iconToolView.backgroundColor = [UIColor whiteColor];
        [_iconToolView addSubview:self.iconView];
        
        UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        toolView.backgroundColor = [UIColor colorWithRed:0.88f green:0.95f blue:0.98f alpha:1.00f];
        [toolView addSubview:self.titleLabel];
        [_iconToolView addSubview:toolView];
        
        UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 10, 90, 30)];
        cancelBtn.backgroundColor = [UIColor colorWithRed:0.23f green:0.69f blue:0.95f alpha:1.00f];
        cancelBtn.layer.cornerRadius = 10;
        cancelBtn.tag = 0;
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(toolButtenAction:) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:cancelBtn];
        
    }
    return _iconToolView;
}

-(UICollectionView *)iconView{
    if(_iconView == nil){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        // 设置collectionView滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 设置itemSize
        layout.itemSize = CGSizeMake(50, 50);
        _iconView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 60, SCREEN_WIDTH-20, 230) collectionViewLayout:layout];
        _iconView.backgroundColor = [UIColor whiteColor];
        _iconView.delegate = self;
        _iconView.dataSource = self;
        // 注册cell
        [_iconView registerClass:[SelectIconCell class] forCellWithReuseIdentifier:@"cellID"];
    
    }
    return _iconView;
}

-(UILabel *)titleLabel{
    if(_titleLabel == nil){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 120)/2, 5, 120, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:0.70f green:0.75f blue:0.78f alpha:1.00f];
    }
    return _titleLabel;
}


@end
