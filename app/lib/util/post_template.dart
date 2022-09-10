import 'package:flutter/material.dart';
import 'package:wordlabs/util/button.dart';

class PostTemplate extends StatelessWidget {
  final String username;
  final String numberOfLikes;
  final String numberOfComments;
  final String numberOfShares;
  final userPost;

  PostTemplate(
      {required this.username,
      required this.numberOfLikes,
      required this.numberOfComments,
      required this.numberOfShares,
      required this.userPost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // user post
          userPost,
          // user name and caption
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              alignment: Alignment(-1, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '@$username',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ),

          // Buttons
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              alignment: Alignment(1, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(icon: Icons.favorite, number: numberOfLikes),
                  MyButton(
                      icon: Icons.chat_bubble_outlined,
                      number: numberOfComments),
                  MyButton(icon: Icons.send, number: numberOfShares)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
