import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
  private var channel: FlutterMethodChannel?
  private let defaults = UserDefaults.standard

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
    channel = FlutterMethodChannel(name: "com.example.gallery/sharedpref", binaryMessenger: flutterViewController.binaryMessenger)
    
    channel?.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard let self = self else { return }
      
      if call.method == "setValue" {
        if let arguments = call.arguments as? [String: Any],
           let key = arguments["key"] as? String,
           let value = arguments["value"] as? String {
           self.setValue(key: key,value: value)
        }
        result(nil)
      } else if call.method == "getValue" {
        if let arguments = call.arguments as? [String: Any],
           let key = arguments["key"] as? String {
           self.getValue()
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func setValue(key: String, value: String) {
  self.defaults.stValue(value, forKey: key)
  self.defaults.synchronize()
  }

  private func getValue() {
  let value = self.defaults.string(forKey: key) ?? ""
  result(value)
  }
}
