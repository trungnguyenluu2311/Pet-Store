import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:flutter_project/controllers/utilities_controller.dart';
import 'package:flutter_project/models/product_model.dart';
import 'package:flutter_project/models/user_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail_product.dart';

class Payment extends StatelessWidget {
  final formatter = new NumberFormat("#,###");
  UserModel user = UserModel();
  late String useraddress;
  late double totals;
  late double totalstemp;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GetBuilder<AuthController>(
            builder: (_) => StreamBuilder<DocumentSnapshot>(
                stream: Get.find<AuthController>().fetchUser(),
                builder: (context, stream) {
                  if (stream.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (stream.hasError) {
                    return Center(child: Text(stream.error.toString()));
                  }
                  user = UserModel.fromDocumentSnapshot(
                      documentSnapshot: stream.data!);
                  useraddress = user.address!;
                  return Scaffold(
                    appBar: AppBar(
                      elevation: 0.5,
                      iconTheme: const IconThemeData(color: Color(0xFF2D0C57)),
                      centerTitle: true,
                      title: const Text(
                        'Thanh toán',
                        style: TextStyle(
                            color: Color(0xFF2D0C57),
                            fontFamily: "RedHatDisplay",
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      backgroundColor: const Color(0xFFFAF9FE),
                    ),
                    body: SingleChildScrollView(
                      child: Container(
                        color: const Color(0xFFFAF9FE),
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFD9D0E3)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.person_rounded,
                                        color: Color(0xFF2D0C57),
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Thông tin người mua',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "RedHatDisplay",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF2D0C57)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      user.name!,
                                      style: const TextStyle(
                                        fontFamily: "RedHatDislay",
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF9586A8),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      user.phone!,
                                      style: const TextStyle(
                                        fontFamily: "RedHatDislay",
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF9586A8),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFD9D0E3)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.location_on,
                                        color: Color(0xFF2D0C57),
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Địa chỉ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "RedHatDisplay",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF2D0C57)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      user.address!,
                                      style: const TextStyle(
                                        fontFamily: "RedHatDislay",
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF9586A8),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFD9D0E3)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.local_shipping,
                                        color: Color(0xFF2D0C57),
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Phương thức vận chuyển',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "RedHatDisplay",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF2D0C57)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  GetBuilder<UtilitiesController>(
                                      builder: (controller) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Radio<String>(
                                                value: "Shop tự vận chuyển",
                                                groupValue: controller
                                                    .selectRadioShipping,
                                                activeColor:
                                                    const Color(0xFF7203FF),
                                                onChanged: (val) {
                                                  controller
                                                      .setSelectRadioShipping(
                                                          val!);
                                                }),
                                            Text(
                                              'Shop tự vận chuyển',
                                              style: TextStyle(
                                                color: controller
                                                            .selectRadioShipping ==
                                                        'Shop tự vận chuyển'
                                                    ? const Color(0xFF7203FF)
                                                    : const Color(0xFF9586A8),
                                                fontFamily: "RedHatDisplay",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio<String>(
                                                value: "Giao hàng nhanh",
                                                groupValue: controller
                                                    .selectRadioShipping,
                                                activeColor:
                                                    const Color(0xFF7203FF),
                                                onChanged: (val) {
                                                  controller
                                                      .setSelectRadioShipping(
                                                          val!);
                                                }),
                                            Text(
                                              'Giao hàng nhanh',
                                              style: TextStyle(
                                                color: controller
                                                            .selectRadioShipping ==
                                                        'Giao hàng nhanh'
                                                    ? const Color(0xFF7203FF)
                                                    : const Color(0xFF9586A8),
                                                fontFamily: "RedHatDisplay",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio<String>(
                                                value: "Ninja Van",
                                                groupValue: controller
                                                    .selectRadioShipping,
                                                activeColor:
                                                    const Color(0xFF7203FF),
                                                onChanged: (val) {
                                                  controller
                                                      .setSelectRadioShipping(
                                                          val!);
                                                }),
                                            Text(
                                              'Ninja Van',
                                              style: TextStyle(
                                                color: controller
                                                            .selectRadioShipping ==
                                                        'Ninja Van'
                                                    ? const Color(0xFF7203FF)
                                                    : const Color(0xFF9586A8),
                                                fontFamily: "RedHatDisplay",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio<String>(
                                                value: "Bưu điện",
                                                groupValue: controller
                                                    .selectRadioShipping,
                                                activeColor:
                                                    const Color(0xFF7203FF),
                                                onChanged: (val) {
                                                  controller
                                                      .setSelectRadioShipping(
                                                          val!);
                                                }),
                                            Text(
                                              'Bưu điện',
                                              style: TextStyle(
                                                color: controller
                                                            .selectRadioShipping ==
                                                        'Bưu điện'
                                                    ? const Color(0xFF7203FF)
                                                    : const Color(0xFF9586A8),
                                                fontFamily: "RedHatDisplay",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFD9D0E3)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.payment,
                                        color: Color(0xFF2D0C57),
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Phương thức thanh toán',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "RedHatDisplay",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF2D0C57)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  GetBuilder<UtilitiesController>(
                                      builder: (controller) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Radio<String>(
                                                value: "Tiền mặt",
                                                groupValue: controller
                                                    .selectRadioPayment,
                                                activeColor:
                                                    const Color(0xFF7203FF),
                                                onChanged: (val) {
                                                  controller
                                                      .setSelectRadioPayment(
                                                          val!);
                                                }),
                                            Text(
                                              'Tiền mặt',
                                              style: TextStyle(
                                                color: controller
                                                            .selectRadioPayment ==
                                                        'Tiền mặt'
                                                    ? const Color(0xFF7203FF)
                                                    : const Color(0xFF9586A8),
                                                fontFamily: "RedHatDisplay",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio<String>(
                                                value: "Thẻ",
                                                groupValue: controller
                                                    .selectRadioPayment,
                                                activeColor:
                                                    const Color(0xFF7203FF),
                                                onChanged: (val) {
                                                  controller
                                                      .setSelectRadioPayment(
                                                          val!);
                                                }),
                                            Text(
                                              'Thẻ',
                                              style: TextStyle(
                                                color: controller
                                                            .selectRadioPayment ==
                                                        'Thẻ'
                                                    ? const Color(0xFF7203FF)
                                                    : const Color(0xFF9586A8),
                                                fontFamily: "RedHatDisplay",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFD9D0E3)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.money_off,
                                        color: Color(0xFF2D0C57),
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Mã giảm giá',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "RedHatDisplay",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF2D0C57)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: TextField(
                                          style: TextStyle(
                                              fontFamily: 'RedHatDisplay',
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF9586A8),
                                              fontSize: 18),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6,
                                                      horizontal: 10),
                                              primary: const Color(0xFF7203FF)),
                                          child: const Text(
                                            'DÙNG',
                                            style: TextStyle(
                                                fontFamily: "RedHatDisplay",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFD9D0E3)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.shopping_cart,
                                        color: Color(0xFF2D0C57),
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Giỏ hàng',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "RedHatDisplay",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF2D0C57)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  GetBuilder<AuthController>(
                                      builder: (_) => StreamBuilder<
                                              QuerySnapshot>(
                                          stream: Get.find<AuthController>()
                                              .fetchProductsFromCartUser(),
                                          builder: (context, stream) {
                                            if (stream.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                            if (stream.hasError) {
                                              return Center(
                                                  child: Text(
                                                      stream.error.toString()));
                                            }
                                            QuerySnapshot querySnapshot =
                                                stream.data!;
                                            double TotalsPrice() {
                                              double tempcounter = 0;
                                              for (int i = 0;
                                                  i < querySnapshot.size;
                                                  i++) {
                                                final item1 =
                                                    querySnapshot.docs[i];
                                                final Product product1 = Product
                                                    .fromQueryDocumentSnapshotForcart(
                                                        queryDocSnapshot:
                                                            item1);
                                                tempcounter += (int.parse(
                                                        product1.quantum!) *
                                                    (double.parse(
                                                            product1.price) -
                                                        double.parse(product1
                                                                .price) *
                                                            double.parse(
                                                                product1
                                                                    .discount) /
                                                            100));
                                              }
                                              // print(tempcounter);
                                              totalstemp = tempcounter;
                                              return tempcounter;
                                            }

                                            final formatter =
                                                new NumberFormat("#,###");
                                            return Column(
                                              children: [
                                                ListView.builder(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        querySnapshot.size,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final item = querySnapshot
                                                          .docs[index];
                                                      final Product product = Product
                                                          .fromQueryDocumentSnapshotForcart(
                                                              queryDocSnapshot:
                                                                  item);
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 6),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                child: Text(
                                                              product.name,
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xFF2D0C57),
                                                                  fontFamily:
                                                                      'RedHatDisplay',
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            )),
                                                            RichText(
                                                              text: TextSpan(
                                                                  text: product
                                                                      .price,
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0xFF2D0C57),
                                                                      fontFamily:
                                                                          'RedHatDisplay',
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                  children: const [
                                                                    TextSpan(
                                                                        text:
                                                                            ' đ',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFF9586A8),
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ))
                                                                  ]),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                        child: Text('Tổng tiền',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF2D0C57),
                                                                fontFamily:
                                                                    'RedHatDisplay',
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))),
                                                    RichText(
                                                      text: TextSpan(
                                                          text: formatter.format(
                                                              TotalsPrice()),
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xFF2D0C57),
                                                              fontFamily:
                                                                  'RedHatDisplay',
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          children: const [
                                                            TextSpan(
                                                                text: ' đ',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF9586A8),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ))
                                                          ]),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                          })),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    bottomNavigationBar: Container(
                      padding: const EdgeInsets.all(12),
                      color: const Color(0xFFFAF9FE),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF0BCE83),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          _pay();
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
                })));
  }

  void _pay() {
    if (useraddress == "") {
      Get.snackbar("Thông báo", "Bạn chưa cài đặt địa chỉ nhận hàng");
    } else {
      Get.find<AuthController>().paythebill(
          user,
          totals.toString(),
          Get.find<UtilitiesController>().selectRadioShipping,
          Get.find<UtilitiesController>().selectRadioPayment);
    }
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
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: Get.width * 0.94,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
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
                        style: TextStyle(
                          fontSize: 20,
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
                              ? Text(
                                  "${formatter.format(double.parse(product.price))} vnđ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                )
                              : Text(
                                  "${formatter.format((double.parse(product.price) - (double.parse(product.discount) / 100 * double.parse(product.price))))} vnđ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
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
                        children: [
                          int.parse(product.discount) == 0
                              ? Text("")
                              : Text(
                                  "${formatter.format(double.parse(product.price))}",
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Text("${product.quantum}"),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
