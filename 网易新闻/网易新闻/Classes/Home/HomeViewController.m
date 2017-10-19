//
//  HomeViewController.m
//  网易新闻
//
//  Created by 曹魏 on 2017/10/16.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "HomeViewController.h"
#import "Channel.h"
#import "ChannelLabel.h"
#import "ChannelCell.h"
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *channelView;
@property (nonatomic,strong)NSArray *channelList;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;


@end


@implementation HomeViewController
//懒加载
- (NSArray *)channelList{
    if (_channelList == nil) {
        _channelList = [Channel channelList];
    }
    return _channelList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}
- (void)setUpUI{
    CGFloat margin = 8.0;
    CGFloat h = self.channelView.bounds.size.height;
    CGFloat x = margin;
    //取消scrollview的自动缩进
    self.automaticallyAdjustsScrollViewInsets = NO;
    //遍历数组,添加label
    for (Channel *channel in self.channelList) {
        
        ChannelLabel *l = [ChannelLabel channelLabelWithTitle:channel.tname];
        //设置label的frame
        l.frame = CGRectMake(x, 0, l.bounds.size.width, h);
        x += l.bounds.size.width;
        [self.channelView addSubview:l];
    }
    //设置contentView
    self.channelView.contentSize = CGSizeMake(x + margin , h);
    
}
#pragma mark -- 子视图布局完成后调用
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self setupLayout];
}
//设置layout
- (void)setupLayout{
    //1.设置layout的大小
    self.layout.itemSize = self.collectionView.bounds.size;
    //2.设置layout的间距
    self.layout.minimumLineSpacing = 0;
    self.layout.minimumInteritemSpacing = 0;
    //3.取消滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    //4.设置滚动方向为水平方向
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //5.允许分页
    self.collectionView.pagingEnabled = YES;
    
    
}
#pragma mark--数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.channelList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChannelCell" forIndexPath:indexPath];
    
    Channel *channel = self.channelList[indexPath.item];
    
    cell.urlString = [channel urlString];
    
    return cell;
}
@end































