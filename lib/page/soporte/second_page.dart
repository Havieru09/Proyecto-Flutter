import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget  {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _MyApiState createState() => _MyApiState();
}

class _MyApiState extends State<SecondPage> {
  @override
  void initState() {
//response = fetchUsers();
    super.initState();
  }

  Future<List<dynamic>> fetchUsers() async {
    var result =
        await http.get(Uri.parse("https://gorest.co.in/public/v2/users?page=1"));
    return jsonDecode(result.body);
  }

  myApiWidget() {
    return FutureBuilder(
      future: fetchUsers(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                
                child: Column(
                  children: [
                    
                    ListTile(
                      onTap:  () {
                      Navigator.pushNamed(context, "/third");
                   },
                      
                      title: Text(
                          snapshot.data[index]['name']
                           ),
                           
                      trailing:Column(
                        children: [
                          SizedBox(height: 7),
                           Icon(snapshot.data[index]['status'] == "active"
                                  ?Icons.verified_user : Icons.verified_user, 
                                  color: snapshot.data[index]['status'] == 
                                  "active" ? Colors.green : Colors.red),
                                   Text(snapshot.data[index]['id'].toString()),
                           
                        ],
                      ),
                      leading: Builder(
                        builder:(BuildContext context){
                          return Icon((snapshot.data[index]['gender'] == "male"
                            ?Icons.man_rounded: Icons.woman_rounded),
                          );
                        },
                        ),
                      
                      subtitle: Text(snapshot.data[index]['email'] 
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Solicitudes",
        style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
        automaticallyImplyLeading: false,
      ),
      body: myApiWidget(),
    );
  }
}