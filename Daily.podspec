Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.22.0"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://www.daily.co/sdk/daily-client-ios-0.22.0.zip',
                              :sha256 => "1324e8c058075a24fba88a9d686e584ceb3a1ba3d08383331d0bc9b6ab55d9b8",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
