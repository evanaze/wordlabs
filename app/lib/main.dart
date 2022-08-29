import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';


Future<String> makeRequest() async {
    var url = Uri.parse('http://localhost:8080');
    var response = await http.get(url);
    //If the http request is successful the statusCode will be 200
    if(response.statusCode == 200){
      String htmlToParse = response.body;
      return htmlToParse;
    } else {
      throw Exception("Invalid response. Status code: ${response.statusCode}");
    }
}


void main() => runApp(const MyApp());


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
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WordLabs'),
        ),
        body: SafeArea(
          child: FutureBuilder<String>(
            future: _content,
            builder: (context, snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                return Html(
                  data: snapshot.data,
                  style: {
                    'h1': Style(color: Colors.red),
                    'p': Style(color: Colors.black87, fontSize: FontSize.medium),
                    'ul': Style(margin: const EdgeInsets.symmetric(vertical: 20))
                  },
                );
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            }
          )
        ),
      )
    );
  }
}
