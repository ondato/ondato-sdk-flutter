import 'dart:io';
import 'dart:ui';

enum OndatoEnvironment { test, live }

enum OndatoLanguage { en, lt, sq, bg, ca, zh, hr, cs, nl, da, et, fi, fr, de, el, hu, it, ko, lv, pl, ptPT, ptBR, ro, ru, es, sk, sl, sv, th, uk, vi }

enum OndatoLoggingLevel { error, info, debug, verbose }

extension OndatoEnvironmentExt on OndatoEnvironment {
  String? toMap() => this.toString().split('.').elementAt(1);
}

extension OndatoLanguageExt on OndatoLanguage {
  String? toMap() => this.toString().split('.').elementAt(1);
}

extension OndatoLoggingLevelExt on OndatoLoggingLevel {
  String? toMap() => this.toString().split('.').elementAt(1);
}

class OndatoServiceConfiguration {
  final String identificationId;
  final String? jsonConfiguration;
  final OndatoEnvironment mode;
  final OndatoLanguage language;
  final OndatoFlowConfiguration? flowConfiguration;
  final OndatoIosAppearance? appearance;
  final OndatoLoggingLevel loggingLevel;
  final String? consentTimeout;

  OndatoServiceConfiguration({
    required this.identificationId,
    this.jsonConfiguration,
    this.appearance,
    this.flowConfiguration,
    this.mode = OndatoEnvironment.test,
    this.language = OndatoLanguage.en,
    this.loggingLevel = OndatoLoggingLevel.error,
    this.consentTimeout,
  });

  Map<String, dynamic> toMap() {
    return {
      'appearance': appearance?.toMap(),
      'flowConfiguration': flowConfiguration?.toMap(),
      'mode': mode.toMap(),
      'language': language.toMap(),
      'identificationId': identificationId,
      'loggingLevel': loggingLevel.toMap(),
      'jsonConfiguration': jsonConfiguration,
      'consentTimeout': consentTimeout
    };
  }
}

class OndatoFlowConfiguration {
  // Skip registration step for driver's license
  bool skipRegistrationIfDriverLicense;

  // Show no network screen when there are Internet issues
  bool showNoNetworkScreen;

  // Should disable PDF file type upload for proof-of-address step
  bool disablePdfFileUpload;

  // Should switch primary and secondary buttons places
  bool switchPrimaryButtonsDisplay;

  // Disable the consent validation rule where the user needs to scroll to the bottom of the text in order to enable "I agree" button
  bool disableScrollToBottomConsentRule; 

  OndatoFlowConfiguration({
    this.skipRegistrationIfDriverLicense = false,
    this.showNoNetworkScreen = true,
    this.disablePdfFileUpload = false,
    this.switchPrimaryButtonsDisplay = false,

    this.disableScrollToBottomConsentRule = false
  });

  Map<String, dynamic> toMap() {
    return {
      'skipRegistrationIfDriverLicense': skipRegistrationIfDriverLicense,
      'showNoNetworkScreen': showNoNetworkScreen,
      'disablePdfFileUpload': disablePdfFileUpload,
      'switchPrimaryButtonsDisplay': switchPrimaryButtonsDisplay,
      'disableScrollToBottomConsentRule': disableScrollToBottomConsentRule
    };
  }

  factory OndatoFlowConfiguration.fromMap(Map<String, dynamic> map) {
    return OndatoFlowConfiguration(
      skipRegistrationIfDriverLicense: map['skipRegistrationIfDriverLicense'],
      showNoNetworkScreen: map['showNoNetworkScreen'],
      disablePdfFileUpload: map['disablePdfFileUpload'],
      switchPrimaryButtonsDisplay: map['switchPrimaryButtonsDisplay'],
      disableScrollToBottomConsentRule: map['disableScrollToBottomConsentRule']
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
      'progressColor': progressColor?.toARGB32(),
      'buttonColor': buttonColor?.toARGB32(),
      'buttonTextColor': buttonTextColor?.toARGB32(),
      'errorColor': errorColor?.toARGB32(),
      'errorTextColor': errorTextColor?.toARGB32(),
      'headerColor': headerColor?.toARGB32(),
      'acceptButtonColor': acceptButtonColor?.toARGB32(),
      'declineButtonColor': declineButtonColor?.toARGB32(),
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
