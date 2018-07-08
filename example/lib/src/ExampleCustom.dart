import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'config.dart';
import 'forms/form_widget.dart';

class ExampleCustom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ExampleCustomState();
  }
}

class _ExampleCustomState extends State<ExampleCustom> {
  //properties whant to custom

  int _itemCount;

  bool _loop;

  bool _autoplay;

  int _autoplayDely;

  Axis _axis;

  double _padding;

  bool _outer;

  double _radius;

  double _viewportFraction;

  SwiperLayout _layout;

  int _currentIndex;

  double _scale;

  Curve _curve;

  Widget _buildItem(BuildContext context, int index) {
    return ClipRRect(
      borderRadius: new BorderRadius.all(new Radius.circular(_radius)),
      child: new Image.asset(
        images[index % images.length],
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  void initState() {
    _currentIndex = 0;
    _curve = Curves.ease;
    _scale = 0.8;
    _controller = new SwiperController();
    _layout = SwiperLayout.TINDER;
    _radius = 10.0;
    _padding = 0.0;
    _loop = true;
    _itemCount = 3;
    _autoplay = false;
    _autoplayDely = 3000;
    _axis = Axis.horizontal;
    _viewportFraction = 0.8;
    _outer = false;
    super.initState();
  }

// maintain the index

  Widget buildSwiper() {
    Navigator;
    return new Swiper(
      onTap: (int index) {
//        Navigator
//            .of(context)
//            .push(new MaterialPageRoute(builder: (BuildContext context) {
//          return Scaffold(
//            appBar: AppBar(
//              title: Text("New page"),
//            ),
//            body: Container(),
//          );
//        }));
      },
      index: _currentIndex,
      onIndexChanged: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      curve: _curve,
      scale: _scale,
      itemWidth: 300.0,
      controller: _controller,
      layout: _layout,
      outer: _outer,
      itemHeight: 200.0,
      viewportFraction: _viewportFraction,
      autoplayDely: _autoplayDely,
      loop: _loop,
      autoplay: _autoplay,
      itemBuilder: _buildItem,
      itemCount: _itemCount,
      scrollDirection: _axis,
      pagination: new SwiperPagination(),
    );
  }

  SwiperController _controller;

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new Container(
        color: Colors.black87,
        child: new SizedBox(
            height: 300.0, width: double.infinity, child: buildSwiper()),
      ),
      new Expanded(
          child: new ListView(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new RaisedButton(
                onPressed: () {
                  _controller.previous(animation: true);
                },
                child: new Text("Prev"),
              ),
              new RaisedButton(
                onPressed: () {
                  _controller.next(animation: true);
                },
                child: new Text("Next"),
              ),
              new Text("Index:$_currentIndex")
            ],
          ),
          new FormWidget(
              label: "layout",
              child: new FormSelect(
                  placeholder: "Select layout",
                  value: _layout,
                  values: [
                    SwiperLayout.DEFAULT,
                    SwiperLayout.STACK,
                    SwiperLayout.TINDER
                  ],
                  valueChanged: (value) {
                    _layout = value;
                    setState(() {});
                  })),
          //Pannel Begin
          new FormWidget(
            label: "loop",
            child: new Switch(
                value: _loop,
                onChanged: (bool value) => setState(() => _loop = value)),
          ),
          new FormWidget(
            label: "outer",
            child: new Switch(
                value: _outer,
                onChanged: (bool value) => setState(() => _outer = value)),
          ),
          //Pannel Begin
          new FormWidget(
            label: "autoplay",
            child: new Switch(
                value: _autoplay,
                onChanged: (bool value) => setState(() => _autoplay = value)),
          ),

          new FormWidget(
            label: "padding",
            child: new NumberPad(
              number: _padding,
              step: 5.0,
              min: 0.0,
              max: 30.0,
              onChangeValue: (num value) {
                _padding = value.toDouble();
                setState(() {});
              },
            ),
          ),
          new FormWidget(
            label: "scale",
            child: new NumberPad(
              number: _scale,
              step: 0.1,
              min: 0.0,
              max: 1.0,
              onChangeValue: (num value) {
                _scale = value.toDouble();
                setState(() {});
              },
            ),
          ),
          new FormWidget(
            label: "itemCount",
            child: new NumberPad(
              number: _itemCount,
              step: 1,
              min: 0,
              max: 100,
              onChangeValue: (num value) {
                _itemCount = value.toInt();
                setState(() {});
              },
            ),
          ),

          new FormWidget(
            label: "radius",
            child: new NumberPad(
              number: _radius,
              step: 1.0,
              min: 0.0,
              max: 30.0,
              onChangeValue: (num value) {
                this._radius = value.toDouble();
                setState(() {});
              },
            ),
          ),

          new FormWidget(
            label: "viewportFraction",
            child: new NumberPad(
              number: _viewportFraction,
              step: 0.1,
              max: 1.0,
              min: 0.5,
              onChangeValue: (num value) {
                _viewportFraction = value.toDouble();
                setState(() {});
              },
            ),
          ),

          new FormWidget(
              label: "curve",
              child: new FormSelect(
                  placeholder: "Select curve",
                  value: _layout,
                  values: [
                    Curves.easeInOut,
                    Curves.ease,
                    Curves.bounceInOut,
                    Curves.bounceOut,
                    Curves.bounceIn,
                    Curves.fastOutSlowIn
                  ],
                  valueChanged: (value) {
                    _curve = value;
                    setState(() {});
                  })),
        ],
      ))
    ]);
  }
}
