//
//  NewsCell.m
//  网易新闻
//
//  Created by 曹魏 on 2017/10/14.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "NewsCell.h"
#import "News.h"
#import <UIImageView+AFNetworking.h>
@interface NewsCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraImageViews;


@end
@implementation NewsCell
//重写模型方法
- (void)setNews:(News *)news{
    _news = news;
    self.titleLabel.text = news.title;
    self.sourceLabel.text = news.source;
    self.replyLabel.text = [NSString stringWithFormat:@"%d跟帖",news.replyCount];
    self.iconImage.image = nil;
    //设置图像,AFN设置图像不支持GIF,绝大部分还是用SDWebImage
    [self.iconImage setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    //判断是否是多图
    if (news.imgextra.count == 2) {
        int index = 0;
        for (UIImageView *iv in self.extraImageViews) {
            //首先是取出数组中的字符串
            NSString *str = news.imgextra[index][@"imgsrc"];
            NSURL *url = [NSURL URLWithString:str];
            //设置图像之前清空图像
            iv.image = nil;
            //设置多图
            [iv setImageWithURL:url];
            
            index++;
        }
        
    }
}
//定义重用标识符类方法
+ (NSString *)cellForIdentifier:(News *)news{
    if (news.imgextra.count == 2) {
        return @"ImagesCell";
    }else if (news.isBigImage){
        return @"BigImageCell";
    }else{
        return @"NewsCell";
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 设置换行宽度
    self.titleLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - self.iconImage.bounds.size.width - 25;
    
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
