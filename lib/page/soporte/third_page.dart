//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  //const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Detalle de la Solicitud",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: _dsoli(context),
      
    );
  }
}

_dsoli(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Scaffold(
      body: Container(
          width: size.height,
          child: Column(
            //Column
            mainAxisAlignment: MainAxisAlignment.start,

            children: <Widget>[
              const SizedBox(height: 20.0),
             

              SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _datos()),
              const SizedBox(
                height: 20.0,
              ),
              SingleChildScrollView(
                  child: _detalle()),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(height: 40.0),
              _botones(),
            ],
          )));
}

Widget _datos() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      //const SizedBox(height: 10, width: 10),
      //padding: const EdgeInsets.only(left: 80),
      Container(
        
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 247, 252, 255), //EDE8E1
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(66, 0, 0, 0), blurRadius: 6, offset: Offset(0, 2))
            ]),
        constraints: const BoxConstraints(maxHeight: 60, maxWidth: 200),
        padding: const EdgeInsets.only(left: 35),
        child: Row(
          children: const [
            Text(
              "Bloque:",
              style: TextStyle(
                color: Color.fromRGBO(0, 2, 114, 0.612),
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "E",
              style: TextStyle(
                color: Color.fromRGBO(0, 55, 114, 100),
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 40),
      Container(
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 247, 252, 255),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ]),
        constraints: const BoxConstraints(maxHeight: 60, maxWidth: 200),
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: const [
            Text(
              "Aula:",
              style: TextStyle(
                color: Color.fromRGBO(0, 2, 114, 0.612),
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Lab #7",
              style: TextStyle(
                color: Color.fromRGBO(0, 55, 114, 100),
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 40),
      Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Color(0xffF7FCFF),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                topLeft: Radius.circular(30)
                ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ]),
        constraints: const BoxConstraints(maxHeight: 60, maxWidth: 300),
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: const [
            Text(
              "Tipo:",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color.fromRGBO(0, 2, 114, 0.612),
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Abrir Puerta",
              style: TextStyle(
                color: Color.fromRGBO(0, 55, 114, 100),
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _detalle() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      
      const Text(
              "Detalle:",
              style: TextStyle(
                color: Color.fromRGBO(0, 2, 114, 0.612),
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),

      Container(
      
      
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            
            boxShadow: const [
               BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2)
              )
            ]
        ),
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxHeight: 500, maxWidth: 350),
        child:     const Text(
          "Abra la plantilla o un documento basado en la plantilla cuya configuración quiere cambiar. En el menú Formato, haga clic en Fuente y luego en la pestaña Avanzado." ,
          style: TextStyle(
              color: Colors.black, fontSize: 16, ),
        ),
    ),
    ],
    
  );
}

Widget _botones(){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0),
    child: Wrap( 
      spacing: 50,
      children: [
        
        
        FilledButton.icon(onPressed: (){}, 
        
        icon: const Icon ( Icons.directions_walk_outlined, 
        size: 30, 
        ),

          label: const Text("En camino", 
          style: TextStyle(
            fontSize: 18,
          ),),
          style: const ButtonStyle(

            backgroundColor: MaterialStatePropertyAll(Color(0xff231F47)),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
            padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
            )
            
          ),
          
          FilledButton.icon(onPressed: (){}, 
        
        icon: const Icon ( Icons.check_box_rounded, 
        size: 30, 
        ),

          label: const Text("Realizado", 
          style: TextStyle(
            fontSize: 18,
          ),),
          style: const ButtonStyle(

            backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 31, 71, 43)),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
            padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
            )
            
          ),
        
        
      ],

    ),
  );
}