//
//  JCCarouselView.h
//  JCCarouselViewDemo
//
//  Created by 郑嘉成 on 2017/2/5.
//  Copyright © 2017年 ZhengJiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCCarouselView : UIView

/**
 *  图片数组，字符串 or NSUrl
 */
@property (nonatomic, strong) NSArray *imageUrlArr;

/**
 *  滚动间隔
 */
@property (nonatomic, assign) NSTimeInterval timeInterval;

/**
 *  占位图片
 *  需提前设置
 */
@property (nonatomic, strong) UIImage *placeholderImage;

/**
 *  当前pageControl图片
 */
@property (nonatomic, strong) UIImage *curPageControlImage;

/**
 *  默认pageControl图片
 */
@property (nonatomic, strong) UIImage *pageControlImage;

/**
 *  当前pageControl颜色
 */
@property (nonatomic, strong) UIColor *curPageControlColor;

/**
 *  默认pageControl颜色
 */
@property (nonatomic, strong) UIColor *pageControlColor;

/**
 *  开启定时器 默认开启
 */
- (void)startTimer;

/**
 *  停止计时器
 */
- (void)stopTimer;


@end
