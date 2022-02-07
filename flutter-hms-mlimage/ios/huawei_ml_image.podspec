#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint huawei_ml_image.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_ml_image'
  s.version          = '3.2.0+300'
  s.summary          = 'HUAWEI ML Kit Image Plugin for Flutter.'
  s.description      = <<-DESC
  HUAWEI ML Kit Image Plugin for Flutter. Provides capabilities like image classification, object detection and image super resolution.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          = { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.source           = { :git => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-mlimage' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
