import 'package:alumni_connect/core/raw_user.dart';
import 'package:alumni_connect/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:alumni_connect/presentation/pages/navigator_screen.dart';
import 'package:alumni_connect/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: MaterialApp(
        home: NavigatorScreen(
          user: users[0],
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
