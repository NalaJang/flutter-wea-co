import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/go_router/router.dart';
<<<<<<< HEAD
=======
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/presentation/navigation_bar/bottom_navigation_widget.dart';
import 'package:weaco/presentation/navigation_bar/floating_action_button_widget.dart';
>>>>>>> dev
import 'firebase_options.dart';

late Box<String> dataBox;

void main() async {
  await Hive.initFlutter();
  dataBox = await Hive.openBox('weacoBox');
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  diSetup();
  runApp(const WeacoApp());
}

class WeacoApp extends StatelessWidget {
  const WeacoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ko', 'KR')],
      locale: const Locale('ko'),
      title: 'WeaCo',
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 22),
          headlineMedium: TextStyle(fontSize: 18),
          headlineSmall: TextStyle(fontSize: 14),
          bodyLarge: TextStyle(fontSize: 12),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffF2C347)),
        primaryColor: const Color(0xffF2C347),
        canvasColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xffF5F5F5),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
