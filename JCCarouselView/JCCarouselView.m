//
//  JCCarouselView.m
//  JCCarouselViewDemo
//
//  Created by 郑嘉成 on 2017/2/5.
//  Copyright © 2017年 ZhengJiacheng. All rights reserved.
//

#import "JCCarouselView.h"

static NSTimeInterval const JCDefaultTimeInterval = 3;//默认滚动间隔
static NSString *const JCDefaultPlaceholderImageName = @"placeholder";

@interface JCCarouselView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *curImageView;
@property (nonatomic, strong) UIImageView *otherImageView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, assign) NSInteger nextIndex;

@end

@implementation JCCarouselView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initSubviews];
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)initSubviews{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.curImageView];
    [self.scrollView addSubview:self.otherImageView];
    [self addSubview:self.pageControl];
    self.placeholderImage = [UIImage imageNamed:JCDefaultPlaceholderImageName];
    self.timeInterval = JCDefaultTimeInterval;
}

- (void)setCurPageControlImage:(UIImage *)curPageControlImage{
    [self.pageControl setValue:curPageControlImage forKey:@"currentPageImage"];
}

- (void)setPageControlImage:(UIImage *)pageControlImage{
    [self.pageControl setValue:pageControlImage forKey:@"pageImage"];
}

- (void)setCurPageControlColor:(UIColor *)curPageControlColor{
    self.pageControl.currentPageIndicatorTintColor = curPageControlColor;
}

- (void)setPageControlColor:(UIColor *)pageControlColor{
    self.pageControl.pageIndicatorTintColor = pageControlColor;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
    }
    return _pageControl;
}

- (void)setCurIndex:(NSInteger)curIndex{
    _curIndex = curIndex;
    self.pageControl.currentPage = curIndex;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = ({
            UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
            scrollView.contentSize = CGSizeMake(3 * self.width, self.height);
            scrollView.pagingEnabled = YES;
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.delegate = self;
            scrollView.clipsToBounds = YES;
            scrollView.bounces = NO;
            scrollView.contentInset = UIEdgeInsetsZero;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageView)];
            [scrollView addGestureRecognizer:tap];
            [scrollView setContentOffset:CGPointMake(self.width, 0)];
            scrollView;
        });
    }
    return _scrollView;
}

- (UIImageView *)curImageView{
    if (!_curImageView) {
        _curImageView = ({
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width, 0, self.width, self.height)];
            imageView.clipsToBounds = YES;
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            imageView;
        });
    }
    return _curImageView;
}

- (UIImageView *)otherImageView{
    if (!_otherImageView) {
        _otherImageView = ({
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            imageView.clipsToBounds = YES;
            imageView;
        });
    }
    return  _otherImageView;
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval{
    [self stopTimer];
    _timeInterval = timeInterval;
    [self startTimer];
}

- (void)startTimer{
    [self stopTimer];
    _timer = [NSTimer timerWithTimeInterval:self.timeInterval target:self selector:@selector(autoScrollToNextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)clickImageView{
    if (self.clickBlock) {
        self.clickBlock(self.curIndex);
    } else if ([self.delegate respondsToSelector:@selector(carouselView:didSelectedAtIndex:)]){
        [self.delegate carouselView:self didSelectedAtIndex:self.curIndex];
    }
}

#pragma mark - 自动右滑
- (void)autoScrollToNextImage{
    if (!self.imageUrlArr || self.imageUrlArr.count < 1) {
        return;
    }
    self.nextIndex = self.curIndex == self.imageUrlArr.count - 1 ? 0 : self.curIndex + 1;
    [self setupNextPageImageView];
    [self.scrollView setContentOffset:CGPointMake(self.width * 2, 0) animated:YES];
}

- (void)setImageUrlArr:(NSArray *)imageUrlArr{
    NSMutableArray *mutableArr = [NSMutableArray arrayWithCapacity:imageUrlArr.count];
    for (NSURL *obj in imageUrlArr) {
        NSURL *url = obj;
        if ([obj isKindOfClass:NSString.class]) {
            url = [NSURL URLWithString:(NSString *)obj];
        }
        if (!url) {
            continue;
        }
        [mutableArr addObject:url];
    }
    _imageUrlArr = mutableArr;
    _curIndex = 0;
    if (_imageUrlArr.count < 1) {
        return;
    }
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = _imageUrlArr.count;
    [self configCurrentImageView];
    [self startTimer];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.pageControl.center = CGPointMake(self.width/2, self.height - 10);
}

- (void)configCurrentImageView{
    if (_imageUrlArr.count < 1) {
        return;
    }
    NSURL *imageUrl = _imageUrlArr.firstObject;
    [self.curImageView sd_setImageWithURL:imageUrl placeholderImage:self.placeholderImage];
}

- (void)setupNextPageImageView{
    if (!self.imageUrlArr || self.imageUrlArr.count < 1) {
        return;
    }
    NSURL *nextImageUrl = self.imageUrlArr[self.nextIndex];
    if ([self.otherImageView.sd_imageURL.absoluteString isEqualToString:nextImageUrl.absoluteString]) {
        return;//防止重复设置图片
    }
    [self.otherImageView sd_setImageWithURL:nextImageUrl placeholderImage:self.placeholderImage];
}

- (void)scrollToMiddlePage{
    if (self.scrollView.contentOffset.x == self.width) {
        return;
    }
    [self.curImageView sd_setImageWithURL:self.imageUrlArr[self.nextIndex] placeholderImage:self.placeholderImage];
    self.curIndex = self.nextIndex;
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
}

#pragma mark -
#pragma mark -- scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.imageUrlArr || self.imageUrlArr.count < 1) {
        return;
    }
    if (scrollView.contentOffset.x > self.width) {
        self.nextIndex = self.curIndex == self.imageUrlArr.count - 1 ? 0 : self.curIndex + 1;
        self.otherImageView.frame = CGRectMake(self.width * 2, 0, self.width, self.height);
    }else if (scrollView.contentOffset.x < self.width) {
        self.nextIndex = self.curIndex - 1 < 0 ? self.imageUrlArr.count - 1 : self.curIndex - 1;
        self.otherImageView.frame = CGRectMake(0, 0, self.width, self.height);
    }
    [self setupNextPageImageView];
}

#pragma mark 回到中间位置图片
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollToMiddlePage];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollToMiddlePage];
}

#pragma mark 开始拖拽时停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

#pragma mark 停止拖拽时开启计时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

@end
