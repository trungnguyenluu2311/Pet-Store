import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/auth_controller.dart';
import 'package:flutter_project/controllers/utilities_controller.dart';
import 'package:flutter_project/models/order_model.dart';
import 'package:flutter_project/screens/transaction_screen.dart';
import 'package:get/get.dart';

import 'invoice_details_screen.dart';

class TranHis extends GetWidget<MyTabController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTabController>(
        builder: (controller){
          return DefaultTabController(  // Added
            length: 4,  // Added
            initialIndex: 0,
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.grey[50]),
                centerTitle: true,
                title: Text("Lịch sử mua hàng", style: TextStyle(fontSize: 30, color: Colors.grey[50])),
                backgroundColor: Color(0xFF085B6E),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.grey[50]),
                  onPressed: () {
                    controller.tabController.index = 0;
                    Get.back();
                  },
                ),
                bottom: TabBar(
                  isScrollable: true,
                  controller: controller.tabController,
                  tabs: controller.myTabs,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey[50],
                  labelStyle: TextStyle(fontSize: 16),
                  onTap: (int index) {
                    controller.tabController.index = index;
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    // sẽ thay thành hàm return về ds các đơn hàng
                    AllTransaction(),
                    WaittingTransaction(),
                    CompleteTransaction(),
                    CancelTransaction(),
                  ],
                ),
              ),
            ),
          );
        }
    );}
}

// tất cả các hóa đơn
class AllTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: GetBuilder<AuthController>(
            builder: (_) => StreamBuilder<QuerySnapshot>(
                stream: Get.find<AuthController>().fetchOrdersAll(),
                builder: (context, stream) {
                  if (stream.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (stream.hasError) {
                    return Center(child: Text(stream.error.toString()));
                  }
                  QuerySnapshot querySnapshot = stream.data!;

                  if(querySnapshot.size == 0){
                    return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("😿",style: TextStyle(fontSize: 130),),
                            Text("Không có đơn hàng nào"),
                          ],
                        )
                    );
                  }
                  else{
                    return Container(  // Added
                      child:ListView.builder(
                          itemCount: querySnapshot.size,
                          itemBuilder: (context, index) {
                            final item = querySnapshot.docs[index];
                            final OrderModel orderModel = OrderModel.fromQueryDocumentSnapshot(queryDocSnapshot: item);
                            return GestureDetector(
                              onTap:(){ Get.to(()=>InvoiceDetail(orderModel.id!));},
                              child: transaction(orderModel),
                            );
                          }
                      ),
                    );
                  }
                }
            )
        )
    );}
}

// các hóa đơn đã hoàn thành
class CompleteTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: GetBuilder<AuthController>(
            builder: (_) => StreamBuilder<QuerySnapshot>(
                stream: Get.find<AuthController>().fetchOrdersComplete(),
                builder: (context, stream) {
                  if (stream.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (stream.hasError) {
                    return Center(child: Text(stream.error.toString()));
                  }
                  QuerySnapshot querySnapshot = stream.data!;

                  if(querySnapshot.size == 0){
                    return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("😿",style: TextStyle(fontSize: 130),),
                            Text("Không có đơn hàng nào"),
                          ],
                        )
                    );
                  }
                  else{
                    return Container(  // Added
                      child:ListView.builder(
                          itemCount: querySnapshot.size,
                          itemBuilder: (context, index) {
                            final item = querySnapshot.docs[index];
                            final OrderModel orderModel = OrderModel.fromQueryDocumentSnapshot(queryDocSnapshot: item);
                            return GestureDetector(
                              onTap:(){ Get.to(()=>InvoiceDetail(orderModel.id!));},
                              child: transaction(orderModel),
                            );
                          }
                      ),
                    );
                  }
                }
            )
        )
    );}
}
// các hóa đơn bị hủy

class CancelTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: GetBuilder<AuthController>(
            builder: (_) => StreamBuilder<QuerySnapshot>(
                stream: Get.find<AuthController>().fetchOrdersCancel(),
                builder: (context, stream) {
                  if (stream.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (stream.hasError) {
                    return Center(child: Text(stream.error.toString()));
                  }
                  QuerySnapshot querySnapshot = stream.data!;

                  if(querySnapshot.size == 0){
                    return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("😿",style: TextStyle(fontSize: 130),),
                            Text("Không có đơn hàng nào"),
                          ],
                        )
                    );
                  }
                  else{
                    return Container(  // Added
                      child:ListView.builder(
                          itemCount: querySnapshot.size,
                          itemBuilder: (context, index) {
                            final item = querySnapshot.docs[index];
                            final OrderModel orderModel = OrderModel.fromQueryDocumentSnapshot(queryDocSnapshot: item);
                            return GestureDetector(
                              onTap:(){ Get.to(()=>InvoiceDetail(orderModel.id!));},
                              child: transaction(orderModel),
                            );
                          }
                      ),
                    );
                  }
                }
            )
        )
    );}
}

// các hóa đơn đang chờ
class WaittingTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: GetBuilder<AuthController>(
            builder: (_) => StreamBuilder<QuerySnapshot>(
                stream: Get.find<AuthController>().fetchOrdersWaitting(),
                builder: (context, stream) {
                  if (stream.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (stream.hasError) {
                    return Center(child: Text(stream.error.toString()));
                  }
                  QuerySnapshot querySnapshot = stream.data!;

                  if(querySnapshot.size == 0){
                    return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("😿",style: TextStyle(fontSize: 130),),
                            Text("Không có đơn hàng nào"),
                          ],
                        )
                    );
                  }
                  else{
                    return Container(  // Added
                      child:ListView.builder(
                          itemCount: querySnapshot.size,
                          itemBuilder: (context, index) {
                            final item = querySnapshot.docs[index];
                            final OrderModel orderModel = OrderModel.fromQueryDocumentSnapshot(queryDocSnapshot: item);
                            return GestureDetector(
                              onTap:(){ Get.to(()=>InvoiceDetail(orderModel.id!));},
                              child: transaction(orderModel),
                            );
                          }
                      ),
                    );
                  }
                }
            )
        )
    );}
}

