#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint location.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_location'
  s.version          = '5.1.0+301'
  s.summary          = 'HUAWEI Location Kit plugin for Flutter.'
  s.description      = <<-DESC
  HUAWEI Flutter Location Kit plugin combines the Global Navigation Satellite System (GNSS), Wi-Fi, and base station location functionalities into your app.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          = { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.source           = { :git => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-location' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
