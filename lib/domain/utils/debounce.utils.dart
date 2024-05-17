import 'dart:async';

class DebounceUtils {
  static Function debounce(Function function, int milliseconds) {
    Timer? timer;

    return ([dynamic args]) {
      timer?.cancel();

      timer = Timer(Duration(milliseconds: milliseconds), () {
        if (args != null) {
          function(args);
        } else {
          function();
        }
      });
    };
  }
}
