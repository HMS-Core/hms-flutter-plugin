#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint awareness.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_awareness'
  s.version          = '1.0.7+304'
  s.summary          = 'HUAWEI Awareness Kit Plugin for Flutter.'
  s.description      = <<-DESC
  HUAWEI Awareness Kit provides your app with the ability to obtain contextual information including users' time, location, behavior, ambient light, weather, and nearby beacons.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          = { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.source           = { :git => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-awareness' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
