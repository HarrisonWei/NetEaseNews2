//
//  NewsTableViewController.m
//  网易新闻
//
//  Created by 曹魏 on 2017/10/5.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "NewsTableViewController.h"
#import "News.h"
#import "NewsCell.h"
@interface NewsTableViewController ()
@property (nonatomic,strong)NSArray *dataArray;

@end

@implementation NewsTableViewController

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 130;
    //自适应行高
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //测试加载新闻
    
    __weak typeof(self) weakSelf = self;
    [News loadNewsListWithUrlString:@"T1348648517839/0-20.html" finished:^(NSArray *newsList) {
        weakSelf.dataArray = newsList;
    }];
    //设置预估行高
    
    
    
}


#pragma mark - Table view data source
//返回组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//返回行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
//返回每行cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    News *n = self.dataArray[indexPath.row];
    NSString *cellID = [NewsCell cellForIdentifier:n];
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.news = n;
    return cell;
}

#pragma mark -- 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}
@end






