import 'package:flutter/material.dart';

void unfocus(BuildContext context) {
  FocusScope.of(context).unfocus();
}
// Ou dessa forma então ele pode ser invocado a partir do context diretamente 
extension UnFocusExtension on BuildContext {
  void unfocus() => Focus.of(this).unfocus();
}
