#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint huawei_ml.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_ml'
  s.version          = '2.0.5+301'
  s.summary          = 'HUAWEI Ml Kit plugin for Flutter.'
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.description      = <<-DESC
HUAWEI Ml Kit plugin for Flutter. It provides diversified leading machine learning capabilities that are easy to use, helping you develop various AI apps.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          = { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.source           = { :git => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-ml' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
