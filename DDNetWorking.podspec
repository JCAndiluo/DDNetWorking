Pod::Spec.new do |s|
  # 1. 框架名称（必须唯一，建议与文件夹名一致）
  s.name         = "DDNetWorking"
  # 2. 版本号（首次发布用 1.0.0）
  s.version      = "1.0.0"
  # 3. 简短描述（一句话介绍）
  s.summary      = "A network framework"
  # 4. 详细描述（至少 10 个字符）
  s.description  = <<-DESC
                   DDNetWorking is a wrapper for network requests
                   DESC
  # 5. 主页（你的 GitHub 仓库地址，先空着，后面创建仓库后补充）
  s.homepage     = "https://github.com/JCAndiluo/DDNetWorking"
  # 6. 许可证（用 MIT，需创建 LICENSE 文件）
  s.license      = { :type => "MIT", :file => "LICENSE" }
  # 7. 作者信息（你的名字和邮箱）
  s.author       = { "JC" => "zhanmi5200@qq.com" }
  # 8. 源代码地址（GitHub 仓库地址，同 homepage，后面补充）
  s.source       = { :git => "https://github.com/JCAndiluo/DDNetWorking.git", :tag => s.version.to_s }
  # 9. 支持平台及最低版本（与你的代码兼容的 iOS 版本）
  s.platform     = :ios, "13.0"
s.pod_target_xcconfig = {
  'IPHONEOS_DEPLOYMENT_TARGET' => '13.0',  # 与你的框架最低版本一致
"CLANG_ENABLE_OBJC_ARC" => "YES"
}
s.user_target_xcconfig = {
  'IPHONEOS_DEPLOYMENT_TARGET' => '13.0'
}
  # 10. Swift 版本（你的代码使用的 Swift 版本，如 5.0）
  s.swift_version = "5.0"
  # 11. 源代码路径（匹配你的代码存放位置）
  s.source_files = "**/*.{swift}"
end