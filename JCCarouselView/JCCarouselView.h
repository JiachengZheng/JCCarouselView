//
//  JCCarouselView.h
//  JCCarouselViewDemo
//
//  Created by 郑嘉成 on 2017/2/5.
//  Copyright © 2017年 ZhengJiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
typedef void(^JCCarouselViewClickBlock)(NSInteger index);

@class JCCarouselView;

@protocol JCCarouselViewDelegate <NSObject>

@optional
- (void)carouselView:(JCCarouselView *)carouselView didSelectedAtIndex:(NSInteger)index;

@end

@interface JCCarouselView : UIView

/**
 *  图片数组，字符串 or NSUrl
 */
@property (nonatomic, strong) NSArray *imageUrlArr;

/**
 *  滚动间隔时长
 */
@property (nonatomic, assign) NSTimeInterval timeInterval;

/**
 *  点击回调Block
 */
@property (nonatomic, copy) JCCarouselViewClickBlock clickBlock;

/**
 *  点击代理，如果有block 优先响应block
 */
@property (nonatomic, weak) id<JCCarouselViewDelegate> delegate;

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
