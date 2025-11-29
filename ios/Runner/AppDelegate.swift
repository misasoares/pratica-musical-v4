import Flutter
import UIKit
import AVFoundation

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let audioChannel = FlutterMethodChannel(name: "com.antigravity.guitarmaster/audio",
                                              binaryMessenger: controller.binaryMessenger)
    
    audioChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "play" {
        NSLog("NativeAudio: Play command received")
        AudioServicesPlaySystemSound(1057) // System sound for beep
        result(nil)
      } else if call.method == "stop" {
        NSLog("NativeAudio: Stop command received")
        result(nil)
      } else if call.method == "setBpm" {
        if let args = call.arguments as? [String: Any],
           let bpm = args["bpm"] as? Int {
             NSLog("NativeAudio: Set BPM command received: \(bpm)")
             result(nil)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "BPM is missing or invalid", details: nil))
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
