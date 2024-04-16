Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.19.0"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://www.daily.co/sdk/daily-client-ios-0.19.0.zip',
                              :sha256 => "88d5addd40061bb553d63d3b95504eaa7a61f3708b53a98be601ab3c4bfc4ce6",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
