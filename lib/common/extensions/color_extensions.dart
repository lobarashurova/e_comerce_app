import 'dart:ui';

extension HexColor on String {
  Color toColor() {
    final hexColor = replaceFirst('#', '');
    return Color(int.parse(hexColor, radix: 16) + 0xFF000000);
  }
}