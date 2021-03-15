part of 'swiper.dart';

abstract class _CustomLayoutStateBase<T extends _SubSwiper> extends State<T>
    with SingleTickerProviderStateMixin {
  double? _swiperWidth;
  double? _swiperHeight;
  late Animation<double> _animation;
  AnimationController? _animationController;
  late int _startIndex;
  int? _animationCount;

  @override
  void initState() {
    if (widget.itemWidth == null) {
      throw Exception(
        '==============\n\nwidget.itemWith must not be null when use stack layout.\n========\n',
      );
    }

    _createAnimationController();
    widget.controller!.addListener(_onController);
    super.initState();
  }

  void _createAnimationController() {
    _animationController = AnimationController(vsync: this, value: 0.5);
    final tween = Tween(begin: 0.0, end: 1.0);
    _animation = tween.animate(_animationController!);
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback(_getSize);
    super.didChangeDependencies();
  }

  void _getSize(_) {
    afterRender();
  }

  @mustCallSuper
  void afterRender() {
    final renderObject = context.findRenderObject()!;
    final size = renderObject.paintBounds.size;
    _swiperWidth = size.width;
    _swiperHeight = size.height;
    setState(() {});
  }

  @override
  void didUpdateWidget(T oldWidget) {
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller!.removeListener(_onController);
      widget.controller!.addListener(_onController);
    }

    if (widget.loop != oldWidget.loop) {
      if (!widget.loop!) {
        _currentIndex = _ensureIndex(_currentIndex);
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  int _ensureIndex(int index) {
    index = index % widget.itemCount!;
    if (index < 0) {
      index += widget.itemCount!;
    }
    return index;
  }

  @override
  void dispose() {
    widget.controller!.removeListener(_onController);
    _animationController?.dispose();
    super.dispose();
  }

  Widget _buildItem(int i, int realIndex, double animationValue);

  Widget _buildContainer(List<Widget> list) {
    return Stack(
      children: list,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? w) {
    var list = <Widget>[];

    final animationValue = _animation.value;

    for (var i = 0; i < _animationCount!; ++i) {
      var realIndex = _currentIndex + i + _startIndex;
      realIndex = realIndex % widget.itemCount!;
      if (realIndex < 0) {
        realIndex += widget.itemCount!;
      }

      list.add(_buildItem(i, realIndex, animationValue));
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: _onPanStart,
      onPanEnd: _onPanEnd,
      onPanUpdate: _onPanUpdate,
      child: ClipRect(
        child: Center(
          child: _buildContainer(list),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_animationCount == null) {
      return Container();
    }
    return AnimatedBuilder(
        animation: _animationController!, builder: _buildAnimation);
  }

  late double _currentValue;
  late double _currentPos;

  bool _lockScroll = false;

  void _move(double position, {int? nextIndex}) async {
    if (_lockScroll) return;
    try {
      _lockScroll = true;
      await _animationController!.animateTo(position,
          duration: Duration(milliseconds: widget.duration!),
          curve: widget.curve!);
      if (nextIndex != null) {
        widget.onIndexChanged!(widget.getCorrectIndex(nextIndex));
      }
    } catch (e) {
      print(e);
    } finally {
      if (nextIndex != null) {
        try {
          _animationController!.value = 0.5;
        } catch (e) {
          print(e);
        }

        _currentIndex = nextIndex;
      }
      _lockScroll = false;
    }
  }

  int _nextIndex() {
    final index = _currentIndex + 1;
    if (!widget.loop! && index >= widget.itemCount! - 1) {
      return widget.itemCount! - 1;
    }
    return index;
  }

  int _prevIndex() {
    final index = _currentIndex - 1;
    if (!widget.loop! && index < 0) {
      return 0;
    }
    return index;
  }

  void _onController() {
    switch (widget.controller!.event) {
      case IndexController.PREVIOUS:
        final prevIndex = _prevIndex();
        if (prevIndex == _currentIndex) return;
        _move(1.0, nextIndex: prevIndex);
        break;
      case IndexController.NEXT:
        final nextIndex = _nextIndex();
        if (nextIndex == _currentIndex) return;
        _move(0.0, nextIndex: nextIndex);
        break;
      case IndexController.MOVE:
        throw Exception(
            'Custom layout does not support SwiperControllerEvent.MOVE_INDEX yet!');
      case SwiperController.STOP_AUTOPLAY:
      case SwiperController.START_AUTOPLAY:
        break;
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_lockScroll) return;

    final velocity = widget.scrollDirection == Axis.horizontal
        ? details.velocity.pixelsPerSecond.dx
        : details.velocity.pixelsPerSecond.dy;

    if (_animationController!.value >= 0.75 || velocity > 500.0) {
      if (_currentIndex <= 0 && !widget.loop!) {
        return;
      }
      _move(1.0, nextIndex: _currentIndex - 1);
    } else if (_animationController!.value < 0.25 || velocity < -500.0) {
      if (_currentIndex >= widget.itemCount! - 1 && !widget.loop!) {
        return;
      }
      _move(0.0, nextIndex: _currentIndex + 1);
    } else {
      _move(0.5);
    }
  }

  void _onPanStart(DragStartDetails details) {
    if (_lockScroll) return;
    _currentValue = _animationController!.value;
    _currentPos = widget.scrollDirection == Axis.horizontal
        ? details.globalPosition.dx
        : details.globalPosition.dy;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_lockScroll) return;
    var value = _currentValue +
        ((widget.scrollDirection == Axis.horizontal
                    ? details.globalPosition.dx
                    : details.globalPosition.dy) -
                _currentPos) /
            _swiperWidth! /
            2;
    // no loop ?
    if (!widget.loop!) {
      if (_currentIndex >= widget.itemCount! - 1) {
        if (value < 0.5) {
          value = 0.5;
        }
      } else if (_currentIndex <= 0) {
        if (value > 0.5) {
          value = 0.5;
        }
      }
    }

    _animationController!.value = value;
  }

  int _currentIndex = 0;
}

double? _getValue(List<double?> values, double animationValue, int index) {
  var s = values[index];
  if (animationValue >= 0.5) {
    if (index < values.length - 1) {
      s = s! + (values[index + 1]! - s) * (animationValue - 0.5) * 2.0;
    }
  } else {
    if (index != 0) {
      s = s! - (s - values[index - 1]!) * (0.5 - animationValue) * 2.0;
    }
  }
  return s;
}

Offset _getOffsetValue(List<Offset> values, double animationValue, int index) {
  final s = values[index];
  var dx = s.dx;
  var dy = s.dy;
  if (animationValue >= 0.5) {
    if (index < values.length - 1) {
      dx = dx + (values[index + 1].dx - dx) * (animationValue - 0.5) * 2.0;
      dy = dy + (values[index + 1].dy - dy) * (animationValue - 0.5) * 2.0;
    }
  } else {
    if (index != 0) {
      dx = dx - (dx - values[index - 1].dx) * (0.5 - animationValue) * 2.0;
      dy = dy - (dy - values[index - 1].dy) * (0.5 - animationValue) * 2.0;
    }
  }
  return Offset(dx, dy);
}

abstract class TransformBuilder<T> {
  List<T>? values;

  TransformBuilder({this.values});

  Widget build(int i, double animationValue, Widget widget);
}

class ScaleTransformBuilder extends TransformBuilder<double> {
  final Alignment alignment;

  ScaleTransformBuilder(
      {List<double>? values, this.alignment = Alignment.center})
      : super(values: values);

  @override
  Widget build(int i, double animationValue, Widget widget) {
    final s = _getValue(values!, animationValue, i)!;
    return Transform.scale(scale: s, child: widget);
  }
}

class OpacityTransformBuilder extends TransformBuilder<double> {
  OpacityTransformBuilder({List<double>? values}) : super(values: values);

  @override
  Widget build(int i, double animationValue, Widget widget) {
    final v = _getValue(values!, animationValue, i)!;
    return Opacity(
      opacity: v,
      child: widget,
    );
  }
}

class RotateTransformBuilder extends TransformBuilder<double> {
  RotateTransformBuilder({List<double>? values}) : super(values: values);

  @override
  Widget build(int i, double animationValue, Widget widget) {
    final v = _getValue(values!, animationValue, i)!;
    return Transform.rotate(
      angle: v,
      child: widget,
    );
  }
}

class TranslateTransformBuilder extends TransformBuilder<Offset> {
  TranslateTransformBuilder({List<Offset>? values}) : super(values: values);

  @override
  Widget build(int i, double animationValue, Widget widget) {
    final s = _getOffsetValue(values!, animationValue, i);
    return Transform.translate(
      offset: s,
      child: widget,
    );
  }
}

class CustomLayoutOption {
  final List<TransformBuilder> builders = [];
  final int startIndex;
  final int? stateCount;

  CustomLayoutOption({this.stateCount, required this.startIndex});

  CustomLayoutOption addOpacity(List<double> values) {
    builders.add(OpacityTransformBuilder(values: values));
    return this;
  }

  CustomLayoutOption addTranslate(List<Offset> values) {
    builders.add(TranslateTransformBuilder(values: values));
    return this;
  }

  CustomLayoutOption addScale(List<double> values, Alignment alignment) {
    builders.add(ScaleTransformBuilder(values: values, alignment: alignment));
    return this;
  }

  CustomLayoutOption addRotate(List<double> values) {
    builders.add(RotateTransformBuilder(values: values));
    return this;
  }
}

class _CustomLayoutSwiper extends _SubSwiper {
  final CustomLayoutOption option;

  _CustomLayoutSwiper({
    required this.option,
    double? itemWidth,
    bool? loop,
    double? itemHeight,
    ValueChanged<int>? onIndexChanged,
    Key? key,
    IndexedWidgetBuilder? itemBuilder,
    Curve? curve,
    int? duration,
    int? index,
    int? itemCount,
    Axis? scrollDirection,
    SwiperController? controller,
  }) : super(
            loop: loop,
            onIndexChanged: onIndexChanged,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            key: key,
            itemBuilder: itemBuilder,
            curve: curve,
            duration: duration,
            index: index,
            itemCount: itemCount,
            controller: controller,
            scrollDirection: scrollDirection);

  @override
  State<StatefulWidget> createState() {
    return _CustomLayoutState();
  }
}

class _CustomLayoutState extends _CustomLayoutStateBase<_CustomLayoutSwiper> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startIndex = widget.option.startIndex;
    _animationCount = widget.option.stateCount;
  }

  @override
  void didUpdateWidget(_CustomLayoutSwiper oldWidget) {
    _startIndex = widget.option.startIndex;
    _animationCount = widget.option.stateCount;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget _buildItem(int index, int realIndex, double animationValue) {
    final builders = widget.option.builders;

    Widget child = SizedBox(
        width: widget.itemWidth ?? double.infinity,
        height: widget.itemHeight ?? double.infinity,
        child: widget.itemBuilder!(context, realIndex));

    for (var i = builders.length - 1; i >= 0; --i) {
      var builder = builders[i];
      child = builder.build(index, animationValue, child);
    }

    return child;
  }
}
