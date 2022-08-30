import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:wordlabs/homepage.dart';

void main() => runApp(const MyApp());

Future<String> makeRequest() async {
  var url = Uri.parse('http://localhost:8080');
  var response = await http.get(url);
  //If the http request is successful the statusCode will be 200
  if (response.statusCode == 200) {
    String htmlToParse = response.body;
    return htmlToParse;
  } else {
    throw Exception("Invalid response. Status code: ${response.statusCode}");
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<String> _content;

  @override
  void initState() {
    super.initState();
    _content = makeRequest();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(brightness: Brightness.dark));
  }
}
