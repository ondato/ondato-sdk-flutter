import 'dart:io';
import 'dart:ui';

enum OndatoEnvironment { test, live }

enum OndatoLanguage { en, lt, sq, bg, ca, cs, nl, et, fi, fr, de, el, hu, it, lv, pl, pt, ro, ru, es, sv, uk, vi }

extension OndatoEnvironmentExt on OndatoEnvironment {
  String? toMap() => this.toString().split('.').elementAt(1);
}

extension OndatoLanguageExt on OndatoLanguage {
  String? toMap() => this.toString().split('.').elementAt(1);
}

class OndatoServiceConfiguration {
  final String identificationId;
  final String? jsonConfiguration;
  final OndatoEnvironment mode;
  final OndatoLanguage language;
  final OndatoFlowConfiguration? flowConfiguration;
  final OndatoIosAppearance? appearance;

  OndatoServiceConfiguration({
    required this.identificationId,
    this.jsonConfiguration,
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
      'jsonConfiguration': jsonConfiguration
    };
  }
}

class OndatoFlowConfiguration {
  // Should the global success screen be shown.
  bool showSuccessWindow;

  // Remove selfie frame. Does not affect Android
  bool removeSelfieFrame;

  // Skip registration step for driver's license
  bool skipRegistrationIfDriverLicense;

  OndatoFlowConfiguration({
    this.showSuccessWindow = true,
    this.removeSelfieFrame = false,
    this.skipRegistrationIfDriverLicense = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'showSuccessWindow': showSuccessWindow,
      'removeSelfieFrame': removeSelfieFrame,
      'skipRegistrationIfDriverLicense': skipRegistrationIfDriverLicense,
    };
  }

  factory OndatoFlowConfiguration.fromMap(Map<String, dynamic> map) {
    return OndatoFlowConfiguration(
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
      switch (error) {
        case 'canceled by user':
          this.error = OndatoError.cancelled;
          break;
        case 'bad response from server':
          this.error = OndatoError.invalidServerResponse;
          break;
        case 'nfc is not supported in nfc mandatory or optional mode':
          this.error = OndatoError.nfcNotSupported;
          break;
        case 'number of max attempts reached when trying to authenticate face':
          this.error = OndatoError.maxAttemptsReached;
          break;
        case 'no available document types':
          this.error = OndatoError.noAvailableDocumentTypes;
          break;
      }
    } else {
      switch (error) {
        case 'cancelled':
          this.error = OndatoError.cancelled;
          break;
        case 'consentDenied':
          this.error = OndatoError.consentDenied;
          break;
        case 'faceDataNotPresent':
          this.error = OndatoError.faceDataNotPresent;
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
        case 'recorderStartError':
          this.error = OndatoError.recorderStartError;
          break;
        case 'recorderEndError':
          this.error = OndatoError.recorderEndError;
          break;
        case 'verificationFailed':
          this.error = OndatoError.verificationFailed;
          break;
        case 'nfcNotSupported':
          this.error = OndatoError.nfcNotSupported;
          break;
        case 'accessToken':
          this.error = OndatoError.accessToken;
          break;
        case 'idvConfig':
          this.error = OndatoError.idvConfig;
          break;
        case 'idvSetup':
          this.error = OndatoError.idvSetup;
          break;
        case 'facetecSdk':
          this.error = OndatoError.facetecSdk;
          break;
        case 'faceSetup':
          this.error = OndatoError.faceSetup;
          break;
        case 'facetecLicense':
          this.error = OndatoError.facetecLicense;
          break;
        case 'kycCompleted':
          this.error = OndatoError.kycCompleted;
          break;
        case 'kycConfig':
          this.error = OndatoError.kycConfig;
          break;
        case 'kycId':
          this.error = OndatoError.kycId;
          break;
        case 'kycSetup':
          this.error = OndatoError.kycSetup;
          break;
        case 'mrzScanner':
          this.error = OndatoError.mrzScanner;
          break;
        case 'personalCodeUpload':
          this.error = OndatoError.personalCodeUpload;
          break;
        case 'recordingUpload':
          this.error = OndatoError.recordingUpload;
          break;
        case 'restartFailed':
          this.error = OndatoError.restartFailed;
          break;
        case 'verificationFailedNoStatus':
          this.error = OndatoError.verificationFailedNoStatus;
          break;
        case 'verificationStatusFailed':
          this.error = OndatoError.verificationStatusFailed;
          break;
        default:
          this.error = OndatoError.unexpectedInternalError;
      }
    }
  }
}

enum OndatoError {
  /// General errors
  cancelled,
  invalidServerResponse,
  nfcNotSupported,
  unexpectedInternalError,

  /// iOS only
  consentDenied,
  faceDataNotPresent,
  invalidCredentials,
  recorderPermissions,
  recorderStartError,
  recorderEndError,
  verificationFailed,
  accessToken,
  idvConfig,
  idvSetup,
  facetecSdk,
  faceSetup,
  facetecLicense,
  kycCompleted,
  kycConfig,
  kycId,
  kycSetup,
  mrzScanner,
  personalCodeUpload,
  recordingUpload,
  restartFailed,
  verificationFailedNoStatus,
  verificationStatusFailed,

  /// Android only
  maxAttemptsReached,
  noAvailableDocumentTypes,
}
