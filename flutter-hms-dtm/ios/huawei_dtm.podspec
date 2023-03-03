#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint huawei_dtm.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_dtm'
  s.version          = '6.6.0+303'
  s.summary          = 'HUAWEI DTM plugin for Flutter.'
  s.description      = <<-DESC
  Huawei DTM plugin for Flutter. With Huawei DTM, you can dynamically update tracking tags to track specific events and report data to third-party analytics platforms.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          =  { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.source           = { :git => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-dtm' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  s.dependency 'DTMSDK' , '6.5.0.301'
  s.dependency 'HiAnalytics' , '6.9.0.300'
  s.static_framework = true
  
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
