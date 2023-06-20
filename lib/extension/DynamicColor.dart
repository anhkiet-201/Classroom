
import 'package:flutter/material.dart';

extension DynamicColor on BuildContext {
  ColorScheme getDynamicColor() => Theme.of(this).colorScheme;
}