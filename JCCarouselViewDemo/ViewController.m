//
//  ViewController.m
//  JCCarouselViewDemo
//
//  Created by 郑嘉成 on 2017/2/5.
//  Copyright © 2017年 ZhengJiacheng. All rights reserved.
//

#import "ViewController.h"
#import "JCCarouselView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JCCarouselView *bannerView = [[JCCarouselView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 220)];
    [self.view addSubview:bannerView];
    bannerView.imageUrlArr = @[@"http://cdn.sspai.com/attachment/thumbnail/2017/01/22/1aaa97293057371535fb408a18fa937c590f1_mw_800_wm_1_wmp_3.jpg",@"http://cdn.sspai.com/attachment/origin/2016/12/26/360721.jpg",@"http://cdn.sspai.com/attachment/origin/2017/01/06/362369.jpg",@"http://cdn.sspai.com/attachment/thumbnail/2017/01/25/e202f92ef3fabed9ef18a4c5ebfc81105926a_mw_800_wm_1_wmp_3.jpg"];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
