import 'package:flutter/material.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({Key? key}) : super(key: key);

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                // ClipRRect(
                //   child: Image.asset('assets/owl.jpg'),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/owl.jpg'),
                  ],
                ),
                Column(children: [
                  const Expanded(child: SizedBox(), flex: 1),
                  Expanded(
                    flex: 2,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 36, horizontal: 24),
                        decoration: const BoxDecoration(
                            color: Color(0xFFF6F5F5),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Lorem Ipsum',
                              style: TextStyle(
                                  color: Color(0xFF2D0C57),
                                  fontFamily: 'RedHatDisplay',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 12),
                            RichText(
                                text: const TextSpan(
                                    text: '100.000',
                                    style: TextStyle(
                                        color: Color(0xFF2D0C57),
                                        fontSize: 32,
                                        fontFamily: 'RedHatDisplay',
                                        fontWeight: FontWeight.w700),
                                    children: [
                                  TextSpan(
                                      text: ' đ / cái',
                                      style: TextStyle(
                                          color: Color(0xFF9586A8),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400))
                                ])),
                            const SizedBox(height: 60),
                            Expanded(
                              child: PageView(
                                pageSnapping: true,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Thông tin sản phẩm',
                                        style: TextStyle(
                                            color: Color(0xFF2D0C57),
                                            fontSize: 22,
                                            fontFamily: 'RedHatDisplay',
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 24),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum varius nec libero ut cursus. Donec hendrerit ornare sodales. Mauris orci dui, faucibus sit amet nunc id, sollicitudin scelerisque urna. Aliquam rutrum ante a nibh vehicula, a semper elit tristique. Aenean eu est pharetra nunc commodo fermentum id nec sapien. Pellentesque.',
                                            style: TextStyle(
                                                color: Color(0xFF9586A8),
                                                fontSize: 18,
                                                fontFamily: 'RedHatDisplay',
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Thành phần sản phẩm',
                                        style: TextStyle(
                                            color: Color(0xFF2D0C57),
                                            fontSize: 22,
                                            fontFamily: 'RedHatDisplay',
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 24),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum varius nec libero ut cursus. Donec hendrerit ornare sodales. Mauris orci dui, faucibus sit amet nunc id, sollicitudin scelerisque urna. Aliquam rutrum ante a nibh vehicula, a semper elit tristique. Aenean eu est pharetra nunc commodo fermentum id nec sapien. Pellentesque.',
                                            style: TextStyle(
                                                color: Color(0xFF9586A8),
                                                fontFamily: 'RedHatDisplay',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            '10 nhận xét',
                                            style: TextStyle(
                                                color: Color(0xFF2D0C57),
                                                fontFamily: 'RedHatDisplay',
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            'Đánh giá trung bình: 4.5',
                                            style: TextStyle(
                                                color: Color(0xFF2D0C57),
                                                fontFamily: 'RedHatDisplay',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'Nhận xét gần nhất',
                                                style: TextStyle(
                                                    color: Color(0xFF9586A8),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Tuyệt vời',
                                                style: TextStyle(
                                                    color: Color(0xFF2D0C57),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Luke Skywalker',
                                                style: TextStyle(
                                                    color: Color(0xFF2D0C57),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                          ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                  primary:
                                                      const Color(0xFFFBEAFF)),
                                              child: const Text(
                                                'Xem tất cả',
                                                style: TextStyle(
                                                    color: Color(0xFF2D0C57),
                                                    fontFamily: 'RedHatDisplay',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 60),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Color(0xFF9586A8)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        primary: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                      ),
                                      onPressed: () {},
                                      child: const Icon(
                                        Icons.favorite_outline,
                                        color: Color(0xFF9586A8),
                                        size: 24,
                                      )),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 3,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          primary: const Color(0xFF0BCE83),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12)),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.shopping_cart_outlined,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            'THÊM VÀO GIỎ HÀNG',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            )
                          ],
                        )),
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
