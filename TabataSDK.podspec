Pod::Spec.new do |s|

  s.name         = ‘TBTMap’
  s.version      = ‘0.0.1’
  s.summary      = 'Tabata map’
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = 'IDAP'
  s.homepage     = 'https://github.com/yevgentsyganenko/Map'

  s.source       = { :git => 'https://github.com/yevgentsyganenko/Map.git', :tag => s.version }

  s.platform     = :ios, '8.1'
  s.requires_arc = true

  s.source_files  = ’Source/**/*.{h,m}'

end
