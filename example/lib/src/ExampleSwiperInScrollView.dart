import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ExampleSwiperInScrollView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExampleState();
  }
}

class _ExampleState extends State<ExampleSwiperInScrollView>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _animation10;
  late Animation<double> _animation11;
  late Animation<double> _animation12;
  late Animation<double> _animation13;

  _ExampleState();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    _animation10 = Tween(begin: 0.0, end: 1.0).animate(controller);
    _animation11 = Tween(begin: 0.0, end: 1.0).animate(controller);
    _animation12 = Tween(begin: 0.0, end: 1.0).animate(controller);
    _animation13 = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.animateTo(1.0, duration: Duration(seconds: 3));
    super.initState();
  }

  Widget _buildDynamicCard() {
    return Card(
      elevation: 2.0,
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 40.0),
                        ),
                        ScaleTransition(
                          scale: _animation10,
                          alignment: FractionalOffset.center,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 160.0),
                        ),
                        ScaleTransition(
                          scale: _animation11,
                          alignment: FractionalOffset.center,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(1.0),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 160.0),
                        ),
                        ScaleTransition(
                          scale: _animation12,
                          alignment: FractionalOffset.center,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 40.0),
                        ),
                        ScaleTransition(
                          scale: _animation13,
                          alignment: FractionalOffset.center,
                        ),
                      ],
                    ),
                  ]),
              Container(
                padding: const EdgeInsets.all(10.0),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorLight,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildBuilderDelegate((c, i) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                  child: Swiper(
                    scale: 0.8,
                    fade: 0.8,
                    itemBuilder: (c, i) {
                      return Container(
                        color: Colors.grey,
                        child: Text('$i'),
                      );
                    },
                    itemCount: 10,
                    pagination: SwiperPagination(),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                  child: Swiper(
                      scale: 0.8,
                      fade: 0.8,
                      itemBuilder: (c, i) {
                        return Container(
                          color: Colors.grey,
                          child: Text('$i'),
                        );
                      },
                      pagination:
                          SwiperPagination(builder: SwiperPagination.fraction),
                      itemCount: 0),
                ),
                SizedBox(
                  height: 100.0,
                  child: Swiper(
                      scale: 0.8,
                      fade: 0.8,
                      itemBuilder: (c, i) {
                        return Container(
                          color: Colors.grey,
                          child: Text('$i'),
                        );
                      },
                      pagination:
                          SwiperPagination(builder: SwiperPagination.fraction),
                      itemCount: 10000),
                ),
                SizedBox(
                  height: 100.0,
                  child: Swiper(
                      outer: true,
                      scale: 0.8,
                      fade: 0.8,
                      itemBuilder: (c, i) {
                        return Container(
                          color: Colors.grey,
                          child: Text('$i'),
                        );
                      },
                      pagination: SwiperPagination(),
                      itemCount: 10),
                ),
                Text('Image from network'),
                SizedBox(
                  height: 300.0,
                  child: Swiper(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                          'https://ss3.baidu.com/9fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=87d6daed02f41bd5c553eef461d881a0/f9198618367adab4b025268587d4b31c8601e47b.jpg');
                    },
                  ),
                ),
                SizedBox(
                  height: 100.0,
                  child: Swiper(
                      outer: true,
                      scale: 0.8,
                      fade: 0.8,
                      itemBuilder: (c, i) {
                        return Card(
                          elevation: 2.0,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Container(
                                child: Image.network(
                                    'https://ss3.baidu.com/9fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=87d6daed02f41bd5c553eef461d881a0/f9198618367adab4b025268587d4b31c8601e47b.jpg'),
                              ),
                              FractionalTranslation(
                                translation: Offset(0.0, 0.0),
                                child: Container(
                                  alignment: FractionalOffset(0.0, 0.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.lightBlue.withOpacity(0.5),
                                      width: 100.0,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Container(
                                //padding: const EdgeInsets.only(bottom:10.0),
                                margin: EdgeInsets.all(140.0),

                                child: Icon(Icons.location_on,
                                    color: Colors.white, size: 25.0),
                              ),
                            ],
                          ),
                        );
                      },
                      pagination:
                          SwiperPagination(alignment: Alignment.topCenter),
                      itemCount: 10),
                ),
                SizedBox(
                  height: 400.0,
                  child: Swiper(
                      outer: true,
                      itemBuilder: (c, i) {
                        return _buildDynamicCard();
                      },
                      pagination:
                          SwiperPagination(alignment: Alignment.topCenter),
                      itemCount: 10),
                ),
                SizedBox(
                  height: 100.0,
                  child: Swiper(
                      outer: true,
                      fade: 0.8,
                      viewportFraction: 0.8,
                      scale: 0.8,
                      itemBuilder: (c, i) {
                        return Container(
                          color: Colors.grey,
                          child: Text('$i'),
                        );
                      },
                      pagination:
                          SwiperPagination(alignment: Alignment.topCenter),
                      itemCount: 10),
                ),
              ],
            );
          }, childCount: 1))
        ],
      ),
    );
  }
}
