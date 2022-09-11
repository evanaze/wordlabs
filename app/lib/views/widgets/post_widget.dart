import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PostWidget extends StatelessWidget {
  final String content;

  const PostWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Html(
          data: content,
          style: {
            'h1': Style(color: Colors.red),
            'p': Style(color: Colors.black87, fontSize: FontSize.medium),
            'ul': Style(margin: const EdgeInsets.symmetric(vertical: 20)),
          },
        ),
      ),
    );
  }
}
