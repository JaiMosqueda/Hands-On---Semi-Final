import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'edit.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

class _HomePageState extends State<HomePage> {
  List mapResponse = <dynamic>[];

  getTodo() async {
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body) as List<dynamic>;
      });
    } else {
      return null;
    }
  }

  displayEdited(var object) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.lightGreen,
        content: Text(
            'Edited Successfully: ${object["title"]} ID: ${object["id"]}')));
  }

  displayCreated(var object) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.lightGreen,
        content: Text(
            'Created Successfully: ${object["title"]} ID: ${object["id"]}')));
  }

  @override
  void initState() {
    getTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(
          child: Text('Todo'),
        ),
      ),


      body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: mapResponse.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lightGreen),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${mapResponse[index]['title']}'),
                  ElevatedButton(
                      onPressed: () async {
                        var check = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Edit(todo: mapResponse[index])));
                        if (check != null) {
                          displayEdited(mapResponse[index]);
                        } else {
                          print('No changes');
                        }
                      },
                      child: const Text('Edit')),
                ],
              ),
            );
          }),
    );
  }
}