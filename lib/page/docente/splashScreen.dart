import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

int finalName = 0;
String titulo= '';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Aquí vamos a guardar los datos que recuperamos de SharedPreferences
  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Timer(
          Duration(seconds: 2),
          () => finalName == null || finalName == 0
              ? Navigator.pushReplacementNamed(context, '/')
              : Navigator.pushReplacementNamed(context, '/home'));
    });
    super.initState();
  }



  // Método que se encarga de recuperar los datos de SharedPreferences
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtName = sharedPreferences.getInt('name');
    if ('$finalName' == null) {
    }
    // Si no hay ningún valor guardado, utilizamos una cadena vacía
    setState(() {
      finalName = obtName! as int;
    });
    print(finalName);
  }

  // Método que se ejecuta al iniciar la aplicación

  // Widget que muestra la pantalla de Splash Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: prefer_const_constructors
            Image.asset(
                  '../img/ups.png',
                  height:200,
                ),
            SizedBox(height: 30.0),
            // ignore: prefer_const_constructors
            Text( 
              'Bienvenido',
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            // Text(
            //   '$finalName',
            //   style: TextStyle(
            //     fontSize: 18.0,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
