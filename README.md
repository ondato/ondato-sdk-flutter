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

1. Go to `android/app/build.gradle` and change minSdkVersion to `minSdkVersion 21`

2. In `android/app/src/main/AndroidManifest.xml` add `android:theme="@style/Theme.AppCompat.Light"`

```
 <application
        android:theme="@style/Theme.AppCompat.Light"
        android:label="ondato_flutter_example"
        android:icon="@mipmap/ic_launcher">
```

### iOS

1. In the same `ios/Podfile` add `platform :ios, '11.0'` at the top of the file;

2. Add camera usage description in `ios/Runner/Info.plist`:

```
<key>NSCameraUsageDescription</key>
	<string>Required for document and facial capture</string>
```

### Use plugin

```dart
import 'package:ondato_flutter/ondato_config_model.dart';
import 'package:ondato_flutter/ondato_flutter.dart';
...
  onPressed: () async {
      await OndatoFlutter.init(
        OndatoServiceConfiguration(
          credentials: OndataCredencials(
              accessToken: YOUR_ACCESS_TOKEN,
              identificationId: YOUR_IDENTIFICATION_ID),
        ),
      );
      await OndatoFlutter.startIdentification();
    },
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
