Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.30.0"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://www.daily.co/sdk/daily-client-ios-0.30.0.zip',
                              :sha256 => "275a3a79506baca95110bb6e73c9b622ec0b7cedd32e8a15334fd7e8330df709",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
