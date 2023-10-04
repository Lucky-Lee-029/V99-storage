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
    "MMKV/Core",
    "MMKV/Core/*.{h,cpp,hpp}",
    "MMKV/Core/aes/*",
    "MMKV/Core/aes/openssl/*",
    "MMKV/Core/crc32/*.h"
  ]
  # Any private headers that are not globally unique should be mentioned here.
  # Otherwise there will be a nameclash, since CocoaPods flattens out any header directories
  # See https://github.com/firebase/firebase-ios-sdk/issues/4035 for more details.
  s.preserve_paths = [
    'ios/**/*.h'
  ]

  s.dependency "MMKV", ">= 1.2.13"
  s.dependency "React-Core"
end