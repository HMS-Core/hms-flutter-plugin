#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint analytics.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_analytics'
  s.summary          = 'HUAWEI Analytics Kit plugin for Flutter.'
  s.version          = '6.5.0+301'
  s.description      = <<-DESC
HUAWEI Analytics Kit plugin for Flutter. Analytics Kit offers you a range of preset analytics models so you can gain a deeper insight into your users, products, and content.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          =  { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.source           = { :git => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-analytics' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  s.dependency 'HiAnalytics' , '6.7.0.300'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 arm64' }
  s.swift_version = '5.0'
end
