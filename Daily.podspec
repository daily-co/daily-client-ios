Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.33.0"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://sdk-downloads.daily.co/daily-client-ios-0.33.0.zip',
                              :sha256 => "1dd0ec3261ff9ae5c79a6df75b3e55eec6afd7ffc964c126f971e56e96329f89",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
