Pod::Spec.new do |spec|
  spec.name               = "DailySystemBroadcast"
  spec.version            = "0.30.0"
  spec.summary            = "The Daily System Broadcast extension for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Framework to make It easy add support for screen share on iOS."
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://www.daily.co/sdk/daily-system-broadcast-client-ios-0.30.0.zip',
                              :sha256 => "74186e6120c414608f3884c997a7bf61ae9a9e1e7ab2dcfc840ac571eeaa8fdd",
                              :flatten => false }
  spec.vendored_frameworks = "DailySystemBroadcast.xcframework"
end
