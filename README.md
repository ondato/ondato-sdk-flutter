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
ondato_flutter_sdk:
    git:
      url: git@github.com:ondato/ondato-sdk-flutter.git
      ref: main
      path: ondato_flutter_sdk
```

### Android

1. Go to `android/app/build.gradle` and change minSdkVersion to `minSdkVersion 26`

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
    mode: OndatoEnvironment.test, // Can be "test" or "live" environments on which the SDK will work on
    jsonConfiguration: jsonConfiguration, // Any UI customisation options (Whitelabel JSON file passed as string)
    flowConfiguration: OndatoFlowConfiguration( // customisation of identification flow
      showSuccessWindow: true,
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

In order to enhance the user experience on the transition between your application and the SDK, you can provide some customisation by parsing your provided JSON file to the `jsonConfiguration` parameter. The JSON file structure looks as follows:

```json
{
  // CORE STYLING
  "brand": {
    "colors": {
      "primaryColor": "#64749c", // Primary brand color - used in illustration and primary button

      "textColor": "#000000", // Text color for content
      "backgroundColor": "#FFFFFF", // Base background color for screens

      "danger": "#D04555", // Color for error states and messages
      "warning": "#F9BB42", // Color for warning elements
      "success": "#28865A", // Color for success elements

      "grey100": "", // Currently not used
      "grey200": "#F2F5F8", // Button Disabled state background, Text input readonly background
      "grey300": "", // Currently not used
      "grey400": "#BEC6D0", // Color for input element border color, also used in Text input
      "grey500": "#96A0AE", // Color for "Select card" icon, Proof of Address upload element border, Text input disabled state text color
      "grey600": "#6D7580", // Color for Proof of Address icon color, Text input Active state border
      "grey700": "#282B2F", // Color for feedback bar background color
      
      "statusBarColor": "#64749c" // Default: brand.colors.primaryColor
    },

    "baseComponentStyling": {
      "cornerRadius": 6, // Used for all input components (Buttons, Text inputs and other elements)
      "buttonPadding": { "top": 14, "bottom": 14, "left": 24, "right": 24 }, // Used for Primary and Secondary button paddings
      "borderWidth": 1.0 // Used for Secondary button, Text input, Selection button border
    },
    
    // IMPORTANT! For iOS the font size, weight is taken from Font file.
    "typography": {
      "heading1": { 
        "fontSize": 24, 
        "fontWeight": 500, 
        "lineHeight": 32, 
        "alignment": "center", 
        "color": "#000000" // Type: String  |  Default: brand.colors.textColor
      },
      "heading2": { 
        "fontSize": 16, 
        "fontWeight": 500, 
        "lineHeight": 18, 
        "alignment": "center",
        "color": "#000000" // Type: String  |  Default: brand.colors.textColor
      },
      "body": { 
        "fontSize": 16, 
        "fontWeight": 400, 
        "lineHeight": 18, 
        "alignment": "center",
        "color": "#000000" // Type: String  |  Default: brand.colors.textColor
      },
      "list": { 
        "fontSize": 16, 
        "fontWeight": 400, 
        "lineHeight": 18,
        "color": "#000000" // Type: String  |  Default: brand.colors.textColor
      },
      "inputLabel": { 
        "fontSize": 16, 
        "fontWeight": 400, 
        "lineHeight": 18,
        "color": "#000000" // Type: String  |  Default: brand.colors.textColor
      },
      "button": { 
        "fontSize": 16, 
        "fontWeight": 500, 
        "lineHeight": 18,
        "color": "#000000" // Type: String  |  Default: brand.colors.textColor
      }
    }
  },

  // Primary and secondary button options
  "buttons": {
    "primary": {
      "base": {
        "cornerRadius": 6, // Default: brand.baseComponentStyling.cornerRadius
        "padding": { "top": 14, "bottom": 14, "left": 24, "right": 24 }, // Default: brand.baseComponentStyling.buttonPadding

        "fontSize": 16, // Type: Int  |   Default: typography.button.fontSize
        "fontWeight": 500, // Type: Int  |   Default: typography.button.fontWeight
        "lineHeight": 18, // Type: Int  |   Default: typography.button.lineHeight
        "showIcon": false // Type: Boolean
      },
      "normal": {
        "textColor": "#000000", // Type: String  |  Default: brand.colors.textColor
        "backgroundColor": "#64749c", // Type: String  |  Default: brand.colors.primaryColor
        "borderWidth": 1.0, // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
        "borderColor": "#64749c", // Type: String  |  Default: colors.primaryColor
        "iconColor": "#000000", // Type: String  |  Default: colors.textColor
        "opacity": 1.0 // Type: Float
      },
      "pressed": {
        "textColor": "#000000", // Type: String  |  Default: brand.colors.textColor
        "backgroundColor": "#64749c", // Type: String  |  Default: brand.colors.primaryColor
        "borderWidth": 1.0, // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
        "borderColor": "#64749c", // Type: String  |  Default: colors.primaryColor
        "iconColor": "#000000", // Type: String  |  Default: colors.textColor
        "opacity": 0.8 // Type: Float
      },
      "disabled": {
        "textColor": "#96A0AE", // Type: String  |  Default: brand.colors.grey500
        "backgroundColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
        "borderWidth": 1, // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
        "borderColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
        "iconColor": "#96A0AE", // Type: String  |  Default: brand.colors.grey500
        "opacity": 1.0 // Type: Float
      }
    },

    "secondary": {
      "base": {
        "cornerRadius": 6, // Default: brand.baseComponentStyling.cornerRadius
        "padding": { "top": 14, "bottom": 14, "left": 24, "right": 24 }, // Default: brand.baseComponentStyling.buttonPadding

        "fontSize": 16, // Type: Int  |   Default: typography.button.fontSize
        "fontWeight": 500, // Type: Int  |   Default: typography.button.fontWeight
        "lineHeight": 18, // Type: Int  |   Default: typography.button.lineHeight
        "showIcon": false // Type: Boolean
      },
      "normal": {
        "textColor": "#000000", // Type: String  |  Default: brand.colors.textColor
        "backgroundColor": "#FFFFFF", // Default -  colors.backgroundColor
        "borderWidth": 1.0, // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
        "borderColor": "#BEC6D0", // Type: String  |  Default: brand.colors.grey400
        "iconColor": "#000000", // Type: String  |  Default: brand.colors.textColor
        "opacity": 1.0 // Type: Float
      },
      "pressed": {
        "textColor": "#000000", // Type: String  |  Default: brand.colors.textColor
        "backgroundColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
        "borderWidth": 1.0, // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
        "borderColor": "#6D7580", // Type: String  |  Default: brand.colors.grey600
        "iconColor": "#000000", // Type: String  |  Default: brand.colors.textColor
        "opacity": 1.0 // Type: Float
      },
      "disabled": {
        "textColor": "#96A0AE", // Type: String  |  Default: brand.colors.grey500
        "backgroundColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
        "borderWidth": 1.0, // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
        "borderColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
        "iconColor": "#96A0AE", // Type: String  |  Default: brand.colors.grey500
        "opacity": 1.0 // Type: Float
      }
    },

    // Icon buttons (e.g. in proof-of-address upload screen) customisation
    "iconButton": {
      "base": {
        "cornerRadius": 6, // Default: brand.baseComponentStyling.cornerRadius
      },
      "normal": {
        "iconColor": "#000000", // Type: String  |  Default: brand.colors.textColor
        "backgroundColor": "#FFFFFF", // Type: String  |  Default: brand.colors.backgroundColor
        "borderColor": "#FFFFFF", // Type: String  |  Default: brand.colors.backgroundColor
        "borderWidth": 0, // Type: Float  |  Default: brand.baseComponentStyling.borderWidth
      },
      "pressed": {
        "iconColor": "#000000", // Type: String  |  Default: brand.colors.textColor
        "backgroundColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
        "borderColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
        "borderWidth": 0, // Type: Float  |  Default: brand.baseComponentStyling.borderWidth
      },
      "disabled": {
        "iconColor": "#96A0AE", // Type: String  |  Default: brand.colors.grey500
        "backgroundColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
        "borderColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
        "borderWidth": 0, // Type: Float  |  Default: brand.baseComponentStyling.borderWidth
      }
    },

    // Back and close navigation buttons customisation
    "navigationButton": {
      "base": {
        "cornerRadius": 6, // Default: brand.baseComponentStyling.cornerRadius
      },
      "normal": {
        "iconColor": "#000000", // Type: String  |  Default: brand.colors.textColor
        "backgroundColor": "#FFFFFF", // Type: String  |  Default: brand.colors.backgroundColor
        "borderColor": "#FFFFFF", // Type: String  |  Default: brand.colors.backgroundColor
        "borderWidth": 0, // Type: Float  |  Default: brand.baseComponentStyling.borderWidth
      },
      "pressed": {
        "iconColor": "#000000", // Type: String  |  Default: brand.colors.textColor
        "backgroundColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
        "borderColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
        "borderWidth": 0, // Type: Float  |  Default: brand.baseComponentStyling.borderWidth
      },
      "disabled": {
        "iconColor": "#96A0AE", // Type: String  |  Default: brand.colors.grey500
        "backgroundColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
        "borderColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
        "borderWidth": 0, // Type: Float  |  Default: bbrand.baseComponentStyling.borderWidth
      }
    }
  },

  // Customisation options for all text types in the SDK
  "textInput": {
    "base": {
      "cornerRadius": 6, // Type: Float  |   Default: brand.baseComponentStyling.cornerRadius
      "padding": { "top": 14, "bottom": 14, "left": 24, "right": 24 }, // Default: brand.baseComponentStyling.buttonPadding

      "fontSize": 16, // Type: Int  |   Default: typography.body.fontSize
      "fontWeight": 500, // Type: Int  |   Default: typography.body.fontWeight
      "lineHeight": 22, // Type: Int  |   Default: typography.body.lineHeight

      "placeholderTextColor": "#BEC6D0" //Type: String  |  Default: brand.colors.grey400
    },

    "normal": {
      "textColor": "#000000", // Type: String  |  Default: brand.colors.textColor
      "backgroundColor": "#FFFFFF", // Type: String  |   Default: brand.colors.backgroundColor
      "borderColor": "#96A0AE", // Type: String  |  Default: brand.colors.grey500
      "borderWidth": 1.0 // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
    },
    "selected": {
      "textColor": "#000000", // Type: String  |  Default: brand.colors.textColor
      "backgroundColor": "#FFFFFF", // Type: String  |   Default: brand.colors.backgroundColor
      "borderColor": "#6D7580", // Type: String  |  Default: brand.colors.grey600
      "borderWidth": 1.0 // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
    },
    "disabled": {
      "textColor": "#BEC6D0", // Type: String  |  Default: brand.colors.grey400
      "backgroundColor": "#FFFFFF", // Type: String  |  Default: brand.colors.backgroundColor
      "borderColor": "#BEC6D0", // Type: String  |  Default: brand.colors.grey400
      "borderWidth": 1.0 // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
    },
    "readOnly": {
      "textColor": "#6D7580", // Type: String  |  Default: brand.colors.grey600
      "backgroundColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
      "borderColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
      "borderWidth": 1.0 // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
    },
    "error": {
      "textColor": "#D04555", // Type: String  |  Default: brand.colors.danger
      "borderColor": "#D04555", // Type: String  |  Default: brand.colors.danger
      "borderWidth": 1.0, // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
      "backgroundColor": "#FFFFFF" // Type: String  |   Default: brand.colors.backgroundColor
    }
  },

  // Used for tinkering the document selection card UI
  "selectionCard": {
    "base": {
      "cornerRadius": 6, // Type: Float  |   Default: brand.baseComponentStyling.cornerRadius

      "fontSize": 16, // Type: Int  |   Default: typography.body.fontSize
      "fontWeight": 500, // Type: Int  |   Default: typography.body.fontWeight
      "lineHeight": 22 // Type: Int  |   Default: typography.body.lineHeight
    },
    "normal": {
      "textColor": "#000000", // Type: String  |  Default: brand.colors.textColor
      "backgroundColor": "#FFFFFF", // Type: String  |  Default: brand.colors.backgroundColor
      "borderWidth": 1.0, // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
      "borderColor": "#BEC6D0", // Type: String  |  Default: brand.colors.grey400
      "leftIconColor": "#96A0AE", // Type: String  |  Default: brand.colors.grey500
      "rightIconColor": "#000000" // Type: String  |  Default: brand.colors.textColor
    },
    "pressed": {
      "textColor": "#000000", // Type: String  |  Default: brand.colors.textColor
      "backgroundColor": "#F2F5F8", // Type: String  |   Default: brand.colors.grey200
      "borderWidth": 1.0, // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
      "borderColor": "#BEC6D0", // Type: String  |  Default: brand.colors.grey400
      "leftIconColor": "#96A0AE", // Type: String  |  Default: brand.colors.grey500
      "rightIconColor": "#000000" // Type: String  |  Default: brand.colors.textColor
    },
    "disabled": {
      "textColor": "#BEC6D0", // Type: String  |  Default: brand.colors.grey400
      "backgroundColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
      "borderWidth": 1.0, // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
      "borderColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
      "leftIconColor": "#BEC6D0", // Type: String  |  Default: brand.colors.grey400
      "rightIconColor": "#BEC6D0" // Type: String  |  Default: brand.colors.grey400
    }
  },

  // Used for changing the colour of the loading indicator
  "activityIndicator": {
    "color": "#64749c" // Type: String  |  Default: brand.colors.primaryColor
  },

  // Used for customising the face authorisation screen frame and feedback bar
  "faceScanUI": {
    "frame": {
      "borderColor": "#282B2F", // Type: String  |  Default: brand.colors.grey700
      "borderWidth": 1.0, // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
      "progressColor": "#64749c" // Type: String  |  Default: brand.colors.primaryColor
    },
    "feedbackBar": {
      "backgroundColor": "#282B2F", // Type: String  |  Default: brand.colors.grey700
      "textColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
      "cornerRadius": 6 // Type: Float  |   Default: brand.baseComponentStyling.cornerRadius
    }
  },

  // Used for customising the proof-of-address document upload screen
  "documentUploadConfiguration": {
    "borderColor": "#96A0AE", // Type: String  |  Default: brand.colors.grey500
    "borderWidth": 1.0, // Type: Float   |  Default: brand.baseComponentStyling.borderWidth
    "cornerRadius": 6.0, // Type: Float  |   Default: brand.baseComponentStyling.cornerRadius

    "fileDescriptionTextColor": "#96A0AE", // Type: String  |  Default: brand.colors.grey500
    "fileIconColor": "#6D7580", // Type: String  |  Default: brand.colors.grey600

    "uploadAreaBackgroundOpacity": 0,
    "uploadAreaBackgroundColor": "#FFFFFF" // Type: String  |  Default: brand.colors.backgroundColor
  },

  // Used for customising the camera overlay
  "cameraScreenConfiguration": {
    "backgroundColor": "#282B2F", // Type: String  |  Default: brand.colors.grey700
    "opacity": 0.5, //  Type: Float
    "cornerRadius": 6.0 // Type: Float  |   Default: brand.baseComponentStyling.cornerRadius
  },

  // Used for elements providing in-context information
  "tooltip": {
    "backgroundColor": "#282B2F", // Type: String  |  Default: brand.colors.grey700
    "textColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
    "cornerRadius": 6, // Type: Int  |   Default: brand.baseComponentStyling.cornerRadius
    "fontSize": 16, // Type: Int  |   Default: typography.body.fontSize
    "fontWeight": 500, // Type: Int  |   Default: typography.body.fontWeight
    "lineHeight": 22 // Type: Int  |   Default: typography.body.lineHeight 
  },

  // Used for the document auto-capture and face scanning
  "feedbackBar": {
    "backgroundColor": "#282B2F", // Type: String  |  Default: brand.colors.grey700
    "textColor": "#F2F5F8", // Type: String  |  Default: brand.colors.grey200
    "cornerRadius": 6 // Type: Int  |   Default: brand.baseComponentStyling.cornerRadius
    "fontSize": 16, // Type: Int  |   Default: typography.body.fontSize
    "fontWeight": 500, // Type: Int  |   Default: typography.body.fontWeight
    "lineHeight": 22 // Type: Int  |   Default: typography.body.lineHeight 
  }
}

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
