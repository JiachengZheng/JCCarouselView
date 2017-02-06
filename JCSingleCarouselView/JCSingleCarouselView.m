//
//  JCSingleCarouselView.m
//  JCCarouselViewDemo
//
//  Created by zhengjiacheng on 2017/2/6.
//  Copyright © 2017年 ZhengJiacheng. All rights reserved.
//

#import "JCSingleCarouselView.h"
#import "UIImageView+WebCache.h"

typedef NS_ENUM(NSUInteger, JCCarouselDirection) {
    JCCarouselDirectionNone,
    JCCarouselDirectionLeft,
    JCCarouselDirectionRight,
};

@interface JCSingleCarouselView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation JCSingleCarouselView


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupSubviews];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_imageView];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        _imageView.clipsToBounds = YES;
        
        _imageView.userInteractionEnabled = YES;
        UISwipeGestureRecognizer *leftSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
        leftSwipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;
        [_imageView addGestureRecognizer:leftSwipeGesture];
        
        UISwipeGestureRecognizer *rightSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
        rightSwipeGesture.direction=UISwipeGestureRecognizerDirectionRight;
        [_imageView addGestureRecognizer:rightSwipeGesture];
    }
    return _imageView;
}

- (void)setupSubviews{
    [self addSubview:self.imageView];
    [self addSubview:self.pageControl];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.pageControl.center = CGPointMake(self.width/2, self.height - 10);
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
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
    [self startTimer];
    [self.imageView sd_setImageWithURL:_imageUrlArr.firstObject];
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

-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self stopTimer];
    [self transitionAnimation:JCCarouselDirectionLeft];
    if (gesture.state >= UIGestureRecognizerStateEnded) {
        [self startTimer];
    }
}

-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self stopTimer];
    [self transitionAnimation:JCCarouselDirectionRight];
    if (gesture.state >= UIGestureRecognizerStateEnded) {
        [self startTimer];
    }
}

- (void)autoScrollToNextImage{
    [self transitionAnimation:JCCarouselDirectionLeft];
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

-(void)transitionAnimation:(NSInteger)direction{
    CATransition *transition=[[CATransition alloc]init];
    transition.type= kCATransitionPush;//@"rippleEffect";
    
    BOOL right = YES;
    
    //设置子类型
    if (direction == JCCarouselDirectionLeft) {
        transition.subtype=kCATransitionFromRight;
        
    }else if (direction == JCCarouselDirectionRight) {
        transition.subtype=kCATransitionFromLeft;
        right = NO;
    }
    
    transition.duration = .25f;
    
    if (right) {
        self.curIndex=(_curIndex + 1) % self.imageUrlArr.count;
    }else{
        self.curIndex=(_curIndex - 1 + self.imageUrlArr.count) % self.imageUrlArr.count;
    }
    [self.imageView sd_setImageWithURL:self.imageUrlArr[self.curIndex]];
    [self.imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}


@end
