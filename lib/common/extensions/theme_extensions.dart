import 'package:e_comerce_app/common/theme/default_theme_colors.dart';
import 'package:e_comerce_app/di/injection.dart';
import 'package:flutter/cupertino.dart';


extension ThemeContextExtensions on BuildContext {
  DefaultThemeColors get colors => getIt<DefaultThemeColors>();
}
