import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'config.dart';
import 'forms/form_widget.dart';

class ExampleCustom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExampleCustomState();
  }
}

class _ExampleCustomState extends State<ExampleCustom> {
  //properties want to custom
  late int _itemCount;

  late bool _loop;

  late bool _autoplay;

  late int _autoplayDelay;

  late double _padding;

  late bool _outer;

  late double _radius;

  late double _viewportFraction;

  late SwiperLayout _layout;

  late int _currentIndex;

  late double _scale;

  late Axis _scrollDirection;

  late Curve _curve;

  late double _fade;

  late bool _autoplayDisableOnInteraction;

  late CustomLayoutOption customLayoutOption;

  late SwiperController _controller;

  TextEditingController numberController = TextEditingController();

  Widget _buildItem(BuildContext context, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(_radius)),
      child: Image.asset(
        images[index % images.length],
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  void didUpdateWidget(ExampleCustom oldWidget) {
    customLayoutOption = CustomLayoutOption(startIndex: -1, stateCount: 3)
        .addRotate([-45.0 / 180, 0.0, 45.0 / 180]).addTranslate(
            [Offset(-370.0, -40.0), Offset(0.0, 0.0), Offset(370.0, -40.0)]);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    customLayoutOption = CustomLayoutOption(startIndex: -1, stateCount: 3)
        .addRotate([-25.0 / 180, 0.0, 25.0 / 180]).addTranslate(
            [Offset(-350.0, 0.0), Offset(0.0, 0.0), Offset(350.0, 0.0)]);
    _fade = 1.0;
    _currentIndex = 0;
    _curve = Curves.ease;
    _scale = 0.8;
    _controller = SwiperController();
    _layout = SwiperLayout.TINDER;
    _radius = 10.0;
    _padding = 0.0;
    _loop = true;
    _itemCount = 3;
    _autoplay = false;
    _autoplayDelay = 3000;
    _viewportFraction = 0.8;
    _outer = false;
    _scrollDirection = Axis.horizontal;
    _autoplayDisableOnInteraction = false;
    super.initState();
  }

// maintain the index

  Widget buildSwiper() {
    return Swiper(
      onTap: (int index) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('New page'),
            ),
            body: Container(),
          );
        }));
      },
      customLayoutOption: customLayoutOption,
      fade: _fade,
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
      autoplayDelay: _autoplayDelay,
      loop: _loop,
      autoplay: _autoplay,
      itemBuilder: _buildItem,
      itemCount: _itemCount,
      scrollDirection: _scrollDirection,
      indicatorLayout: PageIndicatorLayout.COLOR,
      autoplayDisableOnInteraction: _autoplayDisableOnInteraction,
      pagination: SwiperPagination(
          builder: const DotSwiperPaginationBuilder(
              size: 20.0, activeSize: 20.0, space: 10.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        color: Colors.black87,
        child: SizedBox(
            height: 300.0, width: double.infinity, child: buildSwiper()),
      ),
      Expanded(
          child: ListView(
        children: <Widget>[
          Text('Index:$_currentIndex'),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _controller.previous(animation: true);
                },
                child: Text('Prev'),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.next(animation: true);
                },
                child: Text('Next'),
              ),
              Expanded(
                  child: TextField(
                controller: numberController,
              )),
              ElevatedButton(
                onPressed: () {
                  var text = numberController.text;
                  setState(() {
                    _currentIndex = int.parse(text);
                  });
                },
                child: Text('Update'),
              ),
            ],
          ),
          FormWidget(
            label: 'layout',
            child: FormSelect(
              placeholder: 'Select layout',
              value: _layout,
              values: [
                SwiperLayout.DEFAULT,
                SwiperLayout.STACK,
                SwiperLayout.TINDER,
                SwiperLayout.CUSTOM
              ],
              valueChanged: (SwiperLayout value) {
                _layout = value;
                setState(() {});
              },
            ),
          ),
          FormWidget(
            label: 'scrollDirection',
            child: Switch(
                value: _scrollDirection == Axis.horizontal,
                onChanged: (bool value) => setState(() => _scrollDirection =
                    value ? Axis.horizontal : Axis.vertical)),
          ),
          FormWidget(
            label: 'autoplayDisableOnInteraction',
            child: Switch(
                value: _autoplayDisableOnInteraction,
                onChanged: (bool value) =>
                    setState(() => _autoplayDisableOnInteraction = value)),
          ),
          //Pannel Begin
          FormWidget(
            label: 'loop',
            child: Switch(
                value: _loop,
                onChanged: (bool value) => setState(() => _loop = value)),
          ),
          FormWidget(
            label: 'outer',
            child: Switch(
                value: _outer,
                onChanged: (bool value) => setState(() => _outer = value)),
          ),
          //Pannel Begin
          FormWidget(
            label: 'autoplay',
            child: Switch(
                value: _autoplay,
                onChanged: (bool value) => setState(() => _autoplay = value)),
          ),

          FormWidget(
            label: 'padding',
            child: NumberPad(
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
          FormWidget(
            label: 'scale',
            child: NumberPad(
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
          FormWidget(
            label: 'fade',
            child: NumberPad(
              number: _fade,
              step: 0.1,
              min: 0.0,
              max: 1.0,
              onChangeValue: (num value) {
                _fade = value.toDouble();
                setState(() {});
              },
            ),
          ),
          FormWidget(
            label: 'itemCount',
            child: NumberPad(
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

          FormWidget(
            label: 'radius',
            child: NumberPad(
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

          FormWidget(
            label: 'viewportFraction',
            child: NumberPad(
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

          FormWidget(
            label: 'curve',
            child: FormSelect(
              placeholder: 'Select curve',
              value: _layout,
              values: [
                Curves.easeInOut,
                Curves.ease,
                Curves.bounceInOut,
                Curves.bounceOut,
                Curves.bounceIn,
                Curves.fastOutSlowIn
              ],
              valueChanged: (Curve value) {
                _curve = value;
                setState(() {});
              },
            ),
          ),
        ],
      ))
    ]);
  }
}
