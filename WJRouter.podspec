Pod::Spec.new do |s|
    s.name             = "WJRouter"
    s.version          = '3.1.2'
    s.summary          = "url导航模块."

    s.description      = <<-DESC
        iOS项目url跳转模块
    DESC

    s.homepage         = "https://github.com/yunhaiwu"

    s.license          = { :type => "MIT", :file => "LICENSE" }

    s.author           = { "吴云海" => "halayun@qq.com" }

    s.source           = { :git => "https://github.com/yunhaiwu/ios-wj-uiroutable.git", :tag => "#{s.version}" }

    s.platform     = :ios, "6.0"
    s.requires_arc = true

    s.exclude_files = "Example"

    s.frameworks = 'UIKit', 'Foundation'

    s.source_files = 'Classes/*'
    s.public_header_files = 'Classes/*.h'

    s.dependency 'WJConfig'
    s.dependency 'WJLoggingAPI', '>=2.0'

end
