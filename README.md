# JCCarouselView
两个UIImageView 以及一个UIImageView 分别实现的轮播图，图片加载使用的是**SDWebImage**

# 使用

```
platform :ios, '7.0'
pod 'JCCarouselView' 
```

#Demo

```
JCCarouselView *bannerView = [[JCCarouselView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 220)];
[self.view addSubview:bannerView];
bannerView.imageUrlArr = self.imageUrlArr;

bannerView.placeholderImage = [UIImage imageNamed:@"placeholder"];
bannerView.curPageControlImage = [UIImage imageNamed:@"Group"];
bannerView.pageControlImage = [UIImage imageNamed:@"Group1"];

//bannerView.pageControlColor = [UIColor whiteColor];
//bannerView.curPageControlColor = [UIColor redColor];

bannerView.timeInterval = 4;
bannerView.delegate = self;
bannerView.clickBlock = ^(NSInteger index){
};    
```
更多请查看Demo

# About Me

QQ:1083841067

Email:jiacheng_zheng@163.com

如果你发现bug，please pull reqeust me 

如果你有更好的改进，please pull reqeust me
