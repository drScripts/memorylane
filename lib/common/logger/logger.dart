import 'package:logger/logger.dart';

class AppLogger {
  final String tag;

  const AppLogger(this.tag);

  debug(String message) {
    var logger = Logger();
    logger.d("[$tag]: $message");
  }

  fatal(String message) {
    var logger = Logger();
    logger.f("[$tag]: $message");
  }

  error(String message) {
    var logger = Logger();
    logger.e("[$tag]: $message");
  }

  info(String message) {
    var logger = Logger();
    logger.i("[$tag]: $message");
  }

  warning(String message) {
    var logger = Logger();

    logger.w("[$tag]: $message");
  }
}
