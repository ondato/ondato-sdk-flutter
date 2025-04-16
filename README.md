# Ondato Flutter

A Plugin and an example app for using Ondato SDK in Flutter.

For full Ondato implementation sample open example folder.

## Getting Started

To use this plugin:

1. add dependency;
2. setup android;
3. setup ios;
4. use plugin in application.

### Add dependency

Add `ondato_flutter` as a dependency in your pubspec.yaml file;

```
ondato_flutter:
    git:
      url: git@github.com:ondato/sample-sdk-app-flutter.git
      ref: main
```

### Android

1. Go to `android/app/build.gradle` and change minSdkVersion to `minSdkVersion 24`

2. In `android/app/src/main/AndroidManifest.xml` add `android:theme="@style/Theme.AppCompat.Light"`

```
 <application
        android:theme="@style/Theme.AppCompat.Light"
        android:label="ondato_flutter_example"
        android:icon="@mipmap/ic_launcher">
  </application>
```

### iOS

1. In the same `ios/Podfile` add `platform :ios, '13.0'` at the top of the file;

2. Add camera usage description in `ios/Runner/Info.plist`:

```
<key>NSCameraUsageDescription</key>
	<string>Required for document and facial capture</string>
```

### Use plugin

Add your identification ID, start the application and press the button to start the identification process. Don't forget to initialise the SDK first!

```dart
import 'package:ondato_flutter/ondato_config.dart';
import 'package:ondato_flutter/ondato_flutter.dart';
...
String yourIdentificationId = 'YOUR_IDENTIFICATION_ID';

OndatoFlutter.init(
  OndatoServiceConfiguration(
    identificationId: yourIdentificationId, 
    language: OndatoLanguage.en, // Could be any of the languages provided in the OndatoLanguage enum, default is "en"
    mode: OndatoEnvironment.test, // Can be "test" or "live" environments on which the SDK will
    flowConfiguration: OndatoFlowConfiguration( // customisation of identification flow
      showSuccessWindow: true,
      showStartScreen: true,
    ),
    appearance: OndatoIosAppearance( // customisation of UI elements for iOS
      errorColor: Colors.orange,
      progressColor: Colors.orange,
    ),
  ),
);

...

TextButton(
  onPressed: () => startIdentification(),
  child: Text('Start Identification'),
)
...
```

## Theme Customization

### Android

In order to enhance the user experience on the transition between your application and the SDK, you can provide some customisation by defining certain colors inside your own `android/app/src/main/res/values/colors.xml` file:

ondatoColorProgressBarAccent: Defines the color of the ProgressBarView which guides the user through the flow

ondatoColorButtonText: Defines the background color of the primary action buttons text

ondatoColorButtonBackgroundUnfocused: Defines the background color of the primary action buttons

ondatoColorButtonBackgroundFocusedStart: Defines the background color of the primary action buttons gradient start when pressed

ondatoColorButtonBackgroundFocusedCenter: Defines the background color of the primary action buttons gradient center when pressed

ondatoColorButtonBackgroundFocusedEnd: Defines the background color of the primary action buttons gradient end when pressed

ondatoColorErrorBg: Defines the background color of the error message background

ondatoColorErrorText: Defines the background color of the error message text color

ondatoColorPrimaryDark: Defines the taskbar color

Example of `colors.xml` file:

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="ondatoColorProgressBarAccent">#FF0099CC</color>
</resources>
```

### iOS

For iOS, use `OndatoIosAppearance appearance` on `OndatoServiceConfiguration` class.

Example of `OndatoIosAppearance` class:

```dart
OndatoServiceConfiguration(
  appearance: OndatoIosAppearance(
    errorColor: Colors.orange,
    progressColor: Colors.orange,
  ),
)
```

## Additional Functionalities

Since version 2.6.0, the NFC reader and screen recorder functionalities were separated from the core package, meaning that if you want to use those as before, you'll need to import those separate packages explicitly. For convenience, two new Flutter packages were created, `ondato_flutter_nfc_reader` and `ondato_flutter_screen_recorder`, which contain NFC tag scanning and screen recording functionalities, respectively.

To include those dependencies, the process is pretty much the same as you'd add `ondato_flutter` as a dependency in your pubspec.yaml file, just add a `path` parameter, which points directly to that particular feature package. For example:

```
ondato_flutter_nfc_reader:
    git:
      url: git@github.com:ondato/ondato-sdk-flutter.git
      ref: main
      path: ondato_flutter_nfc_reader
```