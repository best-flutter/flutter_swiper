import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InnerSwiper(),
    );
  }
}

class InnerSwiper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InnerSwiperState();
  }
}

class _InnerSwiperState extends State<InnerSwiper> {
  late SwiperController controller;

  late List<bool> autoPlayer;

  late List<SwiperController> controllers;

  @override
  void initState() {
    controller = SwiperController();
    autoPlayer = List.generate(10, (index) => false);
    controllers = List.generate(10, (index) => SwiperController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper(
        loop: false,
        itemCount: 10,
        controller: controller,
        pagination: SwiperPagination(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              SizedBox(
                child: Swiper(
                  controller: controllers[index],
                  pagination: SwiperPagination(),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.greenAccent,
                      child: Text('jkfjkldsfjd'),
                    );
                  },
                  autoplay: autoPlayer[index],
                ),
                height: 300.0,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    autoPlayer[index] = true;
                  });
                },
                child: Text('Start autoplay'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    autoPlayer[index] = false;
                  });
                },
                child: Text('End autoplay'),
              ),
              Text('is autoplay: ${autoPlayer[index]}')
            ],
          );
        },
      ),
    );
  }
}
