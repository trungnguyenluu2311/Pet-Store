import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'add_comment_screen.dart';

class CommentScreen extends StatefulWidget {
  CommentScreen();

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  _CommentScreenState();

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List filedata = [
    {
      'name': 'Adeleye Ayodeji',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF2D0C57),
        ),
        centerTitle: true,
        elevation: 0.5,
        title: const Text("Bình luận",
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D0C57),
            )),
        backgroundColor: const Color(0xFFFAF9FE),
      ),
      body: Container(
          color: const Color(0xFFFAF9FE),
          padding: const EdgeInsets.all(12),
          child: CommentBox(
            userImage:
                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.youtube.com%2Fchannel%2FUCwXdFgeE9KYzlDdR7TG9cMw&psig=AOvVaw1GQb83eiCfokDK7NPQqSO1&ust=1638095034906000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCIiA8tepuPQCFQAAAAAdAAAAABAI',
            child: commentChild(filedata),
            labelText: 'Write a comment...',
            withBorder: false,
            errorText: 'Comment cannot be blank',
            sendButtonMethod: () {
              if (formKey.currentState!.validate()) {
                print(commentController.text);
                setState(() {
                  var value = {
                    'name': 'New User',
                    'pic':
                        'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                    'message': commentController.text
                  };
                  filedata.insert(0, value);
                });
                commentController.clear();
                FocusScope.of(context).unfocus();
              } else {
                print("Not validated");
              }
            },
            formKey: formKey,
            commentController: commentController,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            sendWidget:
                const Icon(Icons.send_sharp, size: 24, color: Colors.black),
          )
          /*Column(
      children: const [Comment(), SizedBox(height: 24), Comment()],
        ),*/
          ),
      /*bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: const Color(0xFFFAF9FE),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: const Color(0xFF0BCE83),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          onPressed: () {
            Get.to(() => AddComment());
          },
          child: const Text(
            'THÊM BÌNH LUẬN',
            style: TextStyle(
                fontFamily: "RedHatDisplay",
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),*/
    );
  }
}

class Comment extends StatelessWidget {
  const Comment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Expanded(
              child: Text('Luke Skywalker',
                  style: TextStyle(
                      color: Color(0xFF2D0C57),
                      fontFamily: 'RedHatDisplay',
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
            ),
            Text('28/08/2021',
                style: TextStyle(
                    color: Color(0xFF9586A8),
                    fontFamily: 'RedHatDisplay',
                    fontSize: 16,
                    fontWeight: FontWeight.w500))
          ],
        ),
        const SizedBox(height: 12),
        const Text('Tuyệt vời',
            style: TextStyle(
                color: Color(0xFF9586A8),
                fontFamily: 'RedHatDisplay',
                fontSize: 16,
                fontWeight: FontWeight.w500))
      ],
    );
  }
}

Widget commentChild(data) {
  return ListView(
    children: [
      for (var i = 0; i < data.length; i++)
        Padding(
          padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
          child: ListTile(
            leading: GestureDetector(
              onTap: () async {
                // Display the image in large form.
                print("Comment Clicked");
              },
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: new BoxDecoration(
                    color: Colors.blue,
                    borderRadius: new BorderRadius.all(Radius.circular(50))),
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
              ),
            ),
            title: Text(
              data[i]['name'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(data[i]['message']),
          ),
        )
    ],
  );
}
