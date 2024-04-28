import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

sealed class Messages {
  static void showError(String message, BuildContext ctx) {
    showTopSnackBar(
      Overlay.of(ctx),
      CustomSnackBar.error(
        message: message,
      ),
    );
  }

  static void showInfo(String message, BuildContext ctx) {
    showTopSnackBar(
      Overlay.of(ctx),
      CustomSnackBar.info(
        message: message,
      ),
    );
  }

  static void showSuccess(String message, BuildContext ctx) {
    showTopSnackBar(
      Overlay.of(ctx),
      CustomSnackBar.success(
        message: message,
      ),
    );
  }
}
