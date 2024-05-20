import 'dart:io';
import 'dart:ui';

enum OndatoEnvironment { test, live }

enum OndatoLanguage { en, de, lt, lv, et, ru, sq, bg, es, fr, el, it, nl, ro }

extension OndatoEnvironmentExt on OndatoEnvironment {
  String? toMap() => this.toString().split('.').elementAt(1);
}

extension OndatoLanguageExt on OndatoLanguage {
  String? toMap() => this.toString().split('.').elementAt(1);
}

class OndatoServiceConfiguration {
  final String identificationId;
  final OndatoEnvironment mode;
  final OndatoLanguage language;
  final OndatoFlowConfiguration? flowConfiguration;
  final OndatoIosAppearance? appearance;

  OndatoServiceConfiguration({
    required this.identificationId,
    this.appearance,
    this.flowConfiguration,
    this.mode = OndatoEnvironment.test,
    this.language = OndatoLanguage.en,
  });

  Map<String, dynamic> toMap() {
    return {
      'appearance': appearance?.toMap(),
      'flowConfiguration': flowConfiguration?.toMap(),
      'mode': mode.toMap(),
      'language': language.toMap(),
      'identificationId': identificationId,
    };
  }
}

class OndatoFlowConfiguration {
  /// Should the start screen be shown
  bool showStartScreen;

  /// ANDROID ONLY Should the start screen be shown. Does not affect iOS
  bool showSplashScreen;

  // iOS ONLY Should the splash screen be shown. Does not affect Android
  bool showSuccessWindow;

  // iOS ONLY - Remove selfie frame. Does not affect Android
  bool removeSelfieFrame;

  // iOS ONLY Remove selfie frame. Does not affect Android
  bool skipRegistrationIfDriverLicense;

  OndatoFlowConfiguration({
    this.showSplashScreen = true,
    this.showStartScreen = true,
    this.showSuccessWindow = true,
    this.removeSelfieFrame = false,
    this.skipRegistrationIfDriverLicense = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'showSplashScreen': showSplashScreen,
      'showStartScreen': showStartScreen,
      'showSuccessWindow': showSuccessWindow,
      'removeSelfieFrame': removeSelfieFrame,
      'skipRegistrationIfDriverLicense': skipRegistrationIfDriverLicense,
    };
  }

  factory OndatoFlowConfiguration.fromMap(Map<String, dynamic> map) {
    return OndatoFlowConfiguration(
      showSplashScreen: map['showSplashScreen'],
      showStartScreen: map['showStartScreen'],
      showSuccessWindow: map['showSuccessWindow'],
      removeSelfieFrame: map['removeSelfieFrame'],
      skipRegistrationIfDriverLicense: map['skipRegistrationIfDriverLicense'],
    );
  }
}

class OndatoIosAppearance {
  /// Logo image that can be shown in the splash screen must be in base64 format
  String? logoImageBase64;

  /// background color of the `ProgressBarView` which guides the user through the flow
  Color? progressColor;

  /// background color of the primary action buttons
  Color? buttonColor;

  /// background color of the primary action buttons text
  Color? buttonTextColor;

  /// background color of the error message background
  Color? errorColor;

  /// background color of the error message text color
  Color? errorTextColor;

  Color? headerColor;

  Color? acceptButtonColor;

  Color? declineButtonColor;

  OndatoIosAppearance({
    this.progressColor,
    this.buttonColor,
    this.buttonTextColor,
    this.errorColor,
    this.errorTextColor,
    this.headerColor,
    this.acceptButtonColor,
    this.declineButtonColor,
  });

  Map<String, dynamic> toMap() {
    return {
      'progressColor': progressColor?.value,
      'buttonColor': buttonColor?.value,
      'buttonTextColor': buttonTextColor?.value,
      'errorColor': errorColor?.value,
      'errorTextColor': errorTextColor?.value,
      'headerColor': headerColor?.value,
      'acceptButtonColor': acceptButtonColor?.value,
      'declineButtonColor': declineButtonColor?.value,
    };
  }
}

class OndatoException implements Exception {
  OndatoError? error;
  String? identificationId;

  OndatoException(this.identificationId, error) {
    if (Platform.isAndroid) {
      print(error);
    } else {
      switch (error) {
        case 'cancelled':
          this.error = OndatoError.cancelled;
          break;
        case 'consentDenied':
          this.error = OndatoError.consentDenied;
          break;
        case 'invalidServerResponse':
          this.error = OndatoError.invalidServerResponse;
          break;
        case 'invalidCredentials':
          this.error = OndatoError.invalidCredentials;
          break;
        case 'recorderPermissions':
          this.error = OndatoError.recorderPermissions;
          break;
        case 'unexpectedInternalError':
          this.error = OndatoError.unexpectedInternalError;
          break;
        case 'verificationFailed':
          this.error = OndatoError.verificationFailed;
          break;
        case 'nfcNotSupported':
          this.error = OndatoError.nfcNotSupported;
          break;
        default:
          this.error = OndatoError.unexpectedInternalError;
      }
    }
  }
}

enum OndatoError {
  cancelled,
  consentDenied,
  invalidServerResponse,
  invalidCredentials,
  recorderPermissions,
  unexpectedInternalError,
  verificationFailed,
  nfcNotSupported,
}
