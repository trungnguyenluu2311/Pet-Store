import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:flutter_project/models/order_model.dart';
import 'package:flutter_project/models/product_model.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'detail_product.dart';

class InvoiceDetail extends StatelessWidget {
  final String orderId;

  InvoiceDetail(this.orderId);

  final formatter = new NumberFormat("#,###");
  late OrderModel order;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        builder: (_) => StreamBuilder<DocumentSnapshot>(
            stream: Get.find<AuthController>().fetchOrder(orderId),
            builder: (context, stream) {
              if (stream.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (stream.hasError) {
                return Center(child: Text(stream.error.toString()));
              }
              order = OrderModel.fromDocumentSnapshot(
                  documentSnapshot: stream.data!);
              int timeInMillis = order.dateTimeOrder!;
              var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
              var formattedDate = DateFormat.yMMMd().format(date);
              return Scaffold(
                appBar: AppBar(
                  elevation: 0.5,
                  iconTheme: const IconThemeData(color: Color(0xFF2D0C57)),
                  centerTitle: true,
                  title: const Text(
                    'Chi tiết hóa đơn',
                    style: TextStyle(
                        color: Color(0xFF2D0C57),
                        fontFamily: "RedHatDisplay",
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  backgroundColor: const Color(0xFFFAF9FE),
                ),
                body: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                        color: const Color(0xFFFAF9FE),
                        width: double.infinity,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFD9D0E3)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.person,
                                          color: Color(0xFF2D0C57),
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          'Thông tin đơn hàng',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "RedHatDisplay",
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF2D0C57)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          boxDetail(),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              const Expanded(
                                                  child: Text(
                                                'Mã đơn hàng',
                                                style: TextStyle(
                                                    color: Color(0xFF2D0C57),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              )),
                                              Text(
                                                '${order.dateTimeOrder}',
                                                style: const TextStyle(
                                                    color: Color(0xFF9586A8),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              const Expanded(
                                                  child: Text(
                                                'Ngày',
                                                style: TextStyle(
                                                    color: Color(0xFF2D0C57),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              )),
                                              Text(
                                                formattedDate,
                                                style: const TextStyle(
                                                    color: Color(0xFF9586A8),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              const Expanded(
                                                  child: Text(
                                                'Tên người nhận',
                                                style: TextStyle(
                                                    color: Color(0xFF2D0C57),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              )),
                                              Text(
                                                order.nameUser,
                                                style: const TextStyle(
                                                    color: Color(0xFF9586A8),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              const Expanded(
                                                  child: Text(
                                                'Tổng tiền',
                                                style: TextStyle(
                                                    color: Color(0xFF2D0C57),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              )),
                                              Text(
                                                '${formatter.format(double.parse(order.totals))} đ',
                                                style: const TextStyle(
                                                    color: Color(0xFF9586A8),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFD9D0E3)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
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
                                          width: 6,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Địa chỉ',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "RedHatDisplay",
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF2D0C57)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: Text(
                                        order.addressUser,
                                        style: const TextStyle(
                                          fontFamily: "RedHatDislay",
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF9586A8),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFD9D0E3)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
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
                                          width: 6,
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
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: Text(
                                        order.shippingMethod,
                                        style: const TextStyle(
                                          fontFamily: "RedHatDislay",
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF9586A8),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFD9D0E3)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
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
                                          width: 6,
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
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: Text(
                                        order.paymentMethod,
                                        style: const TextStyle(
                                          fontFamily: "RedHatDislay",
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF9586A8),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFD9D0E3)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
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
                                    const SizedBox(height: 6),
                                    GetBuilder<AuthController>(
                                        builder: (_) =>
                                            StreamBuilder<QuerySnapshot>(
                                                stream:
                                                    Get.find<AuthController>()
                                                        .fetchProductsFromOrder(
                                                            orderId),
                                                builder: (context, stream) {
                                                  if (stream.connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                  if (stream.hasError) {
                                                    return Center(
                                                        child: Text(stream.error
                                                            .toString()));
                                                  }
                                                  QuerySnapshot querySnapshot =
                                                      stream.data!;
                                                  return ListView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          querySnapshot.size,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final item =
                                                            querySnapshot
                                                                .docs[index];
                                                        final Product product =
                                                            Product.fromQueryDocumentSnapshotForcart(
                                                                queryDocSnapshot:
                                                                    item);
                                                        return Material(
                                                          color: Colors.white,
                                                          child: InkWell(
                                                            onTap: () {
                                                              _changetodetail(
                                                                  product.id!);
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      18,
                                                                      0,
                                                                      18,
                                                                      6),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      product
                                                                          .name,
                                                                      style: const TextStyle(
                                                                          color: Color(
                                                                              0xFF2D0C57),
                                                                          fontFamily:
                                                                              'RedHatDisplay',
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${formatter.format((double.parse(product.price) - double.parse(product.discount) / 100 * double.parse(product.price)) * double.parse(product.quantum!))} đ',
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xFF9586A8),
                                                                        fontFamily:
                                                                            'RedHatDisplay',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            16),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                })),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                              child: Text(
                                            'Tổng tiền',
                                            style: TextStyle(
                                                color: Color(0xFF2D0C57),
                                                fontFamily: 'RedHatDisplay',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          )),
                                          Text(
                                            '${formatter.format(double.parse(order.totals))} đ',
                                            style: const TextStyle(
                                                color: Color(0xFF9586A8),
                                                fontFamily: 'RedHatDisplay',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ]))),
                bottomNavigationBar: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(color: Color(0xFFFAF9FE)),
                  child: ButtonCustom(),
                  // BottomAppBar(
                  //     color: const Color(0xFF085B6E), child: ButtonCustom()),
                ),
              );
            }));
  }

  //
  Container boxDetail() {
    if (order.isCancel == true) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Color(0xFFCF3D1F))),
          color: const Color(0xFFCF3D1F),
        ),
        child: const Text(
          "Bị hủy",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500),
        ),
      );
    } else if (order.isCompleteAdmin == true && order.isCompleteUser == true) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Color(0xFF1FCF8B))),
          color: const Color(0xFF1FCF8B),
        ),
        child: const Text(
          "Hoàn thành",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Color(0xFF471FCF))),
          color: const Color(0xFF471FCF),
        ),
        child: const Text(
          "Đang đợi",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500),
        ),
      );
    }
  }

  //
  Container ButtonCustom() {
    if (order.isShipping == true && order.isCompleteUser == false) {
      return Container(
        child: ElevatedButton(
          onPressed: () {
            _completeorder(orderId);
          },
          style: ElevatedButton.styleFrom(
              primary: const Color(0xFF1FCF8B),
              padding: const EdgeInsets.symmetric(vertical: 14)),
          child: const Text(
            'ĐÃ NHẬN ĐƯỢC HÀNG',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w700),
          ),
        ),
      );
    } else if (order.isCompleteAdmin == true && order.isCompleteUser == true) {
      return Container(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              primary: const Color(0xFF011F14),
              padding: const EdgeInsets.symmetric(vertical: 14)),
          child: const Text(
            'ĐÃ HOÀN THÀNH',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w700),
          ),
        ),
      );
    } else if (order.isCancel == true) {
      return Container(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              primary: const Color(0xFF210B06),
              padding: const EdgeInsets.symmetric(vertical: 14)),
          child: const Text(
            'BỊ HỦY',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w700),
          ),
        ),
      );
    } else if (order.isShipping == true) {
      return Container(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              primary: const Color(0xFF210B06),
              padding: const EdgeInsets.symmetric(vertical: 14)),
          child: const Text(
            'ĐỢI XÁC NHẬN',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w700),
          ),
        ),
      );
    } else {
      return Container(
        child: ElevatedButton(
          onPressed: () {
            _showDialog(orderId);
          },
          style: ElevatedButton.styleFrom(
              primary: const Color(0xFFCF3D1F),
              padding: const EdgeInsets.symmetric(vertical: 14)),
          child: const Text(
            'HỦY',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w700),
          ),
        ),
      );
    }
  }
}

void _showDialog(String idProduct) {
  showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        title: const Text(
          "Hủy đơn hàng?",
          style: TextStyle(
              color: Color(0xFF2D0C57),
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w700,
              fontSize: 18),
        ),
        content: Container(
          height: 80,
          child: Column(
            children: const [
              Text(
                "😿",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "Bạn có chắc muốn hủy đơn hàng không?",
                style: TextStyle(
                    color: Color(0xFF2D0C57),
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
                primary: const Color(0xFF7203FF),
                padding: const EdgeInsets.symmetric(horizontal: 6)),
            child: const Text(
              'KHÔNG',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'RedHatDisplay',
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF7203FF),
              ),
              child: const Text(
                "CÓ",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              onPressed: () => _cancelorder(idProduct)),
        ],
      );
    },
  );
}

void _cancelorder(String idProduct) {
  Get.find<AuthController>().cancelOrder(idProduct);
}

void _completeorder(String idProduct) {
  Get.find<AuthController>().completeOrder(idProduct);
}

void _changetodetail(String idProduct) {
  Get.to(() => DetailProduct(idProduct));
}
