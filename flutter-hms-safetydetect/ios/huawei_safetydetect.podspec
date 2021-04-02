#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint safetydetect.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_safetydetect'
  s.version          = '5.0.3+301'
  s.summary          = 'Huawei Safety Detect Plugin for Flutter.'
  s.description      = <<-DESC
  Huawei Safety Detect Flutter Plugin exposes all the functionality of the Huawei Safety Detect SDK which builds robust security capabilities.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          = {  :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.source           = { :path => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-safetydetect' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
