Pod::Spec.new do |spec|
  spec.name               = "Daily"
  spec.version            = "0.3.1"
  spec.summary            = "The Daily Client SDK for iOS"
  spec.homepage           = "https://github.com/daily-co/daily-client-ios"
  spec.description        = "The Daily Client SDK allows you to build video and audio calling into your iOS applications"
  spec.documentation_url  = "https://docs.daily.co/guides/products/mobile/ios"
  spec.license            = { :type => "BSD-2" }
  spec.author             = { "Daily.co" => "help@daily.co" }
  spec.swift_version      = "5.0"
  spec.platforms          = { :ios => '13.0' }
  spec.source             = { :http => 'https://www.daily.co/sdk/daily-client-ios-0.3.1.zip',
                              :sha256 => "99a3e82ced3d34bc046205b7569c1f10998bb628ef9de25db5cbd1346ac25214",
                              :flatten => false }
  spec.vendored_frameworks = "Daily.xcframework"
end
