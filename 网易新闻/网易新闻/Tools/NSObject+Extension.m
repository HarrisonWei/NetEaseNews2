//
//  NSObject+Extension.m
//  网易新闻
//
//  Created by 曹魏 on 2017/10/16.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "NSObject+Extension.h"
#import "News.h"
#import <objc/runtime.h>
@implementation NSObject (Extension)
#pragma mark -- 字典转模型
+ (instancetype)newsWithDict:(NSDictionary *)dict{
    News *news = [[News alloc]init];
    [news setValuesForKeysWithDictionary:dict];
    return news;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

#pragma mark -- 运行时
//运行时机制
//1.动态获取类的属性
//2.利用关联对象,给分类添加属性
//3.利用交换方法,拦截系统或其他框架的方法(一般用不着去修改底层的东西,所以这个暂时用不着)


//1.动态获取类的属性


const char *KPropertisKey = "propertisKey";
+ (NSArray *)loadPropertis{
    //为了提高效率,做一个拦截,利用关联对象给类添加属性
    
    
    
    NSArray *plist = objc_getAssociatedObject(self, KPropertisKey);
    if (plist != nil) {
        return plist;
    }
    
    
    
    
    
    //1.参数一:获取哪个类
    //2.参数二:当前类属性个数
    
    unsigned int count = 0;
    //记得要释放,因为在C语言中copy要释放,release一下,具体释放方法看文档
    objc_property_t *list = class_copyPropertyList([self class], &count);
    NSLog(@"属性数量 :%u",count);
    //定义一个可变数组,用来存放元素名称
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:count];
    //遍历数组,获取属性名称
    for (unsigned int i = 0; i<count; i++) {
        //C语言没有对象,不需要使用*,该步是获取数组中的元素
        objc_property_t pty = list[i];
        //获取数组中元素的名称
        const char *cname = property_getName(pty);
        [mArray addObject:[NSString stringWithUTF8String:cname]];
        //        printf("%s\t",cname);
    }
    NSLog(@"%@",mArray);
    
    
    free(list);
    //设置关联对象
    objc_setAssociatedObject(self, KPropertisKey, mArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    
    
    return objc_getAssociatedObject(self, KPropertisKey);
    
    
}

@end
