import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/screens/detail_product.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project/controllers/product_controller.dart';
import 'package:flutter_project/models/product_model.dart';

class FavProSceen extends StatefulWidget {
  FavProSceen();

  @override
  _FavProSceenState createState() => _FavProSceenState();
}

class _FavProSceenState extends State<FavProSceen>
    with SingleTickerProviderStateMixin {
  _FavProSceenState();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF2D0C57),
        ),
        centerTitle: true,
        elevation: 0.5,
        title: const Text("Sản phẩm yêu thích",
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D0C57),
            )),
        backgroundColor: const Color(0xFFFAF9FE),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Get.find<AuthController>().fetchAllFavProduct(),
        builder: (context, stream) {
          if (stream.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (stream.hasError) {
            return Center(child: Text(stream.error.toString()));
          }
          QuerySnapshot querySnapshot = stream.data!;
          if (querySnapshot.size == 0) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "😿",
                  style: TextStyle(fontSize: 130),
                ),
                Text(
                  "Không có sản phẩm yêu thích nào",
                  style: TextStyle(
                    color: Color(0xFF2D0C57),
                    fontFamily: 'RedHatDisplay',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ));
          } else {
            return SingleChildScrollView(
              child: Container(
                color: Color(0xFFFAF9FE),
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
                            final Product product =
                                Product.fromQueryDocumentSnapshot(
                                    queryDocSnapshot: item);
                            return products(product);
                          }),
                    ],
                  ),
                ]),
              ),
            );
          }
        },
      ),
    );
  }
}

GestureDetector products(Product product) {
  final formatter = NumberFormat("#,###");
  void _changetodetail(String idproduct) {
    Get.to(() => DetailProduct(idproduct));
  }

  return GestureDetector(
    onTap: () {
      _changetodetail(product.id!);
    },
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        color: const Color(0xFFFAF9FE),
        child: SizedBox(
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(
                        fit: BoxFit.cover,
                        height: 168,
                        width: 168,
                        image: NetworkImage(product.pathImage))),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                            color: Color(0xFF2D0C57),
                            fontFamily: 'RedHatDisplay',
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      int.parse(product.discount) == 0
                          ? RichText(
                              text: TextSpan(
                                  text: formatter
                                      .format(double.parse(product.price)),
                                  style: const TextStyle(
                                      color: Color(0xFF2D0C57),
                                      fontFamily: 'RedHatDisplay',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                  children: const [
                                    TextSpan(
                                        text: ' vnđ',
                                        style: TextStyle(
                                            color: Color(0xFF9586A8),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400))
                                  ]),
                            )
                          : RichText(
                              text: TextSpan(
                                  text: formatter.format(
                                      (double.parse(product.price) -
                                          (double.parse(product.discount) /
                                              100 *
                                              double.parse(product.price)))),
                                  style: const TextStyle(
                                      color: Color(0xFF2D0C57),
                                      fontFamily: 'RedHatDisplay',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                  children: const [
                                    TextSpan(
                                        text: ' vnđ',
                                        style: TextStyle(
                                            color: Color(0xFF9586A8),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400))
                                  ]),
                            ),
                      int.parse(product.discount) == 0
                          ? RichText(
                              text: const TextSpan(
                                text: "",
                                style: TextStyle(
                                    color: Color(0xFF9586A8),
                                    fontFamily: 'RedHatDisplay',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          : RichText(
                              text: TextSpan(
                                text: formatter
                                    .format(double.parse(product.price)),
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Color(0xFF9586A8),
                                    fontFamily: 'RedHatDisplay',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                                children: const [
                                  TextSpan(
                                      text: ' vnđ',
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Color(0xFF9586A8),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400))
                                ],
                              ),
                            ),
                      const Expanded(child: SizedBox()),
                      GetBuilder<ProductController>(
                          builder: (_) => StreamBuilder<DocumentSnapshot>(
                              stream: Get.find<ProductController>()
                                  .fetchProduct(product.id!),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text(snapshot.error.toString()));
                                }
                                if (snapshot.data!.exists) {
                                  final Product product =
                                      Product.fromDocumentSnapshot(
                                          documentSnapshot: snapshot.data!);
                                  if (int.parse(product.quantum!) == 0) {
                                    return SizedBox(
                                      width: 176,
                                      child: ElevatedButton(
                                          onPressed: null,
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            primary: const Color(0xFF0BCE83),
                                          ),
                                          child: const Icon(
                                              Icons.shopping_cart_outlined)),
                                    );
                                  } else {
                                    return SizedBox(
                                      width: 176,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Get.find<AuthController>()
                                                .addProductToCart(product);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            primary: const Color(0xFF0BCE83),
                                          ),
                                          child: const Icon(
                                              Icons.shopping_cart_outlined)),
                                    );
                                  }
                                } else {
                                  return SizedBox(
                                    width: 176,
                                    child: ElevatedButton(
                                        onPressed: null,
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          primary: const Color(0xFF0BCE83),
                                        ),
                                        child: const Icon(
                                            Icons.shopping_cart_outlined)),
                                  );
                                }
                              })),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
  );
}
