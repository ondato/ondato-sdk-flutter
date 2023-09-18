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

            if let headerColor : Int = appearance["headerColor"] as? Int {
                ondatoAppearance.consentWindow.header.color = headerColor.toUIColor()
            }

            if let acceptButtonColor : Int = appearance["acceptButtonColor"] as? Int {
                ondatoAppearance.consentWindow.acceptButton.backgroundColor = acceptButtonColor.toUIColor()
            }

            if let declineButtonColor : Int = appearance["declineButtonColor"] as? Int {
                ondatoAppearance.consentWindow.declineButton.backgroundColor = declineButtonColor.toUIColor()
            }

            configuration.appearance = ondatoAppearance

        }

        if let flowConfiguration : [String: Any] = args["flowConfiguration"] as? [String:Any]{
            let ondatoFlowConfiguration = OndatoFlowConfiguration()
            ondatoFlowConfiguration.showStartScreen = (flowConfiguration["showStartScreen"] as? Bool) ?? true
            ondatoFlowConfiguration.showSuccessWindow = (flowConfiguration["showSuccessWindow"] as? Bool) ?? true
            ondatoFlowConfiguration.removeSelfieFrame = (flowConfiguration["removeSelfieFrame"] as? Bool) ?? false
            ondatoFlowConfiguration.skipRegistrationIfDriverLicense = (flowConfiguration["skipRegistrationIfDriverLicense"] as? Bool) ?? false

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
            case "sq":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.SQ
            case "bg":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.BG
            case "es":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.ES
            case "fr":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.FR
            case "el":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.EL
            case "it":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.IT
            case "nl":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.NL
            case "ro":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.RO
            default:
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.EN
            }
            OndatoLocalizeHelper.language = selectedLanguage
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
                    result(["identificationId": identificationId, "error": String(error.description)])
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
