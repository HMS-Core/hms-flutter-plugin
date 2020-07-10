#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint location.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_location'
  s.version          = '4.0.4'
  s.summary          = 'HUAWEI Flutter Location Kit plugin.'
  s.description      = <<-DESC
  HUAWEI Flutter Location Kit plugin.
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
