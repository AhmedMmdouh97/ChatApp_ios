# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Message Room' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
pod 'Firebase/Firestore'	
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Storage'
pod 'Firebase/Core'


  # Pods for Message Room

  target 'Message RoomTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Message RoomUITests' do
    # Pods for testing
  end
  post_install do |installer|
    installer.project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      end
    end
  end

end
