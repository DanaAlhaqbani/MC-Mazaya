# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MC Mazaya' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MC Mazaya
# add the Firebase pod for Google Analytics
# add pods for any other desired Firebase products
# https://firebase.google.com/docs/ios/setup#available-pods
pod 'Firebase/Crashlytics'
pod 'IQKeyboardManagerSwift'
pod 'Firebase/Database'
pod 'Firebase/Core'
pod 'FirebaseUI/Auth'
pod 'Firebase/Storage'
pod 'DropDown'
pod 'FirebaseUI/Google'
pod 'FLAnimatedImage'
pod 'SideMenu'
pod 'SDWebImage'
pod 'CHIPageControl/Chimayo'
pod 'JVFloatLabeledTextField'
pod 'MaterialComponents/TextControls+OutlinedTextFields'
pod 'GooglePlaces'
pod 'GoogleMaps'
pod 'NewPopMenu', '~> 2.0'
pod 'MaterialComponents/TextControls+OutlinedTextFieldsTheming'
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
end

