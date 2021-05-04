# Ondato FLutter

A Plugin and an example app for using Ondato SDK in Flutter.

## Getting Started

To use this plugin:

1. add `ondato_flutter` as a dependency in your pubspec.yaml file;
2. setup android;
3. setup ios;
4. use plugin in application.

### Android

Go to `android/app/build.gradle` and change minSdkVersion to `minSdkVersion 21`

### iOS

In `ios/Podfile` add `pod 'OndatoSDKiOS', :git => "git@github.com:ondato/ondato-sdk-ios.git", tag: '1.6.8'` line

```
target 'Runner' do
  use_frameworks!
  use_modular_headers!

  pod 'OndatoSDKiOS', :git => "git@github.com:ondato/ondato-sdk-ios.git", tag: '1.6.8'
  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

For camera usage access add in `ios/Runner/Info.plist`:
```
<key>NSCameraUsageDescription</key>
	<string>Required for document and facial capture</string>
```

### Use plugin

```dart
import 'package:ondato_flutter/ondato_config_model.dart';
import 'package:ondato_flutter/ondato_flutter.dart';
```

## Theme Customization

### Android

In order to enhance the user experience on the transition between your application and the SDK, you can provide some customisation by defining certain colors inside your own colors.xml file:

ondatoColorProgressBarAccent: Defines the color of the ProgressBarView which guides the user through the flow

ondatoColorButtonText: Defines the background color of the primary action buttons text

ondatoColorButtonBackgroundUnfocused: Defines the background color of the primary action buttons

ondatoColorButtonBackgroundFocusedStart: Defines the background color of the primary action buttons gradient start when pressed

ondatoColorButtonBackgroundFocusedCenter: Defines the background color of the primary action buttons gradient center when pressed

ondatoColorButtonBackgroundFocusedEnd: Defines the background color of the primary action buttons gradient end when pressed

ondatoColorErrorBg: Defines the background color of the error message background

ondatoColorErrorText: Defines the background color of the error message text color

ondatoColorPrimaryDark: Defines the taskbar color