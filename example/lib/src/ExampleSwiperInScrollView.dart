import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ExampleSwiperInScrollView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ExampleState();
  }
}

class _ExampleState extends State<ExampleSwiperInScrollView>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> _animation10;
  Animation<double> _animation11;
  Animation<double> _animation12;
  Animation<double> _animation13;

  _ExampleState();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    controller = new AnimationController(vsync: this);
    _animation10 = new Tween(begin: 0.0, end: 1.0).animate(controller);
    _animation11 = new Tween(begin: 0.0, end: 1.0).animate(controller);
    _animation12 = new Tween(begin: 0.0, end: 1.0).animate(controller);
    _animation13 = new Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.animateTo(1.0, duration: new Duration(seconds: 3));
    super.initState();
  }

  Widget _buildDynamicCard() {
    return new Card(
      elevation: 2.0,
      color: Colors.white,
      child: new Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
              ),
            ],
          ),
          new Column(
            children: <Widget>[
              new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 40.0),
                        ),
                        new ScaleTransition(
                          scale: _animation10,
                          alignment: FractionalOffset.center,
                        ),
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 160.0),
                        ),
                        new ScaleTransition(
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
                        new ScaleTransition(
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
                        new ScaleTransition(
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
    double screenWidth = MediaQuery.of(context).size.width;
    return new Container(
      color: Theme.of(context).primaryColorLight,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: new SliverChildBuilderDelegate((c, i) {
            return new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new SizedBox(
                  height: 100.0,
                  child: Swiper(
                    itemBuilder: (c, i) {
                      return Container(
                        color: Colors.grey,
                        child: Text("$i"),
                      );
                    },
                    itemCount: 10,
                    pagination: new SwiperPagination(),
                  ),
                ),
                new SizedBox(
                  height: 100.0,
                  child: Swiper(
                      itemBuilder: (c, i) {
                        return Container(
                          color: Colors.grey,
                          child: Text("$i"),
                        );
                      },
                      pagination: new SwiperPagination(
                          builder: SwiperPagination.fraction),
                      itemCount: 10000),
                ),
                new SizedBox(
                  height: 100.0,
                  child: Swiper(
                      outer: true,
                      itemBuilder: (c, i) {
                        return new Container(
                          color: Colors.grey,
                          child: Text("$i"),
                        );
                      },
                      pagination: SwiperPagination(),
                      itemCount: 10),
                ),
                new SizedBox(
                  height: 100.0,
                  child: new Swiper(
                      outer: true,
                      itemBuilder: (c, i) {
                        return new Card(
                          elevation: 2.0,
                          child: new Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              new Container(
                                child: new Image.network(
                                    "https://ss3.baidu.com/9fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=87d6daed02f41bd5c553eef461d881a0/f9198618367adab4b025268587d4b31c8601e47b.jpg"),
                              ),
                              FractionalTranslation(
                                translation: Offset(0.0, 0.0),
                                child: new Container(
                                  alignment: new FractionalOffset(0.0, 0.0),
                                  decoration: new BoxDecoration(
                                    border: new Border.all(
                                      color: Colors.lightBlue.withOpacity(0.5),
                                      width: 100.0,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              new Container(
                                //padding: const EdgeInsets.only(bottom:10.0),
                                margin: new EdgeInsets.all(140.0),

                                child: Icon(Icons.location_on,
                                    color: Colors.white, size: 25.0),
                              ),
                            ],
                          ),
                        );
                      },
                      pagination:
                          new SwiperPagination(alignment: Alignment.topCenter),
                      itemCount: 10),
                ),
                new SizedBox(
                  height: 400.0,
                  child: new Swiper(
                      outer: true,
                      itemBuilder: (c, i) {
                        return _buildDynamicCard();
                      },
                      pagination:
                          new SwiperPagination(alignment: Alignment.topCenter),
                      itemCount: 10),
                ),
                new SizedBox(
                  height: 100.0,
                  child: new Swiper(
                      outer: true,
                      itemBuilder: (c, i) {
                        return Container(
                          color: Colors.grey,
                          child: Text("$i"),
                        );
                      },
                      pagination:
                          new SwiperPagination(alignment: Alignment.topCenter),
                      itemCount: 10),
                ),
                new SizedBox(
                  height: 100.0,
                  child: new Swiper(
                      outer: true,
                      itemBuilder: (c, i) {
                        return Container(
                          color: Colors.grey,
                          child: Text("$i"),
                        );
                      },
                      pagination:
                          new SwiperPagination(alignment: Alignment.topCenter),
                      itemCount: 10),
                ),
                new Swiper(
                  containerHeight: 100.0,
                  outer: true,
                  itemBuilder: (c, i) {
                    return Container(
                      color: Colors.grey,
                      child: Text("$i"),
                    );
                  },
                  pagination: new SwiperPagination(),
                  itemCount: 10,
                ),
                new ConstrainedBox(
                    child: new Swiper(
                      outer: false,
                      itemBuilder: (c, i) {
                        return new Wrap(
                          runSpacing: 6.0,
                          children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) {
                            return new SizedBox(
                              width: MediaQuery.of(context).size.width / 5,
                              child: new Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new SizedBox(
                                    child: new Container(
                                      child: new Image.network(
                                          "https://fuss10.elemecdn.com/c/db/d20d49e5029281b9b73db1c5ec6f9jpeg.jpeg%3FimageMogr/format/webp/thumbnail/!90x90r/gravity/Center/crop/90x90"),
                                    ),
                                    height: MediaQuery.of(context).size.width *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.12,
                                  ),
                                  new Padding(
                                    padding: new EdgeInsets.only(top: 6.0),
                                    child: new Text("$i"),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                      pagination:
                          new SwiperPagination(margin: new EdgeInsets.all(5.0)),
                      itemCount: 10,
                    ),
                    constraints:
                        new BoxConstraints.loose(new Size(screenWidth, 170.0))),
                new SizedBox(
                  height: 100.0,
                  child: new Swiper(
                    itemBuilder: (c, i) {
                      return Container(
                        color: Colors.grey,
                        child: Text("$i"),
                      );
                    },
                    pagination: new SwiperPagination(),
                    itemCount: 10,
                  ),
                ),
              ],
            );
          }, childCount: 1))
        ],
      ),
    );
  }
}
