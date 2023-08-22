import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../layout/home_layout.dart';
import 'network/remote/diohelper.dart';
import 'shared/bloc_observer.dart';
import 'shared/cubit/home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return HomeCubit()
            ..getPhotosData()
            ..createDB();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AnimatedSplashScreen(
            splashIconSize: 180,
            duration: 4000,
            splash: const Image(
              image: AssetImage('assets/logo1.png'),
            ),
            nextScreen: HomeLayout(),
            splashTransition: SplashTransition.fadeTransition,
          ),
        ));
  }
}
