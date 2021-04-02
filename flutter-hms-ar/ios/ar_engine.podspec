#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint huawei_arengine.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_ar'
  s.version          = '2.13.0+5'
  s.summary          = 'Huawei AR Engine Plugin for Flutter.'
  s.description      = <<-DESC
Huawei AR Engine Flutter Plugin is a platform for building augmented reality (AR) apps on Android
  smartphones using the Flutter framework.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          = { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.source           = { :git => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-ar' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
