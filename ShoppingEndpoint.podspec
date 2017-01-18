Pod::Spec.new do |s|
  s.name        = "ShoppingEndpoint"
  s.version     = "0.0.1"
  s.summary     = "endpoint requests for shopping"
  s.homepage    = "https://github.com/sperev/ShoppingEndpoint"
  s.license     = { :type => "MIT" }
  s.authors     = { "Sergei Perevoznikov" => "sperev@bk.ru" }

  s.requires_arc = true
  s.ios.deployment_target = "8.0"
  s.source   = { :git => "https://github.com/sperev/ShoppingEndpoint.git", :tag => s.version }
  s.source_files = "Sources/*.swift", "Sources/**/*.swift"
  s.dependency 'Alamofire', '4.2.0'
  s.dependency 'ShoppingModels', '0.0.2'
  s.dependency 'ObjectMapper', '2.2.2'
end
