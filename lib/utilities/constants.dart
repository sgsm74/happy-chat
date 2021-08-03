import 'package:flutter/material.dart';

class Constants {
  static Color kBackgroundColor = Color(0xffFCEDEA);
  static Color kTextColor = Color(0xff243443);
  static Color kDisableButtonBackgroundColor = Color(0xffC3C7CB);
  static Color kBorderColor = Color(0xffE0E0E0);
  static Color kFocusedBorderColor = Color(0xff828282);
  static Color kArrowBackIcon = Color(0xffE9E9EA);
  static double kBorderRadius = 8.0;
  static Color kErrorColor = Color(0xffEB5757);
  static Color kSendMessageBackgoundColor = Color(0xffFADDD7);
  static Color kHintColor = Color(0xff413d4b).withOpacity(0.5);
  static Color kReceiverMessageBackgroundColor = Color(0xffF6BEB1);
  static Color kSenderMessageBackgroundColor = Color(0xffFBDEAC);

  static String publishToTopic(String otpToken, String userToken) {
    return 'challenge/user/' + otpToken + '/' + userToken + '/';
  }

  static String subscribeToTopic(String otpToken, String userToken) {
    return 'challenge/user/' + userToken + '/' + otpToken + '/';
  }
}
