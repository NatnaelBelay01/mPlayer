import 'package:flutter/material.dart';
import 'package:mplayer/core/theme/color_pallet.dart';

class AppTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorPallet.backgroundColor,
    appBarTheme: const AppBarTheme(
      color: ColorPallet.backgroundColor,
    ),
  );
}
