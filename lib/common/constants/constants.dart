import 'package:flutter/cupertino.dart';

class Constants {
  static const baseUrl = 'https://dummyjson.com/';
  static const chatSocketUrl = '';
  static const notificationSocketUrl = '';
  static const imageUrl = "";

  static SizedBox getTopPadding(BuildContext context) =>
      SizedBox(height: MediaQuery.of(context).viewPadding.top);
}
