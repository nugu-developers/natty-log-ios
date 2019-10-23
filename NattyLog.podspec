Pod::Spec.new do |s|
  s.name = 'NattyLog'
  s.version = '1.0.0'
  s.license = 'Apache License, Version 2.0'
  s.summary = 'Log util in iOS'
  s.homepage = 'https://github.com/nugu-developers/natty-log-ios'
  s.author = { 'SK Telecom Co., Ltd.' => 'nugu_dev_sdk@sk.com' }
  s.source = { :git => 'https://github.com/nugu-developers/natty-log-ios.git', :tag => s.version.to_s }
  s.documentation_url = 'https://developers.nugu.co.kr'
  
  s.ios.deployment_target = '10.0'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'
  s.osx.deployment_target = '10.12'
  
  s.swift_version = '5.0'

  s.source_files = 'NattyLog/Classes/**/*'
end
