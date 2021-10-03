import 'package:flutter/material.dart';

import 'detail_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sản phẩm',
                style: TextStyle(
                    color: Color(0xFF2D0C57),
                    fontSize: 34,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 36),
              const TextField(
                style: TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
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
              ),
              const SizedBox(height: 36),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: const BoxDecoration(
                        color: Color(0xFFE2CBFF),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: RichText(
                      text: const TextSpan(
                          text: 'Thức ăn',
                          style: TextStyle(
                              color: Color(0xFF6C0EE4),
                              fontSize: 14,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w500),
                          children: [TextSpan(text: ' (4)')]),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFD9D0E3),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: RichText(
                      text: const TextSpan(
                          text: 'Thuốc',
                          style: TextStyle(
                              color: Color(0xFF9586A8),
                              fontSize: 14,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w500),
                          children: [TextSpan(text: ' (5)')]),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFD9D0E3),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: RichText(
                      text: const TextSpan(
                          text: 'Đồ chơi',
                          style: TextStyle(
                              color: Color(0xFF9586A8),
                              fontSize: 14,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w500),
                          children: [TextSpan(text: ' (6)')]),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 36),
              Column(
                children: const [
                  ItemCard(),
                  ItemCard(),
                  ItemCard(),
                  ItemCard(),
                  ItemCard(),
                  ItemCard(),
                  ItemCard(),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const DetailProduct()));
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          color: const Color(0xFFFAF9FE),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const Image(
                      fit: BoxFit.cover,
                      height: 132,
                      width: 174,
                      image: AssetImage('assets/owl.jpg'))),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lorem Ipsum',
                    style: TextStyle(
                        color: Color(0xFF2D0C57),
                        fontFamily: 'RedHatDisplay',
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: const TextSpan(
                        text: '100.000',
                        style: TextStyle(
                            color: Color(0xFF2D0C57),
                            fontFamily: 'RedHatDisplay',
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                        children: [
                          TextSpan(
                              text: ' đ/cái',
                              style: TextStyle(
                                  color: Color(0xFF9586A8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400))
                        ]),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 176,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            primary: const Color(0xFF0BCE83)),
                        child: const Icon(Icons.shopping_cart_outlined)),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
