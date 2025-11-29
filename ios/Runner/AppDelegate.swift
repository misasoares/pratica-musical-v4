import Flutter
import UIKit
import AVFoundation

@main
@objc class AppDelegate: FlutterAppDelegate {
  
  private var timer: DispatchSourceTimer?
  private var currentBpm: Int = 60
  private var isPlaying: Bool = false
  private let queue = DispatchQueue(label: "com.antigravity.metronome", qos: .userInteractive)

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let audioChannel = FlutterMethodChannel(name: "com.antigravity.guitarmaster/audio",
                                              binaryMessenger: controller.binaryMessenger)
    
    audioChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard let self = self else { return }
      
      if call.method == "play" {
        self.startMetronome()
        result(nil)
      } else if call.method == "stop" {
        self.stopMetronome()
        result(nil)
      } else if call.method == "setBpm" {
        if let args = call.arguments as? [String: Any],
           let bpm = args["bpm"] as? Int {
             self.currentBpm = bpm
             if self.isPlaying {
               // Restart timer to apply new BPM immediately
               self.stopMetronome()
               self.startMetronome()
             }
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
  
  private func startMetronome() {
    if isPlaying { return }
    isPlaying = true
    
    let interval = 60.0 / Double(currentBpm)
    
    timer = DispatchSource.makeTimerSource(queue: queue)
    timer?.schedule(deadline: .now(), repeating: interval)
    timer?.setEventHandler { [weak self] in
      self?.playSound()
    }
    timer?.resume()
    NSLog("NativeAudio: Metronome started at \(currentBpm) BPM")
  }
  
  private func stopMetronome() {
    isPlaying = false
    timer?.cancel()
    timer = nil
    NSLog("NativeAudio: Metronome stopped")
  }
  
  private func playSound() {
    AudioServicesPlaySystemSound(1057)
  }
}
