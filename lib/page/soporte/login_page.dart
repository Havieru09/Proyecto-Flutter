import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class LoginPage extends StatelessWidget {
  static String id = "login_page";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
            body: Form (
              //width: size.height,
                child: Column( //Column
      //mainAxisAlignment: MainAxisAlignment.center,
      
      children: <Widget> [
        //const Cabecera(),
        const SizedBox(height: 80.0),
        Image.asset('images/ups_logo.png'),
        const SizedBox(height: 50),
        const Text(
          "Inicio de Sesion",
          style: TextStyle(
            color: Color.fromRGBO(0, 55, 114, 100),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30.0),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0), 
          child: _username()
        ), 
        const SizedBox(height: 30.0),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0), 
          child: _passwordtext()
        ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(width: 220),
            const Text("Restablecer Contraseña"),
          ],
        ),
        const SizedBox(height: 40.0),
        _bottonlogin(),

      ],
    )));
  }

  Widget _username() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Email",
          style: TextStyle(
              color: Colors.lightBlue, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container( 
        alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
               const BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2)
              )
            ]
        ),
        height: 60,
        child: const TextField( 
          keyboardType: TextInputType.emailAddress,
          style: TextStyle( color: Colors.black87),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.black
            ),
            hintText: "Email",
            hintStyle: TextStyle(
              color: Colors.black
            )
          ),
        ),
        )
      ],
    );
  }

  Widget _passwordtext() {
return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Contraseña",
          style: TextStyle(
              color: Colors.lightBlue, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container( 
        alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
               const BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2)
              )
            ]
        ),
        height: 60,
        child: const TextField( 
          obscureText: true,
          style: TextStyle( color: Colors.black87),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              color: Colors.black
            ),
            hintText: "Contraseña",
            hintStyle: TextStyle(
              color: Colors.black
            )
          ),
        ),
        )
      ],
    );
  }

  Widget _bottonlogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: const Text('Login',
            style: TextStyle(fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white) 
          )),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(0, 55, 114, 100))
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/second");
          });
    });

  }
}