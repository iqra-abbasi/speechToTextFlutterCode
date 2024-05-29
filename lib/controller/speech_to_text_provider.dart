import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class SpeechToTextProvider with ChangeNotifier {
  /// Private variables
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  /// To get access of private variable to another class
  bool get speechEnabled => _speechEnabled;

  String get lastWords => _lastWords;

  bool get isListening => _speechToText.isListening;

  /// Initializing the speech
  Future<void> initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    notifyListeners();
  }

  /// Start Listening of speech function here
  Future<void> startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    notifyListeners();
  }

  /// Stop Listening of speech function here
  Future<void> stopListening() async {
    await _speechToText.stop();
    notifyListeners();
  }

  /// on printing last words here
  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
    notifyListeners();
  }

  /// Stop Watch Timer
  late Stopwatch _stopwatch;
  late Timer _timer;

  stopwatchProvider() {
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      notifyListeners();
    });
  }

  bool get isRunning => _stopwatch.isRunning;

  String get formattedText {
    var milli = _stopwatch.elapsed.inMilliseconds;

    String milliseconds = (milli % 1000)
        .toString()
        .padLeft(3, "0"); // this one for the miliseconds
    String seconds = ((milli ~/ 1000) % 60)
        .toString()
        .padLeft(2, "0"); // this is for the second
    String minutes = ((milli ~/ 1000) ~/ 60)
        .toString()
        .padLeft(2, "0"); // this is for the minute

    return "$minutes:$seconds:$milliseconds";
  }

  void handleStartStop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
    notifyListeners();
  }

  void reset() {
    _stopwatch.reset();
    notifyListeners();
  }


}
