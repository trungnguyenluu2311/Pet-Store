import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/order_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Container transaction(OrderModel orderModel) {
  final formatter = new NumberFormat("#,###");
  int timeInMillis = orderModel.dateTimeOrder!;
  var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
  var formattedDate = DateFormat.yMMMd().format(date);
  Container boxDetail() {
    if (orderModel.isCancel == true) {
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
    } else if (orderModel.isCompleteAdmin == true &&
        orderModel.isCompleteUser == true) {
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
              side: const BorderSide(color: Color(0xFF471FCF))
          ),
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

  return Container(
    width: Get.width * 0.94,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFFD9D0E3))
        ),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: boxDetail(),
                ),
                Container(
                  width: Get.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Mã đơn hàng:',
                            style: TextStyle(
                              color: Color(0xFF2D0C57),
                              fontSize: 18,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          '${orderModel.dateTimeOrder}',
                          style: const TextStyle(
                            color: Color(0xFF9586A8),
                            fontSize: 16,
                            fontFamily: 'RedHatDisplay',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: Get.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Row(children: [
                      const Expanded(
                        child: Text(
                          'Ngày:',
                          style: TextStyle(
                            color: Color(0xFF2D0C57),
                            fontSize: 18,
                            fontFamily: 'RedHatDisplay',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          color: Color(0xFF9586A8),
                          fontSize: 16,
                          fontFamily: 'RedHatDisplay',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                  width: Get.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Row(children: [
                      const Expanded(
                        child: Text(
                          'Tên người nhận:',
                          style: TextStyle(
                            color: Color(0xFF2D0C57),
                            fontSize: 18,
                            fontFamily: 'RedHatDisplay',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        orderModel.nameUser,
                        style: const TextStyle(
                          color: Color(0xFF9586A8),
                          fontSize: 16,
                          fontFamily: 'RedHatDisplay',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                  width: Get.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text("Tổng tiền: ",
                              style: TextStyle(
                                color: Color(0xFF2D0C57),
                                fontSize: 18,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        Text(
                            "${formatter.format(double.parse(orderModel.totals))} vnđ",
                            style: const TextStyle(
                              color: Color(0xFF9586A8),
                              fontSize: 16,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w500,
                            )),
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
