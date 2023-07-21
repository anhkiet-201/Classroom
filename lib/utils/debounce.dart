import 'dart:async';

class Debounce {
  Timer? _timer;
  final Duration duration;
  Debounce({this.duration = const Duration(milliseconds: 500)});

  void run(Function() callback) {
    if(_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(duration, callback);
  }

  void cancel() {
    _timer?.cancel();
  }
}