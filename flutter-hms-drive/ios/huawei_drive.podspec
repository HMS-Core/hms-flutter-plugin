#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint drive.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_drive'
  s.version          = '5.0.0+303'
  s.summary          = 'HUAWEI Drive Kit Plugin for Flutter.'
  s.description      = <<-DESC
Huawei Drive Kit provides cloud storage for your apps, enabling users to store files that are created in Drive while using your apps, including photos, videos, and documents.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          = { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.source           = { :git => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-drive' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
