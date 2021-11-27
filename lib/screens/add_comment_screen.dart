import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddComment extends StatefulWidget {
  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF2D0C57),
        ),
        centerTitle: true,
        elevation: 0.5,
        title: const Text("Thêm bình luận",
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D0C57),
            )),
        backgroundColor: const Color(0xFFFAF9FE),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              icon: const Icon(
                Icons.save,
                size: 24,
              ),
              onPressed: (){},
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFFAF9FE),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TextField(
                maxLines: 3,
                // controller: ,
                cursorColor: Color(0xFF7203FF),
                style: TextStyle(
                  fontFamily: 'RedHatDisplay',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD9D0E3)),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Color(0xFF7203FF))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
