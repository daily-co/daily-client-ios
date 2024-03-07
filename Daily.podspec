Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.17.0"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://www.daily.co/sdk/daily-client-ios-0.17.0.zip',
                              :sha256 => "2a75ec90628b43fd3d2439238a0147e4bf07e8f80cfc0126d84571c52940d179",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
