#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint huawei_ml.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_ml_text'
  s.version          = '3.2.0+300'
  s.summary          = 'HUAWEI Ml Text Kit plugin for Flutter.'
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.description      = <<-DESC
  HUAWEI ML Kit Text Plugin for Flutter. Provides capabilities like Text, document, id, bank card, general card & form recognition.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          = { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.source           = { :git => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-mltext' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
