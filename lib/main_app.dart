import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermovie/bloc/movie_cubit.dart';
import 'package:fluttermovie/presentation/screen/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MovieCubit movieCubit = MovieCubit();

    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieCubit>(create: (context) => movieCubit),
      ],
      child: MaterialApp(
        title: 'Movie Flutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent.shade200),
          fontFamily: 'SF Pro Text',
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}