Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.11.1"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://www.daily.co/sdk/daily-client-ios-0.11.1.zip',
                              :sha256 => "9c2d55f5ceb9a1dae9ce25e3af751f2deeae473fde4cd7dd319c3be660515ba6",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
