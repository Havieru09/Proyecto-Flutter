import 'package:flutter/material.dart';
import 'package:proyecto_plataforma/page/docente/close.dart';
import 'package:proyecto_plataforma/page/docente/home.dart';
import 'package:proyecto_plataforma/page/docente/listar.dart';
import 'package:proyecto_plataforma/page/docente/login.dart';
import 'package:proyecto_plataforma/page/docente/open.dart';
import 'package:proyecto_plataforma/page/docente/soporte.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => fromLogin(),
        "/home": (context) => const home(),
        "/open": (context) => open(),
        "/close": (context) => close(),
        "/soporte": (context) => soporte(),
        "/list": (context) => UserList(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.amber,
      ),
    );
  }
}
