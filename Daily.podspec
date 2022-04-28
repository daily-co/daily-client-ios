Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.1.1"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.homepage           = "https://docs.daily.co/guides/products/mobile#introducing-dailys-native-mobile-libraries-beta"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://www.daily.co/sdk/daily-client-ios-0.1.1.zip',
                              :sha256 => "16bc7a87a7d1ca658166bd291d9ca94ffd7700a12e8f9c59562382bbd86c8723",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
