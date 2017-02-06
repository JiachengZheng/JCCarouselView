//
//  ViewController.m
//  JCCarouselViewDemo
//
//  Created by 郑嘉成 on 2017/2/5.
//  Copyright © 2017年 ZhengJiacheng. All rights reserved.
//

#import "ViewController.h"
#import "JCCarouselView.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) NSInteger currentIndex;
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
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 280, self.view.frame.size.width, 220)];
    [self.view addSubview:self.imageView];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    self.imageView.clipsToBounds = YES;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlArr.firstObject]];
    self.imageView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *leftSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.imageView addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [self.imageView addGestureRecognizer:rightSwipeGesture];
}

-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:1];
}

-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:2];
}

-(void)transitionAnimation:(NSInteger)direction{
    CATransition *transition=[[CATransition alloc]init];
    transition.type= @"rippleEffect";//kCATransitionPush;//@"rippleEffect";
    
    BOOL right = YES;
    
    //设置子类型
    if (direction == 1) {
        transition.subtype=kCATransitionFromRight;
        right = YES;
    }else if (direction == 2) {
        transition.subtype=kCATransitionFromLeft;
        right = NO;
    }

    transition.duration = 1.f;

    if (right) {
        _currentIndex=(_currentIndex+1)%self.imageUrlArr.count;
    }else{
        _currentIndex=(_currentIndex-1+self.imageUrlArr.count)%4;
    }
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrlArr[_currentIndex]]];
    [_imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation1"];
}


@end
