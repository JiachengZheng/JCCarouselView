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
@interface ViewController ()
@property (nonatomic, strong) NSArray *imageUrlArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageUrlArr = @[
                         @"http://cdn.sspai.com/attachment/thumbnail/2017/01/22/1aaa97293057371535fb408a18fa937c590f1_mw_800_wm_1_wmp_3.jpg",
                         @"http://cdn.sspai.com/attachment/origin/2016/12/26/360721.jpg",
                         @"http://cdn.sspai.com/attachment/origin/2017/01/06/362369.jpg",
                         @"http://cdn.sspai.com/attachment/thumbnail/2017/01/25/e202f92ef3fabed9ef18a4c5ebfc81105926a_mw_800_wm_1_wmp_3.jpg"
                         ];
    
    // JCCarouselView
    [self demo1];
    
    //用一张UIImageView实现的，利用动画转场
    [self demo2];
}

- (void)demo1{
    JCCarouselView *bannerView = [[JCCarouselView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 220)];
    [self.view addSubview:bannerView];
    bannerView.imageUrlArr = self.imageUrlArr;
}

- (void)demo2{
    JCSingleCarouselView *bannerView = [[JCSingleCarouselView alloc]initWithFrame:CGRectMake(0, 280, self.view.frame.size.width, 220)];
    [self.view addSubview:bannerView];
    bannerView.imageUrlArr = self.imageUrlArr;
}



@end
