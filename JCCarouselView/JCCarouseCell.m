//
//  JCCarouseCell.m
//  JCCarouselViewDemo
//
//  Created by 郑嘉成 on 2017/11/23.
//  Copyright © 2017年 ZhengJiacheng. All rights reserved.
//

#import "JCCarouseCell.h"
#import "UIImageView+WebCache.h"
@interface JCCarouseCell()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *commonImageView;
@property (nonatomic, strong) UIView *customView;
@end

@implementation JCCarouseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    self.scrollView.userInteractionEnabled = NO;
    self.commonImageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    [self.scrollView addSubview:self.commonImageView];
    self.commonImageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setupWithCustomView:(UIView *)customView{
    self.customView = customView;
    self.customView.hidden = NO;
}

- (void)setupWithImageURL:(NSURL *)imageURL{
    self.customView.hidden = YES;
    [self.commonImageView sd_setImageWithURL:imageURL placeholderImage:nil];
}

- (void)prepareForReuse{
    self.scrollView.contentOffset = CGPointZero;
}

- (void)parallax:(CGFloat)offset{
    [self.scrollView setContentOffset:CGPointMake(offset, 0)];
    NSLog(@"%f",offset);
}


@end
