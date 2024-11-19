import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mplayer/core/theme/theme.dart';
import 'package:mplayer/features/music_player/presentation/pages/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}
