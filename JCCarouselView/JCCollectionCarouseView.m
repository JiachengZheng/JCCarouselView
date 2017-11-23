//
//  JCCollectionCarouseView.m
//  JCCarouselViewDemo
//
//  Created by 郑嘉成 on 2017/11/23.
//  Copyright © 2017年 ZhengJiacheng. All rights reserved.
//

#import "JCCollectionCarouseView.h"
#import "JCCarouseCell.h"
@interface JCCollectionCarouseView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic) NSUInteger viewCount;
@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, assign) NSInteger realIndex;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation JCCollectionCarouseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setViewCount:(NSUInteger)viewCount{
    _viewCount = viewCount;
    self.pageControl.numberOfPages = viewCount;
}

- (void)setCurIndex:(NSInteger)curIndex{
    _curIndex = curIndex;
    self.pageControl.currentPage = curIndex;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
    }
    return _pageControl;
}

- (void)reloadData{
    _curIndex = 0;
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointMake(self.width, self.height)];
    [self startTimer];
}

- (void)setupViews{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.width, self.height);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[JCCarouseCell class] forCellWithReuseIdentifier:@"JCCarouseCell"];
    [self addSubview:self.pageControl];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.pageControl.center = CGPointMake(self.width/2, self.height - 10);
}

- (NSUInteger)realViewIndex:(NSUInteger )curIndex{
    NSUInteger index = curIndex;
    if (curIndex == 0) {
        index = self.viewCount - 1;
    }else if(curIndex == self.viewCount + 1){
        index = 0;
    }else{
        index -= 1;
    }
    return index;
}

- (void)startTimer{
    [self stopTimer];
    _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(autoScrollToNextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)autoScrollToNextImage{
    _realIndex = (_realIndex + 1) % (self.viewCount + 2);
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_realIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

- (void)showWithParallax{
    for (JCCarouseCell *cell in [self.collectionView visibleCells]) {
        CGFloat gap = self.collectionView.contentOffset.x - cell.frame.origin.x;
        if (fabs(gap) > self.width) {
            return;
        }
        [cell parallax:-gap *0.4];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger index = offset/self.width;
    NSInteger realIndex = [self realViewIndex:index];
    self.realIndex = index;
    if (self.curIndex != realIndex) {
        self.curIndex = realIndex;
    }
    if (offset >= self.width * (self.viewCount + 1)){
        scrollView.contentOffset = CGPointMake(self.width, 0);
    }
    if (offset < 0) {
        scrollView.contentOffset = CGPointMake(self.width * (self.viewCount), 0);
    }
    [self showWithParallax];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.dataSource respondsToSelector:@selector(numberOfCarouseView:)]) {
        self.viewCount = [self.dataSource numberOfCarouseView:self];
        return self.viewCount + 2;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JCCarouseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JCCarouseCell" forIndexPath:indexPath];
    if([self.dataSource respondsToSelector:@selector(carouseView:imageURLForIndex:)]){
        NSURL *url = [self.dataSource carouseView:self imageURLForIndex:[self realViewIndex:indexPath.row]];
        [cell setupWithImageURL:url];
    }
    [self showWithParallax];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(carouseView:didSelectedAtIndex:)]) {
        [_delegate carouseView:self willDisplayViewAtIndex:[self realViewIndex:indexPath.row]];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(carouseView:didSelectedAtIndex:)]) {
        [_delegate carouseView:self didSelectedAtIndex:[self realViewIndex:indexPath.row]];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}
@end








