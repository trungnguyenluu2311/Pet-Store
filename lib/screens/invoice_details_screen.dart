import 'package:cloud_firestore/cloud_firestore.dart';
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
    return Container(
        child: GetBuilder<AuthController>(
            builder: (_) => StreamBuilder<DocumentSnapshot>(
                stream: Get.find<AuthController>().fetchOrder(orderId),
                builder: (context, stream) {
                  if (stream.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
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
                      iconTheme: IconThemeData(color: Colors.grey[50]),
                      centerTitle: true,
                      backgroundColor: Color(0xFF085B6E),
                    ),
                    body: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
                        child: Container(
                            color: Colors.grey[50],
                            width: Get.width,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Thông tin đơn hàng',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(color: Colors.grey)
                                        ]),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          boxDetail(),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Mã đơn hàng:',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${order.dateTimeOrder}',
                                                style: TextStyle(fontSize: 16),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Ngày:',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '$formattedDate',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Row(children: [
                                            Expanded(
                                              child: Text(
                                                'Tên người nhận:',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${order.nameUser}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ]),
                                          Row(children: [
                                            Expanded(
                                              child: Text(
                                                'Tổng tiền:',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "${formatter.format(double.parse(order.totals))} vnđ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ]),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    'Địa chỉ người nhận',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(color: Colors.grey)
                                        ]),
                                    child: Text(
                                      '${order.addressUser}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    'Phương thức vận chuyển',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(color: Colors.grey)
                                        ]),
                                    child: Text(
                                      '${order.shippingMethod}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    'Phương thức thanh toán',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(color: Colors.grey)
                                        ]),
                                    child: Text(
                                      '${order.paymentMethod}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    'Thông tin sản phẩm',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                      child: GetBuilder<AuthController>(
                                          builder: (_) => StreamBuilder<
                                                  QuerySnapshot>(
                                              stream: Get.find<AuthController>()
                                                  .fetchProductsFromOrder(
                                                      orderId),
                                              builder: (context, stream) {
                                                if (stream.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
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
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 0, 0),
                                                  color: Colors.white,
                                                  child: ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          querySnapshot.size,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final item =
                                                            querySnapshot
                                                                .docs[index];
                                                        final Product product =
                                                            Product.fromQueryDocumentSnapshot(
                                                                queryDocSnapshot:
                                                                    item);
                                                        return productinorder(
                                                            product);
                                                      }),
                                                );
                                              }))),
                                ]))),
                    bottomNavigationBar: Container(
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.grey)]),
                      child: BottomAppBar(
                          color: Color(0xFF085B6E), child: ButtonCustom()),
                    ),
                  );
                })));
  }

  //
  Container boxDetail() {
    if (order.isCancel == true) {
      return Container(
        // color: Colors.green,
        width: 80.0,
        height: 20.0,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Color(0xFF9E331B))),
          color: Color(0xFF9E331B),
        ),
        child: Text(
          "Bị hủy",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      );
    } else if (order.isCompleteAdmin == true && order.isCompleteUser == true) {
      return Container(
        width: 80.0,
        height: 20.0,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Color(0xFF026E46))),
          color: Color(0xFF026E46),
        ),
        child: Text(
          "Hoàn thành",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return Container(
        // color: Colors.green,
        width: 80.0,
        height: 20.0,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Color(0xFF0D296E))),
          color: Color(0xFF0D296E),
        ),
        child: Text(
          "Đang đợi",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  //
  Container ButtonCustom() {
    if (order.isShipping == true && order.isCompleteUser == false) {
      return Container(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: ElevatedButton(
          onPressed: () {
            _completeorder(orderId);
          },
          style: ElevatedButton.styleFrom(primary: Color(0xFF026E46)),
          child: Text(
            'Đã nhận được hàng',
            style: TextStyle(color: Colors.grey[50], fontSize: 20),
          ),
        ),
      );
    } else if (order.isCompleteAdmin == true && order.isCompleteUser == true) {
      return Container(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(primary: Color(0xFF011F14)),
          child: Text(
            'Đã hoàn thành',
            style: TextStyle(color: Colors.grey[50], fontSize: 20),
          ),
        ),
      );
    }else if (order.isCancel == true) {
      return Container(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(primary: Color(0xFF210B06)),
          child: Text(
            'Bị hủy',
            style: TextStyle(color: Colors.grey[50], fontSize: 20),
          ),
        ),
      );
    } else if (order.isShipping == true) {
      return Container(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(primary: Color(0xFF210B06)),
          child: Text(
            'Đợi xác nhận',
            style: TextStyle(color: Colors.grey[50], fontSize: 20),
          ),
        ),
      );
    }else {
      return Container(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: ElevatedButton(
          onPressed: () {
            _showDialog(orderId);
          },
          style: ElevatedButton.styleFrom(primary: Color(0xFF9E331B)),
          child: Text(
            'Hủy',
            style: TextStyle(color: Colors.grey[50], fontSize: 20),
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Text(
          "Hủy đơn hàng?",
          style: TextStyle(color: Colors.black),
        ),
        content: Container(
          height: 80,
          child: Column(
            children: [
              Text("😿",style: TextStyle(fontSize: 30),),
              Text(
                "Bạn có chắc muốn hủy đơn hàng không",
                style: TextStyle(color: Colors.black,fontSize: 18),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(primary: Color(0xFF085B6E)),
            child: Text(
              'Không',
              style: TextStyle(color: Colors.grey[50]),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Color(0xFF085B6E)),
            child: new Text(
              "Có",
              style: TextStyle(color: Colors.grey[50]),
            ),
            onPressed: () => _cancelorder(idProduct)
          ),
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
  Get.to(()=>DetailProduct(idProduct));
}

GestureDetector productinorder(Product product) {
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
                    width: Get.width * 0.4,
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
                      width: Get.width * 0.4,
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
                      width: Get.width * 0.4,
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
