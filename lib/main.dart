import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;


class DBConnection {

  static DBConnection _instance;

  final String _host = "DATABASE SERVER";
  final String _port = "DATABASE PORT";
  final String _dbName = "DATABASE NAME";
  Db _db;

  static getInstance(){
    if(_instance == null) {
      _instance = DBConnection();
    }
    return _instance;
  }

  Future<Db> getConnection() async{
    if (_db == null){
      try {
        _db = Db(_getConnectionString());
        await _db.open();
      } catch(e){
        print(e);
      }
    }
    return _db;
  }

  _getConnectionString(){
    return "mongodb://$_host:$_port/$_dbName";
  }

  closeConnection() {
    _db.close();
  }
}


String readFileAsync() {
  String contents = new File('assets/test.html').readAsStringSync();
  return contents;
}

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'WordLabs', home: HomePage());
  }
}


class HomePage extends StatelessWidget {
  final String _contents = readFileAsync();
  HomePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WordLabs'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Html(
            data: _contents,
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
        ),
      ),
    );
  }
}
