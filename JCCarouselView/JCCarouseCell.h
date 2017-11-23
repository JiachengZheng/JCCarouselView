//
//  JCCarouseCell.h
//  JCCarouselViewDemo
//
//  Created by 郑嘉成 on 2017/11/23.
//  Copyright © 2017年 ZhengJiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCCarouseCell : UICollectionViewCell
- (void)setupWithCustomView:(UIView *)customView;

- (void)setupWithImageURL:(NSURL *)imageURL;

- (void)parallax:(CGFloat)offset;
@end
