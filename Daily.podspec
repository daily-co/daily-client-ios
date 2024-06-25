Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.21.0"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://www.daily.co/sdk/daily-client-ios-0.21.0.zip',
                              :sha256 => "5335d52278a0191500661acdf59e539314f34dbd3f7b019c70a2435fd3c652d0",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
