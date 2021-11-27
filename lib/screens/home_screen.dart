import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/detail_product.dart';
import 'package:get/get.dart';
import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project/controllers/product_controller.dart';
import 'package:flutter_project/models/product_model.dart';

class HomeScreen extends GetWidget<ProductController> {
  final formatter = NumberFormat("#,###");
  Stream<QuerySnapshot> streamQuery =
      Get.find<ProductController>().fetchProducts();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: GetBuilder<ProductController>(builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: const Color(0xFFFAF9FE),
            // centerTitle: true,
            title: const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                'Sản phẩm',
                style: TextStyle(
                    color: Color(0xFF2D0C57),
                    fontSize: 34,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w700),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size(35, 100),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Column(
                  children: [
                    TextField(
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                        labelStyle: TextStyle(
                            color: Color(0xFF9586A8),
                            fontSize: 16,
                            fontFamily: 'RedHatDisplay',
                            fontWeight: FontWeight.w400),
                        labelText: 'Tìm kiếm',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          size: 24,
                          color: Color(0xFF9378FF),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD9D0E3)),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Color(0xFF6C0EE4))),
                      ),
                      onChanged: (value) {
                        streamQuery = Get.find<ProductController>()
                            .searchProducts(value.toLowerCase());
                        controller.changeTagIndex(0);
                      },
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                              color: controller.tagIndex == 1
                                  ? const Color(0xFFE2CBFF)
                                  : Colors.white,
                              border: Border.all(
                                color: const Color(0xFFD9D0E3),
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          child: GestureDetector(
                            onTap: () {
                              if (controller.tagIndex == 1) {
                                streamQuery = Get.find<ProductController>()
                                    .fetchProducts();
                                controller.changeTagIndex(0);
                              } else {
                                streamQuery = Get.find<ProductController>()
                                    .fetchProductsFood();
                                controller.changeTagIndex(1);
                              }
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Thức ăn',
                                style: TextStyle(
                                    color: controller.tagIndex == 1
                                        ? const Color(0xFF6C0EE4)
                                        : const Color(0xFF9586A8),
                                    fontSize: 14,
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                            color: controller.tagIndex == 2
                                ? const Color(0xFFE2CBFF)
                                : Colors.white,
                            border: Border.all(
                              color: const Color(0xFFD9D0E3),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (controller.tagIndex == 2) {
                                streamQuery = Get.find<ProductController>()
                                    .fetchProducts();
                                controller.changeTagIndex(0);
                              } else {
                                streamQuery = Get.find<ProductController>()
                                    .fetchProductsMedic();
                                controller.changeTagIndex(2);
                              }
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Thuốc',
                                style: TextStyle(
                                    color: controller.tagIndex == 2
                                        ? const Color(0xFF6C0EE4)
                                        : const Color(0xFF9586A8),
                                    fontSize: 14,
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                            color: controller.tagIndex == 3
                                ? const Color(0xFFE2CBFF)
                                : Colors.white,
                            border: Border.all(
                              color: const Color(0xFFD9D0E3),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (controller.tagIndex == 3) {
                                streamQuery = Get.find<ProductController>()
                                    .fetchProducts();
                                controller.changeTagIndex(0);
                              } else {
                                streamQuery = Get.find<ProductController>()
                                    .fetchProductsToy();
                                controller.changeTagIndex(3);
                              }
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Đồ chơi',
                                style: TextStyle(
                                    color: controller.tagIndex == 3
                                        ? const Color(0xFF6C0EE4)
                                        : const Color(0xFF9586A8),
                                    fontSize: 14,
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: streamQuery,
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
            },
          ),
        );
      }),
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
