import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/product_controller.dart';
import 'package:flutter_project/models/cmt_model.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommentScreen extends StatelessWidget {
  late final String idProduct;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  CommentScreen(this.idProduct);

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
                  'https://firebasestorage.googleapis.com/v0/b/veterinary-store.appspot.com/o/person_6x8.png?alt=media&token=https://firebasestorage.googleapis.com/v0/b/veterinary-store.appspot.com/o/person_6x8.png?alt=media&token=05b8a45f-8a00-4046-a64b-000488206f37',
              child: StreamBuilder<QuerySnapshot>(
                  stream: Get.find<ProductController>().fetchCmt(idProduct),
                  builder: (context, stream) {
                    if (stream.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (stream.hasError) {
                      return Center(child: Text(stream.error.toString()));
                    }
                    QuerySnapshot querySnapshot = stream.data!;
                    return SingleChildScrollView(
                      child: Container(
                        color: const Color(0xFFFAF9FE),
                        padding: const EdgeInsets.all(12),
                        child: Column(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: querySnapshot.size,
                                  itemBuilder: (context, index) {
                                    final item = querySnapshot.docs[index];
                                    final CommentModel cmt =
                                        CommentModel.fromQueryDocumentSnapshot(
                                            queryDocSnapshot: item);
                                    return comment(cmt);
                                  }),
                            ],
                          ),
                        ]),
                      ),
                    );
                  }),
              labelText: 'Viết một bình luận...',
              withBorder: false,
              errorText: 'Bình luận không được để trống',
              sendButtonMethod: () {
                if (formKey.currentState!.validate()) {
                  Get.find<ProductController>()
                      .addCmt(idProduct, commentController.text);
                  commentController.clear();
                  FocusScope.of(context).unfocus();
                } else {
                  print("Not validated");
                }
              },
              formKey: formKey,
              commentController: commentController,
              backgroundColor: Colors.red,
              textColor: const Color(0xFF9586A8),
              sendWidget:
                  const Icon(Icons.send_sharp, size: 24, color: Color(0xFF7203FF)),
            )));
  }
}

Container comment(CommentModel cmt) {
  int timeInMillis = cmt.dateTimeCmt!;
  var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
  var formattedDate = DateFormat.yMMMd().format(date);
  return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(cmt.name!,
                    style: const TextStyle(
                        color: Color(0xFF2D0C57),
                        fontFamily: 'RedHatDisplay',
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
              ),
              Text(formattedDate,
                  style: const TextStyle(
                      color: Color(0xFF9586A8),
                      fontFamily: 'RedHatDisplay',
                      fontSize: 16,
                      fontWeight: FontWeight.w500))
            ],
          ),
          const SizedBox(height: 12),
          Text(cmt.content!,
              style: const TextStyle(
                  color: Color(0xFF9586A8),
                  fontFamily: 'RedHatDisplay',
                  fontSize: 16,
                  fontWeight: FontWeight.w500))
        ],
      ));
}
