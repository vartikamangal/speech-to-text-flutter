import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'audioconvert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.teal,
    ),
      home: Homepage(),
    );
  }
}


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dummy App"),
      ),
      body:Container(
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString('data_json/datas.json'),
          builder: (context,snapshot){
            var mydata=json.decode(snapshot.data.toString());
            return  ListView.builder(
                itemBuilder: (BuildContext context,int index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Image.network(mydata [index]['image']),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                 (mydata [index]['gender']=="Male" ? "MR " : "MS ") +mydata [index]['first_name']+' '+mydata [index]['last_name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(mydata [index]['description'].length > 30 ? '${mydata [index]['description'].substring(0, 30)}...' : mydata [index]['description']),

                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: mydata == null ? 0 : mydata.length,
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => SpeechScreen()),);
          //here the code
        },
      ),
    );
  }
}

