import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/product_model.dart';
import 'package:flutter_project/screens/payment_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'detail_product.dart';

class CartScreen extends GetWidget<AuthController> {
  late double totalstemp;
  final formatter = NumberFormat("#,###");
  Stream<QuerySnapshot> streamQuery =
      Get.find<AuthController>().fetchProductsFromCartUser();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: GetBuilder<AuthController>(builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: const Color(0xFFFAF9FE),
            // centerTitle: true,
            title: const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text(
                'Giỏ hàng',
                style: TextStyle(
                    color: Color(0xFF2D0C57),
                    fontSize: 34,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w700),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(0, 36),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: GetBuilder<AuthController>(
                    builder: (_) => StreamBuilder<QuerySnapshot>(
                        stream: Get.find<AuthController>()
                            .fetchProductsFromCartUser(),
                        builder: (context, stream) {
                          if (stream.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: const CircularProgressIndicator());
                          }
                          if (stream.hasError) {
                            return Center(child: Text(stream.error.toString()));
                          }
                          QuerySnapshot querySnapshot = stream.data!;
                          double TotalsPrice() {
                            double tempcounter = 0;
                            for (int i = 0; i < querySnapshot.size; i++) {
                              final item1 = querySnapshot.docs[i];
                              final Product product1 =
                                  Product.fromQueryDocumentSnapshotForcart(
                                      queryDocSnapshot: item1);
                              tempcounter += (int.parse(product1.quantum!) *
                                  (double.parse(product1.price) -
                                      double.parse(product1.price) *
                                          double.parse(product1.discount) /
                                          100));
                            }
                            // print(tempcounter);
                            totalstemp = tempcounter;
                            return tempcounter;
                          }

                          final formatter = new NumberFormat("#,###");
                          return Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: formatter.format(TotalsPrice()),
                                    style: const TextStyle(
                                        color: Color(0xFF2D0C57),
                                        fontFamily: 'RedHatDisplay',
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                    children: const [
                                      TextSpan(
                                          text: ' đ',
                                          style: TextStyle(
                                            color: Color(0xFF9586A8),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ))
                                    ]),
                              ),
                            ],
                          );
                        })),
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
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(color: Color(0xFFFAF9FE)),
                  child: Column(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 12),
                        // const SizedBox(height: 36),
                        const SizedBox(height: 12),
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: querySnapshot.size,
                            itemBuilder: (context, index) {
                              final item = querySnapshot.docs[index];
                              final Product product =
                                  Product.fromQueryDocumentSnapshotForcart(
                                      queryDocSnapshot: item);
                              return productincart(product);
                            }),
                      ],
                    ),
                  ]),
                ),
              );
            },
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: Color(0xFFFAF9FE),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFF0BCE83),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                Get.to(() => Payment());
              },
              child: const Text(
                'THANH TOÁN',
                style: TextStyle(
                    fontFamily: "RedHatDisplay",
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        );
      }),
    );
  }
}

void _changetodetail(String idProduct) {
  Get.to(() => DetailProduct(idProduct));
}

GestureDetector productincart(Product product) {
  final formatter = new NumberFormat("#,###");
  return GestureDetector(
    onTap: () {
      _changetodetail(product.id!);
    },
    child: Container(
      padding: const EdgeInsets.only(bottom: 12),
      width: Get.width * 0.94,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFD9D0E3)),
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.white,
        // elevation: 10,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Container(
                width: Get.width * 0.35,
                height: Get.width * 0.35,
                child: Image.network(
                  "${product.pathImage}",
                  fit: BoxFit.fill,
                  width: Get.width * 0.3,
                  height: Get.width * 0.3,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Text(
                      "${product.name}",
                      style: const TextStyle(
                        color: Color(0xFF2D0C57),
                        fontFamily: 'RedHatDisplay',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                  child: Container(
                    width: Get.width * 0.5,
                    child: Row(
                      children: [
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
                                          text: ' đ/cái',
                                          style: TextStyle(
                                            color: Color(0xFF9586A8),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ))
                                    ]),
                              )
                            : RichText(
                                text: TextSpan(
                                    text: formatter.format((double.parse(
                                            product.price) -
                                        (double.parse(product.discount) /
                                            100 *
                                            double.parse(product.price)))),
                                    style: const TextStyle(
                                      color: Color(0xFF2D0C57),
                                      fontFamily: 'RedHatDisplay',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    children: const [
                                      TextSpan(
                                          text: ' đ/cái',
                                          style: TextStyle(
                                              color: Color(0xFF9586A8),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400))
                                    ]),
                              )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Container(
                    width: Get.width * 0.5,
                    child: Row(
                      children: [
                        int.parse(product.discount) == 0
                            ? const Text("")
                            : Text(
                                "${formatter.format(double.parse(product.price))}",
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Color(0xFF2D0C57),
                                  fontFamily: 'RedHatDisplay',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Container(
                    width: Get.width * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(3),
                                minimumSize: const Size(0, 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                primary: const Color(0xFF7203FF),
                              ),
                              onPressed: () {
                                _showDialogremove(product, product.quantum!);
                              },
                              child: const Icon(
                                Icons.remove,
                                size: 24,
                              ),
                            ),
                            Text(
                              "${product.quantum}",
                              style: const TextStyle(
                                color: Color(0xFF9586A8),
                                fontFamily: "RedHatDisplay",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(3),
                                minimumSize: const Size(0, 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                primary: const Color(0xFF7203FF),
                              ),
                              onPressed: () {
                                Get.find<AuthController>()
                                    .addProductInCart(product);
                              },
                              child: const Icon(
                                Icons.add,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onTap: () {
                            _showDialog(product);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(6),
                            child:
                                Icon(Icons.delete, color: Color(0xFFCF2C0A)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void _showDialogremove(Product product, String quantum) {
  if (quantum == "1") {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          title: const Text("Bỏ sản phẩm khỏi giỏ hàng?",
              style: TextStyle(
                  color: Color(0xFF2D0C57),
                  fontFamily: 'RedHatDisplay',
                  fontWeight: FontWeight.w700)),
          content: Container(
            height: 80,
            child: Column(
              children: const [
                Text(
                  "😿",
                  style: TextStyle(fontSize: 30),
                ),
                Text("Bạn có chắc muốn bỏ sản phẩm khỏi giỏ hàng",
                    style: TextStyle(color: Color(0xFF2D0C57), fontSize: 18)),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(primary: const Color(0xFF7203FF)),
              child: const Text(
                'KHÔNG',
                style: TextStyle(
                    fontFamily: 'RedHatDisplay', fontWeight: FontWeight.w700),
              ),
            ),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xFF7203FF)),
                child: const Text(
                  'CÓ',
                  style: TextStyle(
                      fontFamily: 'RedHatDisplay', fontWeight: FontWeight.w700),
                ),
                onPressed: () =>
                    Get.find<AuthController>().deleteProductFromCart(product)),
          ],
        );
      },
    );
  } else {
    Get.find<AuthController>().removeProductInCart(product);
  }
}

void _showDialog(Product product) {
  showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: const Text("Bỏ sản phẩm khỏi giỏ hàng?",
            style: TextStyle(
                color: Color(0xFF2D0C57),
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w700)),
        content: Container(
          height: 80,
          child: Column(
            children: const [
              Text(
                "😿",
                style: TextStyle(fontSize: 30),
              ),
              Text("Bạn có chắc muốn bỏ sản phẩm khỏi giỏ hàng",
                  style: TextStyle(color: Color(0xFF2D0C57), fontSize: 18)),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(primary: const Color(0xFF7203FF)),
            child: const Text(
              'KHÔNG',
              style: TextStyle(
                  fontFamily: 'RedHatDisplay', fontWeight: FontWeight.w700),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: const Color(0xFF7203FF)),
              child: const Text(
                'CÓ',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w700),
              ),
              onPressed: () =>
                  Get.find<AuthController>().deleteProductFromCart(product)),
        ],
      );
    },
  );
}
