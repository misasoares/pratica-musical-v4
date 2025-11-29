package com.antigravity.praticamusical.pratica_musical

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log
import android.media.ToneGenerator
import android.media.AudioManager

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.antigravity.guitarmaster/audio"
    private val toneGenerator = ToneGenerator(AudioManager.STREAM_MUSIC, 100)

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "play" -> {
                    Log.d("NativeAudio", "Play command received")
                    toneGenerator.startTone(ToneGenerator.TONE_CDMA_PIP, 150)
                    result.success(null)
                }
                "stop" -> {
                    Log.d("NativeAudio", "Stop command received")
                    result.success(null)
                }
                "setBpm" -> {
                    val bpm = call.argument<Int>("bpm")
                    Log.d("NativeAudio", "Set BPM command received: $bpm")
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
