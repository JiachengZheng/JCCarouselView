Pod::Spec.new do |s|

  s.name         = "JCCarouselView"
  s.version      = "1.0.0"
  s.summary      = "轮播banner 组件"

  s.homepage     = "https://github.com/JiachengZheng/JCCarouselView"
  s.license      = "MIT"

  s.author       = { "ZhengJiacheng" => "jiachengzheng@163.com" }
  s.social_media_url ="http://www.jianshu.com/u/3d8439db292b"
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/JiachengZheng/JCCarouselView", :tag => s.version }


  s.source_files  = "JCCarouselView/*.{h,m}"
  s.requires_arc = true

  s.dependency 'SDWebImage'
end
