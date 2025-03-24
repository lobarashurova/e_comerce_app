import 'dart:math';

extension StringNumberExtension on String {
  String spaceSeparateNumbers() {
    final result = replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');
    return result;
  }
}

extension DoubleExtension on double {
  String toFormattedString({int fractionDigits = 2}) {
    return toStringAsFixed(fractionDigits).replaceAll(RegExp(r'\.0+$'), '');
  }

  String toCurrency({String symbol = '', int fractionDigits = 2}) {
    return '$symbol${toStringAsFixed(fractionDigits)}';
  }

  double toRounded({int fractionDigits = 2}) {
    final mod = pow(10, fractionDigits);
    return (this * mod).round() / mod;
  }
}