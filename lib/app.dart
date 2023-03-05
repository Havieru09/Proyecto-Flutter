import 'package:flutter/material.dart';
import 'package:proyecto_plataforma/page/docente/close.dart';
import 'package:proyecto_plataforma/page/docente/home.dart';
import 'package:proyecto_plataforma/page/docente/listar.dart';
import 'package:proyecto_plataforma/page/docente/loginApp.dart';
import 'package:proyecto_plataforma/page/docente/open.dart';
import 'package:proyecto_plataforma/page/docente/soporte.dart';
import 'package:proyecto_plataforma/page/docente/splashScreen.dart';
import 'package:proyecto_plataforma/page/soporte/login_page.dart';
import 'package:proyecto_plataforma/page/soporte/second_page.dart';
import 'package:proyecto_plataforma/page/soporte/splashScreen.dart';
import 'package:proyecto_plataforma/page/soporte/third_page.dart';

String id= '';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        '/splash': (context) => SplashScreen(),
        "/": (context) => loginApp(),
        "/home": (context) => const home(),
        "/open": (context) => open(),
        "/close": (context) => close(),
        "/soporte": (context) => soporte(),
        "/list": (context) => UserList(),
        "/s":(context) => LoginPage(),
        "/second":(context) => const SecondPage(),
        //"/third":(context) => ThirdPage(),
        '/splashSoporte': (context) => SplashScreenSoporte(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.amber,
      ),
    );
  }
}
