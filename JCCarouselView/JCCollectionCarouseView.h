//
//  JCCollectionCarouseView.h
//  JCCarouselViewDemo
//
//  Created by 郑嘉成 on 2017/11/23.
//  Copyright © 2017年 ZhengJiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JCCollectionCarouseView;

@protocol JCCarouseViewDataSource<NSObject>
- (NSInteger)numberOfCarouseView:(JCCollectionCarouseView *)carouseView;

- (NSURL *)carouseView:(JCCollectionCarouseView *)carouseView imageURLForIndex:(NSUInteger )index;
@end

@protocol JCCarouseViewProtocol<NSObject>
- (void)carouseView:(JCCollectionCarouseView *)carouseView didSelectedAtIndex:(NSUInteger )index;
- (void)carouseView:(JCCollectionCarouseView *)carouseView willDisplayViewAtIndex:(NSUInteger )index;
@end

@interface JCCollectionCarouseView : UIView

@property (nonatomic, weak) id<JCCarouseViewDataSource> dataSource;
@property (nonatomic, weak) id<JCCarouseViewProtocol> delegate;

- (void)reloadData;
@end



