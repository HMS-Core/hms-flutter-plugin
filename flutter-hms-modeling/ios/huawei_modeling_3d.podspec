#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint huawei_modeling3d.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'huawei_modeling3d'
  s.version          = '1.1.0+300'
  s.summary          = 'HUAWEI 3D Modeling Kit plugin for Flutter.'
  s.description      = <<-DESC
3D Modeling Kit provides material generation and 3D object reconstruction capabilities to help with creating 3D content more efficiently at a lower cost.
                       DESC
  s.homepage         = 'https://www.huawei.com'
  s.license          = { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Huawei Technologies' => 'huaweideveloper1@gmail.com' }
  s.source           = { :git => 'https://github.com/HMS-Core/hms-flutter-plugin/tree/master/flutter-hms-modeling3d' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
