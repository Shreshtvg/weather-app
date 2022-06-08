// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, avoid_print, unnecessary_this

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

var description;
var hum;
var wind;
var current;

Future getweather() async{
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=Bangalore&units=metric&appid=9fb127a41c02f9a03b4f0d16e0c94cf7");
  http.Response response=await http.get(url);
  var result = jsonDecode(response.body);
  setState(() {
    this.current = result['main']['temp'];
    this.description = result['weather'][0]['description'];
    this.hum = result['main']['humidity'];
    this.wind = result['wind']['speed'];
  });
}
@override
void initState(){
  super.initState();
  this.getweather();
}

@override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.black54,
          centerTitle: true,

          title: Text("WEATHER APP"),

        ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            color: Colors.lightGreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                  child:
                  Text(
                    "Current Weather Forecast",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30
                    ),
                  ),
                ),
                  Text(
                    current!=null? current.toString() + "\u00B0C": "loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(50.0),
              child: ListView(
                children: [
                  ListTile(
                    // leading: FaIcon
                    title: Text("Clouds",
                    style: TextStyle(
                      fontSize: 25
                    ),
                    ),
                    trailing: Text(description!=null? description.toString() : "loading"),
                  ),
                  ListTile(
                    title: Text("Humidity",
                      style: TextStyle(
                          fontSize: 25
                      ),
                    ),
                    trailing: Text(hum!=null? hum.toString() + "%" : "loading"),
                  ),
                  ListTile(
                    title: Text("Wind speed",
                      style: TextStyle(
                          fontSize: 25
                      ),
                    ),
                    trailing: Text(wind!=null? wind.toString() + " km/hr" : "loading"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
