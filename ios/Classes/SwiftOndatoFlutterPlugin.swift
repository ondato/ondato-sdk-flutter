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
        guard let credentials : Dictionary<String, Any> = args["credentials"] as? [String: Any] else {
            flutterResult(false)
            return
        }

        if let accessToken: String = credentials["accessToken"] as? String {
            OndatoService.shared.initialize(accessToken: accessToken)
        }

        let configuration: OndatoServiceConfiguration = OndatoService.shared.configuration
        if let appearance : [String: Any] = args["appearance"] as? [String:Any]{
            let ondatoAppearance =  OndatoAppearance()

            if let buttonColor : Int = appearance["buttonColor"] as? Int {
                print("Button color \(buttonColor)")
                ondatoAppearance.buttonColor = buttonColor.toUIColor()
            }

            if let buttonTextColor : Int = appearance["buttonTextColor"] as? Int {
                ondatoAppearance.buttonTextColor = buttonTextColor.toUIColor()
            }

            if let errorColor : Int = appearance["errorColor"] as? Int {
                ondatoAppearance.errorColor = errorColor.toUIColor()
            }

            if let errorTextColor : Int = appearance["errorTextColor"] as? Int {
                ondatoAppearance.errorTextColor = errorTextColor.toUIColor()
            }


            if let errorTextColor : Int = appearance["errorTextColor"] as? Int {
                ondatoAppearance.errorTextColor = errorTextColor.toUIColor()
            }

            if let regularFontName : String = appearance["regularFontName"] as? String {
                ondatoAppearance.regularFontName = regularFontName
            }

            if let mediumFontName : String = appearance["mediumFontName"] as? String {
                ondatoAppearance.mediumFontName = mediumFontName
            }

            if let headerColor : Int = appearance["headerColor"] as? Int {
                ondatoAppearance.consentWindow.header.color = headerColor.toUIColor()
            }

            if let acceptButtonColor : Int = appearance["acceptButtonColor"] as? Int {
                ondatoAppearance.consentWindow.acceptButton.backgroundColor = acceptButtonColor.toUIColor()
            }

            if let declineButtonColor : Int = appearance["declineButtonColor"] as? Int {
                ondatoAppearance.consentWindow.declineButton.backgroundColor = declineButtonColor.toUIColor()
            }
            if let logoImageBase64 : String = appearance["logoImageBase64"] as? String {
                let data : Data = Data(base64Encoded: logoImageBase64, options: .ignoreUnknownCharacters)!
                ondatoAppearance.logoImage = UIImage(data: data)
            }

            configuration.appearance = ondatoAppearance

        }

        if let flowConfiguration : [String: Any] = args["flowConfiguration"] as? [String:Any]{
            let ondatoFlowConfiguration = OndatoFlowConfiguration()
            ondatoFlowConfiguration.showSplashScreen = (flowConfiguration["showSplashScreen"] as? Bool) ?? true
            ondatoFlowConfiguration.showStartScreen = (flowConfiguration["showStartScreen"] as? Bool) ?? true
            ondatoFlowConfiguration.showConsentScreen = (flowConfiguration["showConsentScreen"] as? Bool) ?? true
            ondatoFlowConfiguration.showSelfieAndDocumentScreen = (flowConfiguration["showSelfieAndDocumentScreen"] as? Bool) ?? true
            ondatoFlowConfiguration.showSuccessWindow = (flowConfiguration["showSuccessWindow"] as? Bool) ?? true
            ondatoFlowConfiguration.ignoreLivenessErrors = (flowConfiguration["ignoreLivenessErrors"] as? Bool) ?? false
            ondatoFlowConfiguration.ignoreVerificationErrors = (flowConfiguration["ignoreVerificationErrors"] as? Bool) ?? false
            ondatoFlowConfiguration.recordProcess = (flowConfiguration["recordProcess"] as? Bool) ?? true

            configuration.flowConfiguration = ondatoFlowConfiguration;

        }
        if let mode : String = args["mode"] as? String {

            configuration.mode = mode == "live" ? OndatoEnvironment.live : OndatoEnvironment.test
        }

        if let language :  String = args["language"] as? String {
            var selectedLanguage : OndatoSDK.OndatoSupportedLanguage
            switch language {
            case "en":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.EN
            case "de":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.DE
            case "lt":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.LT
            case "lv":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.LV
            case "et":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.ET
            case "ru":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.RU
            default:
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.EN
            }
            OndatoLocalizeHelper.language = selectedLanguage
        }

        DispatchQueue.main.async {
            let sdk = OndatoService.shared.instantiateOndatoViewController()
            sdk.modalPresentationStyle = .fullScreen

            self.uiViewController.present(sdk, animated: true, completion: nil)
        }
        flutterResult(true)
    }

    func startIdentification(flutterResult: @escaping  FlutterResult) {
        var delegate: OndatoSDK.OndatoFlowDelegate? =  {() -> OndatoSDK.OndatoFlowDelegate in
            class FlowDelegate : OndatoSDK.OndatoFlowDelegate {
                private let result : FlutterResult
                init(r: @escaping FlutterResult) {
                    self.result = r
                }
                func flowDidSucceed(identificationId: String?) {
                    result(["identificationId": identificationId])
                }

                func flowDidFail(identificationId: String?, error: OndatoServiceError) {
                    result(["identificationId": identificationId, "error": String(error.rawValue)])
                }
            }
            let flowDelegate = FlowDelegate(r: flutterResult)
            return flowDelegate
        }()
        OndatoService.shared.flowDelegate = delegate
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
