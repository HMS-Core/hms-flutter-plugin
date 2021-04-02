#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint huawei_wallet.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_wallet'
  s.version          = '4.0.4+302'
  s.summary          = 'HUAWEI Wallet Kit Plugin for Flutter.'
  s.description      = <<-DESC
HUAWEI Wallet Kit provides easy-to-access digital passes such as cards, coupons etc. on an integrated platform.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          = { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.source           = { :git => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-wallet' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
