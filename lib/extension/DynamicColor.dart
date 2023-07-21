import 'package:flutter/material.dart';

extension DynamicColor on BuildContext {
  ColorScheme get getDynamicColor => Theme.of(this).colorScheme;
}