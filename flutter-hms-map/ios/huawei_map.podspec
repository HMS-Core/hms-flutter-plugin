#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint account.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_map'
  s.version          = '5.0.3+303'
  s.summary          = 'HUAWEI Map Kit plugin for Flutter.'
  s.description      = <<-DESC
  HUAWEI Map Kit plugin for Flutter. Huawei Map Kit, provides standard maps as well as UI elements for you to customize maps that better meet service scenarios.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license = { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.source           = { :git => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-map' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
