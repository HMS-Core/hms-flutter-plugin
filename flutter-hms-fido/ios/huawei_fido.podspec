#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint huawei_fido.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_fido'
  s.version          = '5.0.5+305'
  s.summary          = 'HUAWEI FIDO Kit plugin for Flutter.'
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.description      = <<-DESC
HUAWEI FIDO Kit plugin for Flutter. It provides your app with FIDO2 based on the WebAuthn standart.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          = { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.source           = { :git => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-fido' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
