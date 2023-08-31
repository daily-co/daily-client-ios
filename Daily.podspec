Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.10.0"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://www.daily.co/sdk/daily-client-ios-0.10.0.zip',
                              :sha256 => "c05814fea6b6c8df2a313c648d00f010a811d5d7f9f160bf7794e0f332077f1f",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
