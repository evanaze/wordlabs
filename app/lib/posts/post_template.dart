import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wordlabs/util/button.dart';
          
class PostTemplate extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<PostTemplate> createState() => _PostTemplateState();
}

class _PostTemplateState extends State<PostTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // user post

          // user name and caption
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              alignment: Alignment(-1, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('@evanazevedo',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                ],
              )
            )
          )
        
        // Buttons
        Container(
          alignment: Alignment(1, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(icon: Icons.favorite, number: '1.2M'),
              MyButton(icon: Icons.chat_bubble_outline_outlined, number: '232'),
              MyButton(icon: Icons.send, number: '123')
            ]),)
        ],
      )
    );
  }
}

          body: SafeArea(
              child: FutureBuilder<String>(
                  future: _content,
                  builder: (context, snapshot) {
                    List<Widget> children;
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Html(
                          data: snapshot.data,
                          style: {
                            'h1': Style(color: Colors.red),
                            'p': Style(
                                color: Colors.black87,
                                fontSize: FontSize.medium),
                            'ul': Style(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20))
                          },
                        ),
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
                  })),