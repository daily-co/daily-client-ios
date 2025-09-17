Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.34.0"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://sdk-downloads.daily.co/daily-client-ios-0.34.0.zip',
                              :sha256 => "141bbe7f1b64ccb55cdcbf30ed80f071dd307c686e71c4520e7ea62d1a3b7404",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
