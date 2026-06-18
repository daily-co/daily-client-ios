Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.38.0"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://sdk-downloads.daily.co/daily-client-ios-0.38.0.zip',
                              :sha256 => "8475da600254cc74b17d67b9bbe2c6e00aa0444098ce14df9ff5c09b190929ca",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
