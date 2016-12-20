Pod::Spec.new do |s|

  s.name         = 'TBTMap'
  s.version      = '0.0.1'
  s.summary      = 'Tabata iOS SDK Map'
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.homepage     = 'https://github.com/yevgentsyganenko/Map'
  s.authors      = { 'Genek' => 'yevgen.tsyganenko@idapgroup.com' }

  s.source       = { :git => 'https://github.com/yevgentsyganenko/Map.git', :tag => s.version }

  s.platform     = :ios, '8.1'
  s.requires_arc = true

  s.source_files  = 'Source/**/*.{h,m}'

end
