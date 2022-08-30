import 'package:flutter/material.dart';
import 'package:wordlabs/posts/mypost_1.dart';
import 'package:wordlabs/util/post_template.dart';

class UserHomePage extends StatelessWidget {
  final _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      children: [
        PostTemplate(
          username: 'evanazevedo',
          numberOfLikes: '1.3M',
          numberOfComments: '123',
          numberOfShares: '414',
          userPost: Container(
            color: Colors.amber,
          ),
        ),
        PostTemplate(
          username: 'alliedacar',
          numberOfLikes: '1.3M',
          numberOfComments: '123',
          numberOfShares: '414',
          userPost: Container(
            color: Colors.pink,
          ),
        ),
        PostTemplate(
          username: 'tompoko',
          numberOfLikes: '13M',
          numberOfComments: '123',
          numberOfShares: '414',
          userPost: Container(
            color: Colors.black,
          ),
        )
      ],
    ));
  }
}
