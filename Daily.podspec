Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.35.0"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://sdk-downloads.daily.co/daily-client-ios-0.35.0.zip',
                              :sha256 => "db206b1cb1f94863dac8615278fd027e16f502c4eaaa5db1c62633ea5d193477",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
