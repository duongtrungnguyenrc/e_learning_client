import 'dart:async';

class DebounceUtils {
  static Function debounce(Function(String) function, int milliseconds) {
    Timer? timer;

    return (String text) {
      timer?.cancel();

      timer = Timer(Duration(milliseconds: milliseconds), () {
        function(text);
      });
    };
  }
}
