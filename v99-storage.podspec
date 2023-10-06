require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "v99-storage"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "11.0", :tvos => "12.0", :osx => "10.14" }
  s.source       = { :git => "https://github.com/Lucky-Lee-029/V99-storage.git", :tag => "#{s.version}" }

  # All source files that should be publicly visible
  # Note how this does not include headers, since those can nameclash.
  s.source_files = [
    "ios/**/*.{m,mm}",
    "ios/MmkvModule.h",
    "cpp/**/*.{h,cpp}",
  ]
  
  s.preserve_paths = [
    'ios/**/*.h'
  ]

  s.subspec 'MMKV' do |ss|
    ss.ios.deployment_target = "11.0"

    ss.source_files =  "MMKV/iOS/MMKV/MMKV", "MMKV/iOS/MMKV/MMKV/*.{h,mm,hpp}"
    ss.public_header_files = "MMKV/iOS/MMKV/MMKV/MMKV.h", "MMKV/iOS/MMKV/MMKV/MMKVHandler.h"

    ss.framework    = "CoreFoundation"
    ss.libraries    = "z", "c++"
    ss.requires_arc = false

    ss.subspec 'MMKVCore' do |sss|
      sss.ios.deployment_target = "11.0"

      sss.source_files = "MMKV/Core", "MMKV/Core/*.{h,cpp,hpp}", "MMKV/Core/aes/*", "MMKV/Core/aes/openssl/*", "MMKV/Core/crc32/*.h"
      sss.public_header_files = "MMKV/Core/MMBuffer.h", "MMKV/Core/MMKV.h", "MMKV/Core/MMKVLog.h", "MMKV/Core/MMKVPredef.h", "MMKV/Core/PBUtility.h", "MMKV/Core/ScopedLock.hpp", "MMKV/Core/ThreadLock.h", "MMKV/Core/aes/openssl/openssl_md5.h", "MMKV/Core/aes/openssl/openssl_opensslconf.h"
      sss.compiler_flags = '-x objective-c++'

      sss.requires_arc = ['MMKV/Core/MemoryFile.cpp', 'MMKV/Core/ThreadLock.cpp', 'MMKV/Core/InterProcessLock.cpp', 'MMKV/Core/MMKVLog.cpp', 'MMKV/Core/PBUtility.cpp', 'MMKV/Core/MemoryFile_OSX.cpp', 'MMKV/Core/aes/openssl/openssl_cfb128.cpp', 'MMKV/Core/aes/openssl/openssl_aes_core.cpp', 'aes/openssl/openssl_md5_one.cpp', 'aes/openssl/openssl_md5_dgst.cpp', 'aes/AESCrypt.cpp']

      sss.framework    = "CoreFoundation"
      sss.ios.frameworks = "UIKit"
      sss.libraries    = "z", "c++"
    end
  end
  
  s.dependency "React-Core"
end
