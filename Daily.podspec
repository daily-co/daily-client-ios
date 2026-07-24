Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.39.0"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://sdk-downloads.daily.co/daily-client-ios-0.39.0.zip',
                              :sha256 => "bcef1414bc3bc291bbfb26cb6c3cae7da251be0b2833ec63ca2ff0524ede1b8e",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
