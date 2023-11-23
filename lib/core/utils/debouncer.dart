/// for use in search text fields
import 'dart:async';
import 'dart:ui';

class Debouncer {
  Debouncer({this.milliseconds});
  final int? milliseconds;
  VoidCallback? action;

  Timer? _timer;

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}
