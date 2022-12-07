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
- feat: Ondato Android SDK updated to 2.1.6 and iOS SDKs updated to 2.1.5 version;
- **BREAKING**: Plugin now supports iOS 13 and up, due to iOS Ondato SDK increasing the deployment target;

## 0.1.0-nullsafety-1

Migrated to sound null safety;
Updated README.md file;

## 0.0.2

Updated for 1.6.9 Android and iOS SDK handling.

## 0.0.1

Initial release
