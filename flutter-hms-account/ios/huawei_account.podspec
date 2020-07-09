#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint account.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_account'
  s.version          = '5.0.0'
  s.summary          = 'HUAWEI Account Kit plugin for Flutter.'
  s.description      = <<-DESC
  HUAWEI Account Kit plugin for Flutter.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          = { :file => '../LICENSE' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
