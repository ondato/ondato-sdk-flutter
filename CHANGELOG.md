##
- feat: Update Android to 2.5.13

## 2.5.2
- feat: Update iOS to 2.5.11

## 2.5.1
- feat: Enable NFC support for Android

## 2.5.0
- fix: Fix Android build error

## 0.7.0
- feat: Ondato iOS SDK updated to 2.5.10
- feat: Ondato Android SDK updated to 2.5.11

## 0.6.0
- feat: Ondato iOS SDK updated to 2.5.7
- feat: Handle a broader range of iOS exceptions

## 0.5.0
- feat: Ondato Android SDK updated to 2.5.4 and iOS SDKs updated to 2.5.2 version;
- fix: `OndatoException` now has additional fields which are corresponding to the error fields in the native Ondato SDK;

## 0.3.0

- **BREAKING**: refactor: removed deprecated `AccessToken` from `OndataCredentials`;
- **BREAKING**: refactor: removed deprecated `OndataCredentials`;
- **BREAKING**: refactor: `identificationId` was added directly into `OndatoServiceConfiguration`;
- **BREAKING**: refactor: removed deprecated `showConsentScreen` from `OndatoFlowConfiguration`;
- **BREAKING**: refactor: removed deprecated `showSelfieAndDocumentScreen` from `OndatoFlowConfiguration`;
- **BREAKING**: refactor: removed deprecated `showSuccessWindow` from `OndatoFlowConfiguration`;
- **BREAKING**: refactor: removed deprecated `ignoreLivenessErrors` from `OndatoFlowConfiguration`;
- **BREAKING**: refactor: removed deprecated `ignoreVerificationErrors` from `OndatoFlowConfiguration`;
- **BREAKING**: refactor: removed deprecated `recordProcess` from `OndatoFlowConfiguration`;
- **BREAKING**: refactor: removed deprecated `regularFontName` from `OndatoIosAppearance`;
- **BREAKING**: refactor: removed deprecated `mediumFontName` from `OndatoIosAppearance`;
- **BREAKING**: refactor: removed deprecated `logoImageBase64` from `OndatoIosAppearance`;
- fix: `OndatoFlowDelegate` made as strong referance in plugin for a fix on unresponding callbacks in iOS Plugin;
- feat: Ondato Android SDK updated to 2.1.3 and iOS SDKs updated to 2.1.5 version;
- **BREAKING**: Plugin now supports iOS 13 and up, due to iOS Ondato SDK increasing the deployment target;

## 0.1.0-nullsafety-1

Migrated to sound null safety;
Updated README.md file;

## 0.0.2

Updated for 1.6.9 Android and iOS SDK handling.

## 0.0.1

Initial release
