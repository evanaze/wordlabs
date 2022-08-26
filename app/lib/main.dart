import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;


Future<String> makeRequest() async {
    var url = Uri(
      scheme: 'http',
      host: 'localhost',
      port: 8080);
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


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'WordLabs', home: HomePage());
  }
}

class _MyAppState extends State<MyApp> {
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
      body: SafeArea(
        child: FutureBuilder<String>(
          future: _content,
          builder: (context, snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <SingleChildScrollView>[
                const Html(
                  data: _content,
                  tagsList: Html.tags,
                  style: {
                    "table": Style(
                      backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                    ),
                    "tr": Style(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    "th": Style(
                      padding: EdgeInsets.all(6),
                      backgroundColor: Colors.grey,
                    ),
                    "td": Style(
                      padding: EdgeInsets.all(6),
                      alignment: Alignment.topLeft,
                    ),
                    'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
                  },
                ),
              ];
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
    );
  }
}
