import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mplayer/core/theme/theme.dart';
import 'package:mplayer/features/music_control/bloc/music_control_bloc.dart';
import 'package:mplayer/features/music_player/presentation/bloc/music_bloc.dart';
import 'package:mplayer/features/music_player/presentation/bloc/music_event.dart';
import 'package:mplayer/features/music_player/presentation/pages/homepage.dart';
import 'package:mplayer/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependecies();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              serviceLocator<MusicBloc>()..add(MusicFetchFromCache()),
        ),
        BlocProvider(
          create: (_) =>
              serviceLocator<MusicControlBloc>(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}
