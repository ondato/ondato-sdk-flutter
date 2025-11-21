import Flutter
import UIKit
import OndatoSDK

public class SwiftOndatoFlutterPlugin: NSObject, FlutterPlugin {

     init(uiViewController:  UIKit.UIViewController) {
        self.uiViewController = uiViewController
    }

    var uiViewController :  UIKit.UIViewController

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ondato_flutter", binaryMessenger: registrar.messenger())

        let viewController:  UIKit.UIViewController =
                    (UIApplication.shared.delegate?.window??.rootViewController)!;

        let instance = SwiftOndatoFlutterPlugin(uiViewController: viewController)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

      public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "initialSetup":
            create(call: call, flutterResult: result)
        case "startIdentification":
            startIdentification(flutterResult: result)
        default:
            result(FlutterMethodNotImplemented)
        }

    }

    func create(call:
                FlutterMethodCall, flutterResult: FlutterResult) -> Void {
        guard let args = call.arguments as? [String: Any] else {
            return}
        guard let identificationId : String = args["identificationId"] as? String else {
            flutterResult(false)
            return
        }
        
        Ondato.sdk.setIdentityVerificationId(identificationId)
        
        let configuration: OndatoServiceConfiguration = Ondato.sdk.configuration
        
        if let flowConfiguration : [String: Any] = args["flowConfiguration"] as? [String:Any] {
            let ondatoFlowConfiguration = configuration.flowConfiguration
            ondatoFlowConfiguration.skipRegistrationIfDriverLicense = (flowConfiguration["skipRegistrationIfDriverLicense"] as? Bool) ?? false
            ondatoFlowConfiguration.showTranslationKeys = (flowConfiguration["showTranslationKeys"] as? Bool) ?? false
            ondatoFlowConfiguration.showNoInternetConnectionView = (flowConfiguration["showNoInternetConnectionView"] as? Bool) ?? true
            ondatoFlowConfiguration.disablePdfFileUpload = (flowConfiguration["disablePdfFileUpload"] as? Bool) ?? false
            ondatoFlowConfiguration.switchPrimaryButtons = (flowConfiguration["switchPrimaryButtons"] as? Bool) ?? false
            
            configuration.flowConfiguration = ondatoFlowConfiguration;
        }
        
        if let jsonConfiguration: String = args["jsonConfiguration"] as? String {
            try? Ondato.sdk.setWhitelabel(Data(jsonConfiguration.utf8))
        }
        
        
        if let mode : String = args["mode"] as? String {
            configuration.mode = mode == "live" ? OndatoEnvironment.live : OndatoEnvironment.test
        }
        
        
        if let language: String = args["language"] as? String,
           let ondatoLanguage = OndatoSupportedLanguage(rawValue: language) {
            OndatoLocalizeHelper.shared.setLangauge(ondatoLanguage)
        }
        
        print("ONDATO PLUGIN: Initialize successful.");
        flutterResult(true)
    }

    var delegate: OndatoFlowDelegate?;

    func startIdentification(flutterResult: @escaping  FlutterResult) {
        delegate =  {() -> OndatoFlowDelegate in
            class FlowDelegate : OndatoFlowDelegate {
                private let result : FlutterResult
                init(r: @escaping FlutterResult) {
                    self.result = r
                }
                func flowDidSucceed(identificationId: String?) {
                    print("ONDATO PLUGIN: Identification Success!");
                    result(["identificationId": identificationId])
                }

                func flowDidFail(identificationId: String?, error: OndatoServiceError) {
                    print("ONDATO PLUGIN: Identification Failed!");
                    /// Check type of OndatoServiceError and return error message
                    var errorString = "unexpectedInternalError"
                    /// If error is not nil, return error type.rawValue
                        /// Switch rawValue to return error message
                    print(error.type.rawValue);
                    switch error.type.rawValue {
                        case 0:
                            errorString = "cancelled"
                        case 1:
                            errorString = "consentDenied"
                        case 2:
                            errorString = "invalidServerResponse"
                        case 3:
                            errorString = "invalidCredentials"
                        case 4:
                            errorString = "recorderPermissions"
                        case 5:
                            errorString = "unexpectedInternalError"
                        case 6:
                            errorString = "verificationFailed"
                        case 7:
                            errorString = "nfcNotSupported"
                        case 8:
                            errorString = "missingModule"
                        case 9:
                            errorString = "hostCanceled"
                        default:
                            errorString = "unexpectedInternalError"
                    }
                    print(errorString);
                    result(["identificationId": identificationId, "error": String(errorString)])
                }
            }
            let flowDelegate = FlowDelegate(r: flutterResult)
            return flowDelegate
        }()

        Ondato.sdk.delegate = delegate

        print("ONDATO PLUGIN: Delegate registered successfully.");

        DispatchQueue.main.async {
            let sdk = Ondato.sdk.instantiateOndatoViewController()
            sdk.modalPresentationStyle = .fullScreen
            self.uiViewController.present(sdk, animated: true, completion: nil)
        }
    }
}

extension Int {
    func toUIColor() -> UIColor {
        let uInt32Color = UInt32(self)
        let mask : UInt32 = 0x000000FF
        let alpha = (uInt32Color >> 24).toFloatColor()
        let red = ((uInt32Color >> 16) & mask).toFloatColor()
        let green = ((uInt32Color >> 8) & mask).toFloatColor()
        let blue = (uInt32Color & mask).toFloatColor()
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UInt32 {
    func toFloatColor() -> CGFloat {
        return CGFloat(self)/255
    }
}
