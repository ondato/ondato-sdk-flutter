package com.kyc.ondato.ondato_flutter

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.kyc.ondato.Ondato
import com.kyc.ondato.OndatoConfig
import com.kyc.ondato.OndatoError
import com.kyc.ondato.enums.Language

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** OndatoFlutterPlugin */
class OndatoFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var mContext: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ondato_flutter")
    channel.setMethodCallHandler(this)
    mContext = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    val args = call.arguments;
        when (call.method) {
            "getPlatformVersion" ->
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "initialSetup" -> initialSetup(result, args)
            "startIdentification" -> startIdentification(result)
            else -> result.notImplemented()
        }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun startIdentification(result: Result) {
      try {
          Ondato.starIdentification(mContext, object : Ondato.ResultListener {
              override fun onSuccess(identificationId: String?) {
                  result.success(mapOf("identificationId" to identificationId))
              }

              override fun onFailure(identificationId: String?, error: OndatoError) {
                  result.success(
                      mapOf(
                          "identificationId" to identificationId,
                          "error" to error.message
                      )
                  )
              }
          })
      } catch (e: Exception) {
          result.error(" ", e.message, e.stackTrace.toString())
      }
  }

  private fun initialSetup(result: Result, args: Any) {
    val map = args as? HashMap<String, Any>
    if (map != null) {
        val mode = map["mode"] as String
        val credentials = map["credentials"] as HashMap<String?, String?>
        val flowConfig = map["flowConfiguration"] as? HashMap<String, Boolean>
        val language = map["language"] as String

        val identificationId = credentials["identificationId"]?: ""
        Log.d("ONDATO SDK", "identificationID $identificationId")

        val config = OndatoConfig.Builder()
                // .setCredentials("Demo", "123asd!")
                .recordProcess(flowConfig?.get("recordProcess") ?: false) //defaul is false
                .setToken(credentials["accessToken"] ?: "")
                .setIdentificationId(identificationId)
                .showSplashScreen(flowConfig?.get("showSplashScreen") ?: true) //default is true
                .showStartScreen(flowConfig?.get("showStartScreen") ?: true) //default is true
                .showConsentScreen(flowConfig?.get("showConsentScreen")
                        ?: true) //default is true
                .showSelfieWithDocumentScreen(flowConfig?.get("showSelfieAndDocumentScreen")
                        ?: true) //default is true
                .showSuccessScreen(flowConfig?.get("showSuccessWindow")
                        ?: true) //default is true
                .ignoreLivenessError(flowConfig?.get("ignoreLivenessErrors")
                        ?: false) //
                .ignoreVerificationErrors(flowConfig?.get("ignoreVerificationErrors")
                        ?: false) //default is false
                .recordProcess(flowConfig?.get("recordProcess") ?: false) //default is true
                .setMode(getMode(mode)) //default is TEST
                .setLanguage(getLanguage(language)) // default is English
                .build()
        Ondato.init(config)
        result.success(true)
    } else {
        result.error(null, "", "Missing parameters")
    }
  }

  private fun getLanguage(str: String?): Language {
    var lang = Language.English
    when (str) {
        "lt" -> lang = Language.Lithuanian
        "de" -> lang = Language.German
        "lv" -> lang = Language.Latvian
        "et" -> lang = Language.Estonian
        "ru" -> lang = Language.Russian
    }
    return lang
  }

  private fun getMode(str: String?): OndatoConfig.Mode {
      var mode = OndatoConfig.Mode.TEST
      when (str) {
          "live" -> mode = OndatoConfig.Mode.LIVE
          "test" -> mode = OndatoConfig.Mode.TEST
      }
      return mode
  }

}
