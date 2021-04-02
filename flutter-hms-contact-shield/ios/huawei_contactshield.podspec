#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint huawei_contactshield.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_contactshield'
  s.version          = '5.1.0+301'
  s.summary          = 'HUAWEI Contact Shield plugin for Flutter.'
  s.description      = <<-DESC
  To help confront the global pandemic of coronavirus disease 2019 (COVID-19), Huawei provides HMS Core Contact Shield for developers to develop epidemic prevention and control apps.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          = { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.source           = { :git => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-contact-shield' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
