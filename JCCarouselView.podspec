
Pod::Spec.new do |s|

  s.name         = "JCCarouselView"
  s.version      = "1.0.3"
  s.summary      = "两个UIImageView实现的轮播banner"

  s.homepage     = "https://github.com/JiachengZheng/JCCarouselView"

  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author       = { "zhengjiacheng" => "jiachengzheng@163.com" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => 'https://github.com/JiachengZheng/JCCarouselView.git', :tag => s.version }
  s.source_files  = 'JCCarouselView/*.{h,m}'

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  s.public_header_files = 'JCCarouselView/*.h'
  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency 'SDWebImage'

end
