//
//  ViewController.m
//  JCCarouselViewDemo
//
//  Created by 郑嘉成 on 2017/2/5.
//  Copyright © 2017年 ZhengJiacheng. All rights reserved.
//

#import "ViewController.h"
#import "JCCarouselView.h"

#import "JCSingleCarouselView.h"
@interface ViewController ()<JCCarouselViewDelegate>
@property (nonatomic, strong) NSArray *imageUrlArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.imageUrlArr = @[
                         @"http://cdn.sspai.com/attachment/thumbnail/2017/01/22/1aaa97293057371535fb408a18fa937c590f1_mw_800_wm_1_wmp_3.jpg",
                         @"http://cdn.sspai.com/attachment/origin/2016/12/26/360721.jpg",
                         @"http://cdn.sspai.com/attachment/origin/2017/01/06/362369.jpg",
                         @"http://cdn.sspai.com/attachment/thumbnail/2017/01/25/e202f92ef3fabed9ef18a4c5ebfc81105926a_mw_800_wm_1_wmp_3.jpg",
                         @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1486371461287&di=6489a259c27440e59f8ef8f949c085d6&imgtype=0&src=http%3A%2F%2Fimg1.ph.126.net%2FLG1bDjRzCg0UQgjXH-KvnA%3D%3D%2F6630105693025410343.gif"
                         ];
    
    // JCCarouselView
    [self demo1];
    
    //用一张UIImageView实现的，利用动画转场
    [self demo2];
}

- (void)demo1{
    JCCarouselView *bannerView = [[JCCarouselView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 220)];
    [self.view addSubview:bannerView];
    bannerView.imageUrlArr = self.imageUrlArr;
    
    bannerView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    //设置pagecontrol 图片
    bannerView.curPageControlImage = [UIImage imageNamed:@"Group"];
    bannerView.pageControlImage = [UIImage imageNamed:@"Group1"];
    
    //设置pagecontrol 颜色
    bannerView.pageControlColor = [UIColor whiteColor];
    bannerView.curPageControlColor = [UIColor redColor];
    
    bannerView.timeInterval = 4;
    bannerView.delegate = self;
    
    bannerView.clickBlock = ^(NSInteger index){
        NSLog(@"点击%ld张图片",index);
    };
}

- (void)carouselView:(JCCarouselView *)carouselView didSelectedAtIndex:(NSInteger)index{
    NSLog(@"点击%ld张图片",index);
}

- (void)demo2{
    JCSingleCarouselView *bannerView = [[JCSingleCarouselView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 220)];
    [self.view addSubview:bannerView];
    bannerView.imageUrlArr = self.imageUrlArr;
}



@end
