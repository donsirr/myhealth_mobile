import 'dart:async';
import 'package:flutter/foundation.dart';

class StrokeTimerProvider extends ChangeNotifier {
  Timer? _timer;
  int _seconds = 0;
  bool _isActive = false;

  // Getters
  bool get isActive => _isActive;
  int get seconds => _seconds;

  // Format timer as MM:SS (same as Next.js version)
  String get formattedTime {
    final mins = _seconds ~/ 60;
    final secs = _seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  /// Start the timer
  void startTimer() {
    if (_isActive) return; // Already running

    _isActive = true;
    _seconds = 0;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
      notifyListeners();
    });

    notifyListeners();
  }

  /// Stop the timer and reset
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    _isActive = false;
    _seconds = 0;
    notifyListeners();
  }

  /// Pause the timer (keeps current time)
  void pauseTimer() {
    _timer?.cancel();
    _timer = null;
    _isActive = false;
    notifyListeners();
  }

  /// Resume the timer (continues from current time)
  void resumeTimer() {
    if (_isActive) return;

    _isActive = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
      notifyListeners();
    });

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
