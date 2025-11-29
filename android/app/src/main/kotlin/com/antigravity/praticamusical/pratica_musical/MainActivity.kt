package com.antigravity.praticamusical.pratica_musical

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log
import android.media.ToneGenerator
import android.media.AudioManager

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.antigravity.guitarmaster/audio"
    
    @Volatile private var isPlaying = false
    @Volatile private var currentBpm = 60
    private var metronomeThread: Thread? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "play" -> {
                    startMetronome()
                    result.success(null)
                }
                "stop" -> {
                    stopMetronome()
                    result.success(null)
                }
                "setBpm" -> {
                    val bpm = call.argument<Int>("bpm")
                    if (bpm != null) {
                        currentBpm = bpm
                        Log.d("NativeAudio", "BPM updated to: $currentBpm")
                    }
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun startMetronome() {
        if (isPlaying) return
        isPlaying = true
        Log.d("NativeAudio", "Starting metronome at $currentBpm BPM")
        
        metronomeThread = Thread {
            // Create ToneGenerator inside the thread to ensure thread safety
            val toneGen = ToneGenerator(AudioManager.STREAM_MUSIC, 100)
            
            while (isPlaying) {
                try {
                    toneGen.startTone(ToneGenerator.TONE_CDMA_PIP, 50)
                    Log.d("NativeAudio", "Beep")
                    
                    val safeBpm = if (currentBpm > 0) currentBpm else 60
                    val intervalMs = 60000L / safeBpm
                    
                    Thread.sleep(intervalMs)
                } catch (e: InterruptedException) {
                    // Thread interrupted, stop loop
                    break
                } catch (e: Exception) {
                    Log.e("NativeAudio", "Error in metronome loop", e)
                }
            }
            
            // Release resources
            toneGen.release()
            Log.d("NativeAudio", "Metronome thread finished")
        }
        metronomeThread?.start()
    }

    private fun stopMetronome() {
        Log.d("NativeAudio", "Stopping metronome")
        isPlaying = false
        metronomeThread?.interrupt()
        metronomeThread = null
    }
}
