Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.32.0"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://sdk-downloads.daily.co/daily-client-ios-0.32.0.zip',
                              :sha256 => "341e16e475de016c7f9453777dc9f4ecba140a7d250f6d38dd91e4e348430a31",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
