Pod::Spec.new do |s|
    s.name             = "WJUIRoutable"
    s.version          = '2.0'
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

    s.subspec 'API' do |sapi|
        sapi.source_files = 'Classes/Api/*'
        sapi.public_header_files = 'Classes/Api/*.h'

        sapi.dependency 'WJConfig'
    end

    s.subspec 'Core' do |score|
        score.source_files = 'Classes/Core/*'
        score.public_header_files = 'Classes/Core/*.h'

        score.dependency 'WJUIRoutable/API'
        score.dependency 'WJCommon/Core'
        score.dependency 'WJCommon/Utils'
        score.dependency 'WJLoggingAPI'
    end

end
