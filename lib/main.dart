import 'package:flutter/material.dart';
import 'package:fluttermovie/app.dart';

import 'main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  App.configure(
    apiBaseURL: 'https://api.themoviedb.org/3/',
  );

  await App().init();

  runApp(const MyApp());
}