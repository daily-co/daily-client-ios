Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.41.0"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://sdk-downloads.daily.co/daily-client-ios-0.41.0.zip',
                              :sha256 => "df14d1f113ae88e3dc78f286a6f843e231c911a3eb326b2e976331781561360b",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
