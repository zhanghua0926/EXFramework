
Pod::Spec.new do |s|

  s.name         = "EXFramework"
  s.version      = "0.1.6"
  s.summary      = "iOS base framework so that develop you can quickly"
  s.description  = <<-DESC
                   include common use function ,such as extend control, networking, customer control...
                     DESC
  s.homepage     = "https://github.com/zhanghua0926/EXFramework"
  s.license      = "MIT"
  s.author             = { "翾燚" => "zh19920926@live.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/zhanghua0926/EXFramework.git", :tag => "#{s.version}" }



# s.source_files  = "EXFramework/EXFramework/**/*.{h,m}"
  s.subspec 'EXCalendar' do |calendar|
      calendar.source_files = "EXFramework/EXFramework/EXCalendar/*.{h,m}"
  end

  s.subspec 'EXDefine' do |define|
      define.source_files = "EXFramework/EXFramework/EXDefine/*.{h,m}"
  end

  s.subspec 'EXNavigation' do |navigation|
      navigation.source_files = "EXFramework/EXFramework/EXNavigation/*.{h,m}"
      navigation.dependency 'EXFramework/EXDefine'
      navigation.dependency 'EXFramework/EXUIKit'
  end

  s.subspec 'EXNetworking' do |networking|
      networking.source_files = "EXFramework/EXFramework/EXNetworking/*.{h,m}"
      networking.dependency 'EXFramework/EXDefine'
  end

  s.subspec 'EXObject' do |object|
      object.source_files = "EXFramework/EXFramework/EXObject/*.{h,m}"
  end

  s.subspec 'EXUIKit' do |uikit|
      uikit.source_files = "EXFramework/EXFramework/EXUIKit/*.{h,m}"
      uikit.dependency 'EXFramework/EXDefine'
  end

  s.subspec 'EXStorage' do |storage|
      storage.source_files = "EXFramework/EXFramework/EXStorage/*.{h,m}"
  end


  s.dependency "AFNetworking", "~> 3.2.1"

end
