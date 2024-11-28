import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mplayer/core/theme/theme.dart';
import 'package:mplayer/features/music_player/presentation/pages/homepage.dart';
import 'package:mplayer/init_dependencies.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
	initDependecies();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}
