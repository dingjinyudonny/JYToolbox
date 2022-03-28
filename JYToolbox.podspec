Pod::Spec.new do |s|
  s.name             = 'JYToolbox'
  s.version          = '1.0.0'
  s.summary          = '实用工具类'
  s.description      = <<-DESC
    JYNetSpeed 获取网速
    JYTickTockTime 查看代码的执行时间
                       DESC

  s.homepage         = 'https://github.com/dingjinyudonny/JYToolbox'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '丁进宇' => 'dingjinyuit@163.com' }
  s.source           = { :git => 'https://github.com/dingjinyudonny/JYToolbox.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'JYToolbox/Classes/**/*.{h,m}'
  # s.resource_bundles = {
  #   'JYToolbox' => ['JYToolbox/Assets/*.png']
  # }
  s.public_header_files = 'JYToolbox/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
