
Pod::Spec.new do |s|
  s.name         = "RNGoogleGeometry"
  s.version      = "1.0.0"
  s.summary      = "RNGoogleGeometry"
  s.description  = <<-DESC
                  RNGoogleGeometry
                   DESC
  s.homepage     = "https://github.com/x8bit/react-native-google-geometry"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/x8bit/react-native-google-geometry.git", :tag => "master" }
  s.source_files  = "RNGoogleGeometry/**/*.{h,m}"
  #s.requires_arc = true
  s.compiler_flags = '-fno-modules'

  s.dependency 'React'
  s.dependency 'GoogleMaps', '2.5.0'
end

  