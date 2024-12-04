// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:movie_app/app_constants.dart';
import 'package:movie_app/injector.dart';
import 'package:movie_app/movie/pages/movie_page.dart';
import 'package:movie_app/movie/providers/movie_get_discover_provider.dart';
import 'package:movie_app/movie/providers/movie_get_now_playing_provider.dart';
import 'package:movie_app/movie/providers/movie_get_top_rated_provider.dart';
// import 'package:movie_app/movie/repostories/movie_repository.dart';
// import 'package:movie_app/movie/repostories/movie_repository_impl.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();
  runApp(const App()
  );
  FlutterNativeSplash.remove();
}

class App extends StatelessWidget {
  const App({super.key});

  // final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetDiscoverProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetTopRatedProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetNowPlayingProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MoviePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
