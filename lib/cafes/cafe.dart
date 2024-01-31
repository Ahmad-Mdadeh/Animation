import 'package:flutter/material.dart';
import 'package:larning/cafes/utils.dart';
import 'package:larning/utils/text_utils.dart';

const _duration = Duration(
  milliseconds: 500,
);

class Cafe extends StatefulWidget {
  const Cafe({Key? key}) : super(key: key);

  @override
  State<Cafe> createState() => _CafeState();
}

class _CafeState extends State<Cafe> {
  final _pageCoffeeController = PageController(
    viewportFraction: 0.35,
  );

  double _curPage = 0.0;

  void cafeScroll() {
    setState(() {
      _curPage = _pageCoffeeController.page!;
      print(_curPage);
    });
  }

  @override
  void initState() {
    _pageCoffeeController.addListener(cafeScroll);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeeController.removeListener(cafeScroll);
    _pageCoffeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CAFE",
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: -size.height * 0.2,
            height: size.height * 0.3,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 90,
                    spreadRadius: 60,
                  )
                ],
              ),
            ),
          ),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              controller: _pageCoffeeController,
              scrollDirection: Axis.vertical,
              itemCount: coffees.length - 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox.shrink();
                }
                final coffee = coffees[index - 1];
                final result = _curPage - index + 1;
                final value = -0.4 * result + 1;
                final opacity = value.clamp(0.0, 1.0);
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20.0,
                  ),
                  child: Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(0.0, size.height / 2.6 * (1 - value).abs())
                      ..scale(value),
                    child: Opacity(
                      opacity: opacity,
                      child: Image.asset(
                        coffee.image,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 100,
            child: Column(
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: TextUtils(
                    text:
                        "\$${coffees[_curPage.toInt()].price.toStringAsFixed(2)}",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
