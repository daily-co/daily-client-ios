Pod::Spec.new do |spec|
  spec.name               = "DailySystemBroadcast"
  spec.version            = "0.33.0"
  spec.summary            = "The Daily System Broadcast extension for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Framework to make It easy add support for screen share on iOS."
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://sdk-downloads.daily.co/daily-system-broadcast-client-ios-0.33.0.zip',
                              :sha256 => "2c1ff7890645bde347a1a81ff11b21a1800e593a4da1d96a8219fd043edf18c7",
                              :flatten => false }
  spec.vendored_frameworks = "DailySystemBroadcast.xcframework"
end
