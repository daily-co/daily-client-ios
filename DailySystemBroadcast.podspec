Pod::Spec.new do |spec|
  spec.name               = "DailySystemBroadcast"
  spec.version            = "0.19.0"
  spec.summary            = "The Daily System Broadcast extension for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Framework to make It easy add support for screen share on iOS."
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://www.daily.co/sdk/daily-system-broadcast-client-ios-0.19.0.zip',
                              :sha256 => "be0e527a1fc3f9ff60ee5b91024268e1c1bd18febbd8b028ca8587890ebc2aa7",
                              :flatten => false }
  spec.vendored_frameworks = "DailySystemBroadcast.xcframework"
end
