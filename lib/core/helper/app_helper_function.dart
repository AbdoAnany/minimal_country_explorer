import 'package:intl/intl.dart' as intl;

class AppFunction {


  static String formatNumber(input) {
    var formatter = intl.NumberFormat('##,000');
    return formatter.format(input);
  }
}
