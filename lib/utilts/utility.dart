import 'dart:io';

import 'package:ai_avatar_explorer_app/theme/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class Utility {
  static Map<String, String> commonHeader({
    Map<String, String>? otherHeader,
    bool isDefaultAuthorizationKeyAdd = true,
  }) {
    // var token = await _authRepository.getRefreshToken(isLoading: false);
    var header = <String, String>{'Content-Type': 'application/json'};
    if (isDefaultAuthorizationKeyAdd) {
      header.addAll({
        'Authorization':
            'Token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NmJhZWYxMDA5NGFhOWU5OGU0Y2E5YzgiLCJpYXQiOjE3MzE5MDczMzZ9.VORiklvS_vSfWwoTpzsKAhBpObxW0Dk1GY2VvIM7cMw',
      });
    }

    if (otherHeader != null) {
      header.addAll(otherHeader);
    }
    return header;
  }

  static String dateStringddMMyyyy(String tod) {
    DateTime parsedDate =
        DateTime.parse(tod).toLocal(); // Convert to local timezone if needed
    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
    return formattedDate;
  }

  /// Internet Conection
  static Future<bool> isNetworkAvailable() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    try {
      // Try a DNS lookup to confirm internet access
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  ///error Message
  static errorMessage(BuildContext context, String message) async {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: Styles.whiteColorW70020),
        backgroundColor: ColorsValue.redColor,
      ),
    );
  }

  static snacBar(
    BuildContext context,
    String message,
    Color backgroundColor,
  ) async {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: Styles.whiteColorW70020),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.twenty),
        ),
        dismissDirection: DismissDirection.up,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          right: Dimens.twenty,
          left: Dimens.twenty,
        ),
      ),
    );
  }
}
