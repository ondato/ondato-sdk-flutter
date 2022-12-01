import 'dart:ui';

enum OndatoEnvironment { test, live }

enum OndatoLanguage { en, de, lt, lv, et, ru }

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
  // OndatoCredentials credentials;

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

// class OndatoCredentials {
//   OndatoCredentials({
//     required this.accessToken,
//     required this.identificationId,
//   });
//   final String accessToken;
//   final String identificationId;

//   Map<String, String> toMap() {
//     return {'identificationId': identificationId};
//   }
// }

class OndatoFlowConfiguration {
  /// Should the splash screen be shown
  bool? showSplashScreen;

  /// Should the start screen be shown
  bool? showStartScreen;

  OndatoFlowConfiguration({
    this.showStartScreen = true,
    this.showSplashScreen = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'showSplashScreen': showSplashScreen,
      'showStartScreen': showStartScreen,
    };
  }

  factory OndatoFlowConfiguration.fromMap(Map<String, dynamic> map) {
    return OndatoFlowConfiguration(
      showSplashScreen: map['showSplashScreen'],
      showStartScreen: map['showStartScreen'],
    );
  }
}

class OndatoIosAppearance {
  /// Logo image that can be shown in the splash screen
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

  /// regular text font
  String? regularFontName;

  /// medium text font
  String? mediumFontName;

  Color? headerColor;

  Color? acceptButtonColor;

  Color? declineButtonColor;

  OndatoIosAppearance({
    this.logoImageBase64,
    this.progressColor,
    this.buttonColor,
    this.buttonTextColor,
    this.errorColor,
    this.errorTextColor,
    this.regularFontName,
    this.mediumFontName,
    this.headerColor,
    this.acceptButtonColor,
    this.declineButtonColor,
  });

  Map<String, dynamic> toMap() {
    return {
      'logoImageBase64': logoImageBase64,
      'progressColor': progressColor?.value,
      'buttonColor': buttonColor?.value,
      'buttonTextColor': buttonTextColor?.value,
      'errorColor': errorColor?.value,
      'errorTextColor': errorTextColor?.value,
      'regularFontName': regularFontName,
      'mediumFontName': mediumFontName,
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
    switch (error) {
      case 'cancelled':
        this.error = OndatoError.cancelled;
        break;
      case 'invalidServerResponse':
        this.error = OndatoError.invalidServerResponse;
        break;
      case 'invalidCredentials':
        this.error = OndatoError.invalidCredentials;
        break;
      default:
        this.error = OndatoError.unexpectedInternalError;
    }
  }
}

enum OndatoError { cancelled, invalidServerResponse, invalidCredentials, unexpectedInternalError }
