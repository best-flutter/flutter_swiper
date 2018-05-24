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

  Widget _buildItem(BuildContext context, int index) {
    return new Image.asset(
      images[index % images.length],
      fit: BoxFit.fill,
    );
  }

  @override
  void initState() {
    _loop = true;
    _itemCount = 3;
    _autoplay = false;
    _autoplayDely = 3000;
    _axis = Axis.horizontal;
    super.initState();
  }

  Widget buildSwiper() {
    return new Swiper(
      autoplayDely: _autoplayDely,
      loop: _loop,
      autoplay: _autoplay,
      itemBuilder: _buildItem,
      itemCount: _itemCount,
      scrollDirection: _axis,
      pagination: new SwiperPagination(),
      control: new SwiperControl(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new SizedBox(height: 200.0, child: buildSwiper()),

      //Pannel Begin
      new FormWidget(
        label: "loop",
        child: new Switch(
            value: _loop,
            onChanged: (bool value) => setState(() => _loop = value)),
      ),

      //Pannel Begin
      new FormWidget(
        label: "autoplay",
        child: new Switch(
            value: _autoplay,
            onChanged: (bool value) => setState(() => _autoplay = value)),
      ),

      new FormWidget(
        label: "itemCount",
        child: new NumberPad(
          number: _itemCount,
          onAdd: () => setState(() => _itemCount++),
          onSub: () => setState(
              () => _itemCount = (_itemCount - 1 < 0 ? 0 : _itemCount - 1)),
        ),
      ),
      /*
      not support dynamic change yet , is it a Flutter bug ?

      new FormWidget(
        label: "scrollDirection",
        child: new Switch(
            value: _axis == Axis.horizontal,
            onChanged: (bool value) => setState(() => _axis=value ? Axis.horizontal : Axis.vertical )),
      ),
      */
    ]);
  }
}
