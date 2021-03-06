import 'package:flutter_project/screens/comment_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:flutter_project/controllers/product_controller.dart';
import 'package:flutter_project/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailProduct extends StatelessWidget {
  final formatter = NumberFormat("#,###");
  final String productId;

  DetailProduct(this.productId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProductController>(
          builder: (_) => StreamBuilder<DocumentSnapshot>(
              stream: Get.find<ProductController>().fetchProduct(productId),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.data!.exists) {
                  final Product product = Product.fromDocumentSnapshot(
                      documentSnapshot: snapshot.data!);
                  return SingleChildScrollView(
                    child: SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(
                                child: Image(
                                    fit: BoxFit.cover,
                                    height: 260,
                                    width: 260,
                                    image: NetworkImage(product.pathImage)),
                              )
                            ],
                          ),
                          Column(children: [
                            const Expanded(child: SizedBox(), flex: 1),
                            Expanded(
                              flex: 2,
                              child: Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24, horizontal: 24),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFFAF9FE),
                                      border: Border.all(
                                          color: const Color(0xFFD9D0E3)),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: const TextStyle(
                                            color: Color(0xFF2D0C57),
                                            fontFamily: 'RedHatDisplay',
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(height: 12),
                                      int.parse(product.discount) == 0
                                          ? RichText(
                                              text: TextSpan(
                                                  text: formatter.format(
                                                      double.parse(
                                                          product.price)),
                                                  style: const TextStyle(
                                                      color: Color(0xFF2D0C57),
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  children: const [
                                                    TextSpan(
                                                        text: ' vn??',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF9586A8),
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
                                                  ]),
                                            )
                                          : RichText(
                                              text: TextSpan(
                                                  text: formatter.format((double
                                                          .parse(
                                                              product.price) -
                                                      (double.parse(product
                                                              .discount) /
                                                          100 *
                                                          double.parse(
                                                              product.price)))),
                                                  style: const TextStyle(
                                                      color: Color(0xFF2D0C57),
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  children: const [
                                                    TextSpan(
                                                        text: ' vn??',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF9586A8),
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
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
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            )
                                          : RichText(
                                              text: TextSpan(
                                                text: formatter.format(
                                                    double.parse(
                                                        product.price)),
                                                style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Color(0xFF9586A8),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                children: const [
                                                  TextSpan(
                                                      text: ' vn??',
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color:
                                                              Color(0xFF9586A8),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400))
                                                ],
                                              ),
                                            ),
                                      const SizedBox(height: 24),
                                      Expanded(
                                        child: PageView(
                                          pageSnapping: true,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Th??ng tin s???n ph???m',
                                                  style: TextStyle(
                                                      color: Color(0xFF2D0C57),
                                                      fontSize: 22,
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                const SizedBox(height: 24),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    child: Text(
                                                      product.howtouse!,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xFF9586A8),
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'RedHatDisplay',
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Th??nh ph???n s???n ph???m',
                                                  style: TextStyle(
                                                      color: Color(0xFF2D0C57),
                                                      fontSize: 22,
                                                      fontFamily:
                                                          'RedHatDisplay',
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                SizedBox(height: 24),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    child: Text(
                                                      product.components!,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xFF9586A8),
                                                          fontFamily:
                                                              'RedHatDisplay',
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    const Text(
                                                      'T???ng s??? b??nh lu???n : ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF2D0C57),
                                                          fontFamily:
                                                              'RedHatDisplay',
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    StreamBuilder<
                                                            QuerySnapshot>(
                                                        stream: Get.find<
                                                                ProductController>()
                                                            .fetchCmt(
                                                                productId),
                                                        builder:
                                                            (context, stream) {
                                                          if (stream
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return const Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          }
                                                          if (stream.hasError) {
                                                            return Center(
                                                                child: Text(stream
                                                                    .error
                                                                    .toString()));
                                                          }
                                                          QuerySnapshot
                                                              querySnapshot =
                                                              stream.data!;
                                                          return Text(
                                                            querySnapshot.size
                                                                .toString(),
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xFF2D0C57),
                                                                fontFamily:
                                                                    'RedHatDisplay',
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          );
                                                        }),
                                                  ],
                                                ),
                                                const SizedBox(height: 12),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Get.to(() =>
                                                              CommentScreen(
                                                                  productId));
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    const Color(
                                                                        0xFFFBEAFF)),
                                                        child: const Text(
                                                          'Xem t???t c???',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF2D0C57),
                                                              fontFamily:
                                                                  'RedHatDisplay',
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        children: [
                                          GetBuilder<AuthController>(
                                              builder: (_) => StreamBuilder<
                                                      DocumentSnapshot>(
                                                  stream:
                                                      Get.find<AuthController>()
                                                          .fetchFavProduct(
                                                              productId),
                                                  builder: (context,
                                                      AsyncSnapshot<
                                                              DocumentSnapshot>
                                                          snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Expanded(
                                                        flex: 1,
                                                        child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              side: const BorderSide(
                                                                  color: Color(
                                                                      0xFF9586A8)),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                              primary:
                                                                  Colors.white,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          12),
                                                            ),
                                                            onPressed: () {
                                                              _likeaproduct(
                                                                  product);
                                                            },
                                                            child: const Icon(
                                                              Icons.favorite,
                                                              color: Color(
                                                                  0xFF9586A8),
                                                              size: 24,
                                                            )),
                                                      );
                                                    }
                                                    if (snapshot.hasError) {
                                                      return Center(
                                                          child: Text(snapshot
                                                              .error
                                                              .toString()));
                                                    }
                                                    if (snapshot.data!.exists) {
                                                      return Expanded(
                                                        flex: 1,
                                                        child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              side: const BorderSide(
                                                                  color: Color(
                                                                      0xFF7203FF)),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                              primary:
                                                                  Colors.white,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          12),
                                                            ),
                                                            onPressed: () {
                                                              _unlikeaproduct(
                                                                  product);
                                                            },
                                                            child: const Icon(
                                                              Icons.favorite,
                                                              color: Color(
                                                                  0xFF7203FF),
                                                              size: 24,
                                                            )),
                                                      );
                                                    } else {
                                                      return Expanded(
                                                        flex: 1,
                                                        child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              side: const BorderSide(
                                                                  color: Color(
                                                                      0xFF9586A8)),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                              primary:
                                                                  Colors.white,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          12),
                                                            ),
                                                            onPressed: () {
                                                              _likeaproduct(
                                                                  product);
                                                            },
                                                            child: const Icon(
                                                              Icons.favorite,
                                                              color: Color(
                                                                  0xFF9586A8),
                                                              size: 24,
                                                            )),
                                                      );
                                                    }
                                                  })),
                                          const SizedBox(width: 12),
                                          GetBuilder<ProductController>(
                                              builder: (_) => StreamBuilder<
                                                      DocumentSnapshot>(
                                                  stream: Get.find<
                                                          ProductController>()
                                                      .fetchProduct(productId),
                                                  builder: (context,
                                                      AsyncSnapshot<
                                                              DocumentSnapshot>
                                                          snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    }
                                                    if (snapshot.hasError) {
                                                      return Center(
                                                          child: Text(snapshot
                                                              .error
                                                              .toString()));
                                                    }
                                                    if (snapshot.data!.exists) {
                                                      final Product product = Product
                                                          .fromDocumentSnapshot(
                                                              documentSnapshot:
                                                                  snapshot
                                                                      .data!);
                                                      if (int.parse(product
                                                              .quantum!) ==
                                                          0) {
                                                        return Expanded(
                                                          flex: 3,
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                  primary: const Color(
                                                                      0xFF0BCE83),
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          12)),
                                                              onPressed: null,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  Icon(
                                                                    Icons
                                                                        .shopping_cart_outlined,
                                                                    size: 24,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          12),
                                                                  Text(
                                                                    '???? B??N H???T',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                ],
                                                              )),
                                                        );
                                                      } else {
                                                        return Expanded(
                                                          flex: 3,
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                  primary: const Color(
                                                                      0xFF0BCE83),
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          12)),
                                                              onPressed: () {
                                                                Get.find<
                                                                        AuthController>()
                                                                    .addProductToCart(
                                                                        product);
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  Icon(
                                                                    Icons
                                                                        .shopping_cart_outlined,
                                                                    size: 24,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          12),
                                                                  Text(
                                                                    'TH??M V??O GI??? H??NG',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                ],
                                                              )),
                                                        );
                                                      }
                                                    } else {
                                                      return Expanded(
                                                        flex: 3,
                                                        child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8)),
                                                                primary: const Color(
                                                                    0xFF0BCE83),
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        12)),
                                                            onPressed: null,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: const [
                                                                Icon(
                                                                  Icons
                                                                      .shopping_cart_outlined,
                                                                  size: 24,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                SizedBox(
                                                                    width: 12),
                                                                Text(
                                                                  '???? B??? X??A',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                              ],
                                                            )),
                                                      );
                                                    }
                                                  })),
                                        ],
                                      )
                                    ],
                                  )),
                            )
                          ]),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "????",
                        style: TextStyle(fontSize: 130),
                      ),
                      Text("S???n ph???m n??y ???? b??? x??a"),
                    ],
                  ));
                }
              })),
    );
  }
}

void _likeaproduct(Product product) {
  Get.find<AuthController>().LikeAProduct(product);
}

void _unlikeaproduct(Product product) {
  Get.find<AuthController>().UnlikeAProduct(product);
}
