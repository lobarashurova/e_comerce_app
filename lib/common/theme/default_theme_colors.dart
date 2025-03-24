import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

abstract class StaticColors {
  static const black = Color(0xFF1B1B1B);
  static const blueWhale = Color(0xFF0ABAB5);
  static const white = Color(0xFFFFFFFF);
  static const vividCerulean = Color(0xFFffedcc);
  static const midnight = Color(0xFF242B3A);
  static const raven = Color(0x8B9099B2);
  static const aluminium = Color(0xFF858991);
  static const solitude = Color(0xFFF5F6F8);
  static const bittersweet = Color(0xFFFF5F5F);
  static const speechGreen = Color(0xFF1AE209);
  static const limeGreen = Color(0xFFDBFFE2);
  static const viking = Color(0xFF41B0B7);
  static const whiteLilac = Color(0xFFE7E7E9);
  static const mahogany = Color(0xFFC93E3E);
  static const snow = Color(0xFFFFEFEF);
  static const lavender = Color(0xFFF3FAFD);
  static const serena = Color(0xFFC896FE);
}

@singleton
class DefaultThemeColors {
  final primary = StaticColors.blueWhale;
  final primary01 = StaticColors.vividCerulean;
  final primary02 = StaticColors.vividCerulean.withOpacity(0.5);
  final primary005 = StaticColors.vividCerulean.withOpacity(0.1);
  final onPrimary = StaticColors.white;
  final primary2 = StaticColors.black;
  final headline = StaticColors.lavender;
  final greenHeadline = StaticColors.limeGreen;
  final window = StaticColors.solitude;
  final window05 = StaticColors.solitude.withOpacity(0.5);
  final label = StaticColors.midnight;
  final title = StaticColors.raven;
  final title01 = StaticColors.raven.withOpacity(0.1);
  final errorColor = StaticColors.bittersweet;
  final display = StaticColors.aluminium;
  final avatarMain = StaticColors.speechGreen;
  final avatarSecond = StaticColors.viking;
  final grey = StaticColors.whiteLilac;
  final grey05 = StaticColors.whiteLilac.withOpacity(0.5);
  final disable = StaticColors.vividCerulean.withOpacity(0.15);
  final warningDark = StaticColors.mahogany;
  final warningLight = StaticColors.snow;
  final lightBlue = StaticColors.lavender;
}
