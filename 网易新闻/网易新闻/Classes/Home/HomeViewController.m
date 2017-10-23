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
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ChannelLabelDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *channelView;
@property (nonatomic,strong)NSArray *channelList;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

//定义一个索引
@property (nonatomic,assign)NSInteger currentIndex;
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
    NSInteger index = 0;
    //遍历数组,添加label
    for (Channel *channel in self.channelList) {
        
        ChannelLabel *l = [ChannelLabel channelLabelWithTitle:channel.tname];
        //设置label的frame
        l.frame = CGRectMake(x, 0, l.bounds.size.width, h);
        x += l.bounds.size.width;
        //设置代理对象
        l.delegate = self;
        //给label设置一个tag值
        l.tag = index++;
        
        
        [self.channelView addSubview:l];
    }
    //设置contentView
    self.channelView.contentSize = CGSizeMake(x + margin , h);
    //设置索引的初始化值
    self.currentIndex = 0;
    //取出第一个label,初始化值
    ChannelLabel *firstLabel = self.channelView.subviews[0];
    firstLabel.scale = 1;
    
    
    
}

#pragma mark -- collectionView滚动的时候会调用

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //1.获取当前选中的label
    ChannelLabel *currentLabel = self.channelView.subviews[self.currentIndex];
//    NSLog(@"%@",label.text);
    //2.下一个
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
//    NSLog(@"%@",indexPaths);
    ChannelLabel *nextLabel = nil;
    for (NSIndexPath *path in indexPaths) {
        if (path.item != self.currentIndex) {
            nextLabel = self.channelView.subviews[path.item];
            break;
        }
    }
//    NSLog(@"从%@到%@",currentLabel.text,nextLabel.text);
    if (nextLabel == nil) {
        return;
        
    }
    float nextScale = ABS((float)self.collectionView.contentOffset.x/self.collectionView.bounds.size.width - self.currentIndex);
//    NSLog(@"%f",scale);
    float currentScale = 1 - nextScale;
//    NSLog(@"%f",currentScale);
    //设置label的大小和颜色
    currentLabel.scale = currentScale;
    nextLabel.scale = nextScale;
    
}

#pragma mark -- 滚动停止的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //更新索引
    self.currentIndex = scrollView.contentOffset.x/scrollView.bounds.size.width;
}


#pragma mark -- 子视图布局完成后调用
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self setupLayout];
}
#pragma mark -- 实现代理方法
- (void)channelLabelDidSelected:(ChannelLabel *)label{
    self.currentIndex = label.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
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































