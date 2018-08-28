import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:async';

part 'custom_layout.dart';

typedef void SwiperOnTap(int index);

typedef Widget SwiperDataBuilder(BuildContext context, dynamic data, int index);

/// default auto play delay
const int kDefaultAutoplayDelayMs = 3000;

///  Default auto play transition duration (in millisecond)
const int kDefaultAutoplayTransactionDuration = 300;

const int kMaxValue = 2000000000;
const int kMiddleValue = 1000000000;

enum SwiperLayout { DEFAULT, STACK, TINDER, CUSTOM }

class Swiper extends StatefulWidget {
  /// If set true , the pagination will display 'outer' of the 'content' container.
  final bool outer;

  /// Inner item height, this property is valid if layout=STACK or layout=TINDER or LAYOUT=CUSTOM,
  final double itemHeight;

  /// Inner item width, this property is valid if layout=STACK or layout=TINDER or LAYOUT=CUSTOM,
  final double itemWidth;

  // height of the inside container,this property is valid when outer=true,otherwise the inside container size is controlled by parent widget
  final double containerHeight;
  // width of the inside container,this property is valid when outer=true,otherwise the inside container size is controlled by parent widget
  final double containerWidth;

  /// Build item on index
  final IndexedWidgetBuilder itemBuilder;

  /// count of the display items
  final int itemCount;

  final ValueChanged<int> onIndexChanged;

  ///auto play config
  final bool autoplay;

  ///Duration of the animation between transactions (in millisecond).
  final int autoplayDelay;

  ///disable auto play when interaction
  final bool autoplayDisableOnInteraction;

  ///reverse direction
  final bool reverse;

  ///auto play transition duration (in millisecond)
  final int duration;

  ///horizontal/vertical
  final Axis scrollDirection;

  ///transition curve
  final Curve curve;

  /// Set to false to disable continuous loop mode.
  final bool loop;

  ///Index number of initial slide.
  ///If not set , the `Swiper` is 'uncontrolled', which means manage index by itself
  ///If set , the `Swiper` is 'controlled', which means the index is fully managed by parent widget.
  final int index;

  ///Called when tap
  final SwiperOnTap onTap;

  ///The swiper pagination plugin
  final SwiperPlugin pagination;

  ///the swiper control button plugin
  final SwiperPlugin control;

  ///other plugins, you can custom your own plugin
  final List<SwiperPlugin> plugins;

  ///
  final SwiperController controller;

  final ScrollPhysics physics;

  ///
  final double viewportFraction;

  /// Build in layouts
  final SwiperLayout layout;

  /// this value is valid when layout == SwiperLayout.CUSTOM
  final CustomLayoutOption customLayoutOption;

  // This value is valid when viewportFraction is set and < 1.0
  final double scale;

  // This value is valid when viewportFraction is set and < 1.0
  final double fade;

  Swiper({
    @required this.itemBuilder,
    @required this.itemCount,
    this.autoplay: false,
    this.layout,
    this.autoplayDelay: kDefaultAutoplayDelayMs,
    this.reverse: false,
    this.autoplayDisableOnInteraction: true,
    this.duration: kDefaultAutoplayTransactionDuration,
    this.onIndexChanged,
    this.index,
    this.onTap,
    this.control,
    this.loop: true,
    this.curve: Curves.ease,
    this.scrollDirection: Axis.horizontal,
    this.pagination,
    this.plugins,
    this.physics,
    Key key,
    this.controller,
    this.customLayoutOption,

    /// since v1.0.0
    this.containerHeight,
    this.containerWidth,
    this.viewportFraction: 1.0,
    this.itemHeight,
    this.itemWidth,
    this.outer: false,
    this.scale: 1.0,
    this.fade: 1.0,
  }) : super(key: key);

  factory Swiper.children({
    List<Widget> children,
    bool autoplay: false,
    int autoplayDelay: kDefaultAutoplayDelayMs,
    bool reverse: false,
    bool autoplayDisableOnInteraction: true,
    int duration: kDefaultAutoplayTransactionDuration,
    ValueChanged<int> onIndexChanged,
    int index,
    SwiperOnTap onTap,
    bool loop: true,
    Curve curve: Curves.ease,
    Axis scrollDirection: Axis.horizontal,
    SwiperPlugin pagination,
    SwiperPlugin control,
    List<SwiperPlugin> plugins,
    SwiperController controller,
    Key key,
    CustomLayoutOption customLayoutOption,
    ScrollPhysics physics,
    double containerHeight,
    double containerWidth,
    double viewportFraction: 1.0,
    double itemHeight,
    double itemWidth,
    bool outer: false,
    double scale: 1.0,
  }) {
    assert(children != null, "children must not be null");

    return new Swiper(
        customLayoutOption: customLayoutOption,
        containerHeight: containerHeight,
        containerWidth: containerWidth,
        viewportFraction: viewportFraction,
        itemHeight: itemHeight,
        itemWidth: itemWidth,
        outer: outer,
        scale: scale,
        autoplay: autoplay,
        autoplayDelay: autoplayDelay,
        autoplayDisableOnInteraction: autoplayDisableOnInteraction,
        reverse: reverse,
        duration: duration,
        onIndexChanged: onIndexChanged,
        index: index,
        onTap: onTap,
        curve: curve,
        scrollDirection: scrollDirection,
        pagination: pagination,
        control: control,
        controller: controller,
        loop: loop,
        plugins: plugins,
        physics: physics,
        key: key,
        itemBuilder: (BuildContext context, int index) {
          return children[index];
        },
        itemCount: children.length);
  }

  factory Swiper.list({
    List list,
    CustomLayoutOption customLayoutOption,
    SwiperDataBuilder builder,
    bool autoplay: false,
    int autoplayDelay: kDefaultAutoplayDelayMs,
    bool reverse: false,
    bool autoplayDisableOnInteraction: true,
    int duration: kDefaultAutoplayTransactionDuration,
    ValueChanged<int> onIndexChanged,
    int index,
    SwiperOnTap onTap,
    bool loop: true,
    Curve curve: Curves.ease,
    Axis scrollDirection: Axis.horizontal,
    SwiperPlugin pagination,
    SwiperPlugin control,
    List<SwiperPlugin> plugins,
    SwiperController controller,
    Key key,
    ScrollPhysics physics,
    double containerHeight,
    double containerWidth,
    double viewportFraction: 1.0,
    double itemHeight,
    double itemWidth,
    bool outer: false,
    double scale: 1.0,
  }) {
    return new Swiper(
        customLayoutOption: customLayoutOption,
        containerHeight: containerHeight,
        containerWidth: containerWidth,
        viewportFraction: viewportFraction,
        itemHeight: itemHeight,
        itemWidth: itemWidth,
        outer: outer,
        scale: scale,
        autoplay: autoplay,
        autoplayDelay: autoplayDelay,
        autoplayDisableOnInteraction: autoplayDisableOnInteraction,
        reverse: reverse,
        duration: duration,
        onIndexChanged: onIndexChanged,
        index: index,
        onTap: onTap,
        curve: curve,
        key: key,
        scrollDirection: scrollDirection,
        pagination: pagination,
        control: control,
        controller: controller,
        loop: loop,
        plugins: plugins,
        physics: physics,
        itemBuilder: (BuildContext context, int index) {
          return builder(context, list[index], index);
        },
        itemCount: list.length);
  }

  @override
  State<StatefulWidget> createState() {
    return new _SwiperState();
  }
}

abstract class _SwiperTimerMixin extends State<Swiper> {
  Timer _timer;

  SwiperController _controller;

  @override
  void initState() {
    _controller = widget.controller;
    if (_controller == null) {
      _controller = new SwiperController();
    }
    _controller.addListener(_onController);
    _handleAutoplay();
    super.initState();
  }

  void _onController() {
    switch (_controller.event) {
      case SwiperControllerEvent.START_AUTOPLAY:
        {
          if (_timer == null) {
            _startAutoplay();
          }
        }
        break;
      case SwiperControllerEvent.STOP_AUTOPLAY:
        {
          if (_timer != null) {
            _stopAutoplay();
          }
        }
        break;
      case SwiperControllerEvent.MOVE_INDEX:
      case SwiperControllerEvent.PREV_INDEX:
      case SwiperControllerEvent.NEXT_INDEX:
        break;
    }
  }

  @override
  void didUpdateWidget(Swiper oldWidget) {
    if (_controller != oldWidget.controller) {
      if (oldWidget.controller != null) {
        oldWidget.controller.removeListener(_onController);
        _controller = oldWidget.controller;
        _controller.addListener(_onController);
      }
    }
    _handleAutoplay();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.removeListener(_onController);
      _controller.dispose();
    }

    _stopAutoplay();
    super.dispose();
  }

  bool _isAutoplay() {
    return _controller.autoplay ?? widget.autoplay;
  }

  void _handleAutoplay() {
    _stopAutoplay();
    if (_isAutoplay()) {
      _startAutoplay();
    }
  }

  void _startAutoplay() {
    assert(_timer == null, "Timer must be stopped before start!");
    _timer =
        Timer.periodic(Duration(milliseconds: widget.autoplayDelay), _onTimer);
  }

  void _onTimer(Timer timer) {
    _controller.next(animation: true);
  }

  void _stopAutoplay() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }
}

class _SwiperState extends _SwiperTimerMixin {
  int _activeIndex;


  Widget _wrapTap(BuildContext context, int index) {
    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        this.widget.onTap(index);
      },
      child: widget.itemBuilder(context, index),
    );
  }

  @override
  void initState() {
    _activeIndex = widget.index ?? 0;


    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Swiper oldWidget) {
    if (widget.index != null && widget.index != _activeIndex) {
      _activeIndex = widget.index;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onIndexChanged(int index) {
    setState(() {
      _activeIndex = index;
    });
    if (widget.onIndexChanged != null) {
      widget.onIndexChanged(index);
    }
  }

  Widget _buildSwiper() {
    IndexedWidgetBuilder itemBuilder;
    if (widget.onTap != null) {
      itemBuilder = _wrapTap;
    } else {
      itemBuilder = widget.itemBuilder;
    }

    if (widget.layout == SwiperLayout.STACK) {
      return new _StackSwiper(
        loop: widget.loop,
        itemWidth: widget.itemWidth,
        itemHeight: widget.itemHeight,
        itemCount: widget.itemCount,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
        scrollDirection: widget.scrollDirection,
      );
    } else if (widget.layout == null || widget.layout == SwiperLayout.DEFAULT) {
      if (widget.loop) {
        return new _PageViewSwiper(
          loop: widget.loop,
          containerWidth: widget.containerWidth,
          containerHeight: widget.containerHeight,
          viewportFraction: widget.viewportFraction,
          fade: widget.fade,
          scale: widget.scale,
          itemCount: widget.itemCount,
          itemBuilder: itemBuilder,
          index: _activeIndex,
          curve: widget.curve,
          duration: widget.duration,
          scrollDirection: widget.scrollDirection,
          onIndexChanged: _onIndexChanged,
          controller: _controller,
          physics: widget.physics,
        );
      } else {
        return new _NoneLoopPageViewSwiper(
          containerWidth: widget.containerWidth,
          containerHeight: widget.containerHeight,
          viewportFraction: widget.viewportFraction,
          scale: widget.scale,
          fade: widget.fade,
          itemCount: widget.itemCount,
          itemBuilder: itemBuilder,
          index: _activeIndex,
          curve: widget.curve,
          duration: widget.duration,
          scrollDirection: widget.scrollDirection,
          onIndexChanged: _onIndexChanged,
          controller: _controller,
          physics: widget.physics,
        );
      }
    } else if (widget.layout == SwiperLayout.TINDER) {
      return new _TinderSwiper(
        loop: widget.loop,
        itemWidth: widget.itemWidth,
        itemHeight: widget.itemHeight,
        itemCount: widget.itemCount,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
        scrollDirection: widget.scrollDirection,
      );
    } else if (widget.layout == SwiperLayout.CUSTOM) {
      return new _CustomLayoutSwiper(
        loop: widget.loop,
        option: widget.customLayoutOption,
        itemWidth: widget.itemWidth,
        itemHeight: widget.itemHeight,
        itemCount: widget.itemCount,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
        scrollDirection: widget.scrollDirection,
      );
    } else {
      return new Container();
    }
  }

  SwiperPluginConfig _ensureConfig(SwiperPluginConfig config) {
    if (config == null) {
      config = new SwiperPluginConfig(
          outer: widget.outer,
          itemCount: widget.itemCount,
          activeIndex: _activeIndex,
          scrollDirection: widget.scrollDirection,
          controller: _controller,
          loop: widget.loop);
    }
    return config;
  }

  List<Widget> _ensureListForStack(
      Widget swiper, List<Widget> listForStack, Widget widget) {
    if (listForStack == null) {
      listForStack = [swiper, widget];
    } else {
      listForStack.add(widget);
    }
    return listForStack;
  }

  @override
  Widget build(BuildContext context) {
    Widget swiper = _buildSwiper();
    List<Widget> listForStack;
    SwiperPluginConfig config;
    if (widget.control != null) {
      //Stack
      config = _ensureConfig(config);
      listForStack = _ensureListForStack(
          swiper, listForStack, widget.control.build(context, config));
    }

    if (widget.plugins != null) {
      config = _ensureConfig(config);
      for (SwiperPlugin plugin in widget.plugins) {
        listForStack = _ensureListForStack(
            swiper, listForStack, plugin.build(context, config));
      }
    }
    if (widget.pagination != null) {
      config = _ensureConfig(config);
      if (widget.outer) {
        return _buildOuterPagination(
            widget.pagination,
            listForStack == null ? swiper : new Stack(children: listForStack),
            config);
      } else {
        listForStack = _ensureListForStack(
            swiper, listForStack, widget.pagination.build(context, config));
      }
    }

    if (listForStack != null) {
      return new Stack(
        children: listForStack,
      );
    }

    return swiper;
  }

  Widget _buildOuterPagination(
      SwiperPagination pagination, Widget swiper, SwiperPluginConfig config) {
    List<Widget> list = [];
    //Only support bottom yet!
    if (widget.containerHeight != null || widget.containerWidth != null) {
      list.add(swiper);
    } else {
      list.add(new Expanded(child: swiper));
    }

    list.add(new Align(
      alignment: Alignment.center,
      child: pagination.build(context, config),
    ));

    return new Column(
      children: list,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
    );
  }
}

abstract class _SubSwiper extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final int index;
  final ValueChanged<int> onIndexChanged;
  final SwiperController controller;
  final int duration;
  final Curve curve;
  final double itemWidth;
  final double itemHeight;
  final bool loop;
  final Axis scrollDirection;

  _SubSwiper(
      {Key key,
      this.loop,
      this.itemHeight,
      this.itemWidth,
      this.duration,
      this.curve,
      this.itemBuilder,
      this.controller,
      this.index,
      this.itemCount,
        this.scrollDirection : Axis.horizontal,
      this.onIndexChanged})
      :super(key: key);

  @override
  State<StatefulWidget> createState();

  int getCorrectIndex(int indexNeedsFix) {
    if (itemCount == 0) return 0;
    int value = indexNeedsFix % itemCount;
    if (value < 0) {
      value += itemCount;
    }
    return value;
  }
}

class _TinderSwiper extends _SubSwiper {
  _TinderSwiper(
      {Key key,
      Curve curve,
      int duration,
      SwiperController controller,
      ValueChanged<int> onIndexChanged,
      double itemHeight,
      double itemWidth,
      IndexedWidgetBuilder itemBuilder,
      int index,
      bool loop,
      int itemCount,
        Axis scrollDirection,
      })
      : assert(itemWidth != null && itemHeight != null),
        super(
            loop: loop,
            key: key,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            itemBuilder: itemBuilder,
            curve: curve,
            duration: duration,
            controller: controller,
            index: index,
            onIndexChanged: onIndexChanged,
            itemCount: itemCount,
          scrollDirection:scrollDirection);

  @override
  State<StatefulWidget> createState() {
    return new _TinderState();
  }
}

class _StackSwiper extends _SubSwiper {
  _StackSwiper(
      {Key key,
      Curve curve,
      int duration,
      SwiperController controller,
      ValueChanged<int> onIndexChanged,
      double itemHeight,
      double itemWidth,
      IndexedWidgetBuilder itemBuilder,
      int index,
      bool loop,
      int itemCount,
      Axis scrollDirection,
      })
      : super(
            loop: loop,
            key: key,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            itemBuilder: itemBuilder,
            curve: curve,
            duration: duration,
            controller: controller,
            index: index,
            onIndexChanged: onIndexChanged,
            itemCount: itemCount,
  scrollDirection:scrollDirection);

  @override
  State<StatefulWidget> createState() {
    return new _StackViewState();
  }
}

class _NoneLoopPageViewSwiper extends _PageViewSwiper {
  _NoneLoopPageViewSwiper(
      {double scale,
      double fade,
      ScrollPhysics physics,
      Axis scrollDirection,
      double viewportFraction,
      double containerWidth,
      double containerHeight,
      ValueChanged<int> onIndexChanged,
      Key key,
      IndexedWidgetBuilder itemBuilder,
      Curve curve,
      int duration,
      int index,
      int itemCount,
      SwiperController controller})
      : super(
            scale: scale,
            fade: fade,
            physics: physics,
            scrollDirection: scrollDirection,
            viewportFraction: viewportFraction,
            containerWidth: containerWidth,
            containerHeight: containerHeight,
            key: key,
            itemBuilder: itemBuilder,
            curve: curve,
            duration: duration,
            controller: controller,
            onIndexChanged: onIndexChanged,
            index: index,
            itemCount: itemCount);

  @override
  State<StatefulWidget> createState() {
    return new _NoneloopPageViewState();
  }
}

class _PageViewSwiper extends _SubSwiper {
  final double fade;
  final double scale;
  final double viewportFraction;
  final ScrollPhysics physics;
  final double containerWidth;
  final double containerHeight;
  final Axis scrollDirection;

  _PageViewSwiper(
      {this.scale,
      this.fade,
      bool loop,
      this.physics,
      this.scrollDirection,
      this.viewportFraction,
      ValueChanged<int> onIndexChanged,
      Key key,
      this.containerWidth,
      this.containerHeight,
      IndexedWidgetBuilder itemBuilder,
      Curve curve,
      int duration,
      int index,
      int itemCount,
      SwiperController controller})
      : super(
            loop: loop,
            key: key,
            itemBuilder: itemBuilder,
            curve: curve,
            duration: duration,
            controller: controller,
            onIndexChanged: onIndexChanged,
            index: index,
            itemCount: itemCount);

  @override
  State<StatefulWidget> createState() {
    return new _PageViewState();
  }
}


class _TinderState extends _CustomLayoutStateBase<_TinderSwiper> {
  List<double> scales;
  List<double> offsetsX;
  List<double> offsetsY;
  List<double> opacity;
  List<double> rotates;

  double getOffsetY(double scale) {
    return widget.itemHeight - widget.itemHeight * scale;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void didUpdateWidget(_TinderSwiper oldWidget) {
    _updateValues();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void afterRender() {
    super.afterRender();

    _startIndex = -3;
    _animationCount = 5;
    opacity = [0.0, 0.9, 0.9, 1.0, 0.0, 0.0];
    scales = [0.80, 0.80, 0.85, 0.90, 1.0, 1.0, 1.0];
    rotates = [0.0, 0.0, 0.0, 0.0, 20.0, 25.0];
    _updateValues();

  }



  void _updateValues(){
    if(widget.scrollDirection == Axis.horizontal){
      offsetsX = [0.0, 0.0, 0.0, 0.0, _swiperWidth, _swiperWidth];
      offsetsY = [
        0.0,
        0.0,
        -5.0,
        -10.0,
        -15.0,
        -20.0,
      ];
    }else{

      offsetsX = [
        0.0,
        0.0,
        5.0,
        10.0,
        15.0,
        20.0,
      ];

      offsetsY = [0.0, 0.0, 0.0, 0.0, _swiperHeight, _swiperHeight];

    }
  }




  @override
  Widget _buildItem(int i, int realIndex, double animationValue) {
    double s = _getValue(scales, animationValue, i);
    double f = _getValue(offsetsX, animationValue, i);
    double fy = _getValue(offsetsY, animationValue, i);
    double o = _getValue(opacity, animationValue, i);
    double a = _getValue(rotates, animationValue, i);

    Alignment alignment = widget.scrollDirection == Axis.horizontal?
       Alignment.bottomCenter : Alignment.centerLeft;

    return new Opacity(
      opacity: o,
      child: new Transform.rotate(
        angle: a / 180.0,
        child: new Transform.translate(
          key: new ValueKey<int>(_currentIndex + i),
          offset: new Offset(f, fy),
          child: new Transform.scale(
            scale: s,
            alignment: alignment,
            child: new SizedBox(
              width: widget.itemWidth ?? double.infinity,
              height: widget.itemHeight ?? double.infinity,
              child: widget.itemBuilder(context, realIndex),
            ),
          ),
        ),
      ),
    );
  }
}

class _StackViewState extends _CustomLayoutStateBase<_StackSwiper> {
  List<double> scales;
  List<double> offsets;
  List<double> opacity;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


  }

  void _updateValues(){
    if(widget.scrollDirection == Axis.horizontal){
      double space = (_swiperWidth - widget.itemWidth) / 2;
      offsets = [-space, -space / 3 * 2, -space / 3, 0.0, _swiperWidth];
    }else{
      double space = (_swiperHeight - widget.itemHeight) / 2;
      offsets = [-space, -space / 3 * 2, -space / 3, 0.0, _swiperHeight];
    }
  }

  @override
  void didUpdateWidget(_StackSwiper oldWidget) {
    _updateValues();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void afterRender() {

    super.afterRender();

    //length of the values array below
    _animationCount = 5;

    //Array below this line, '0' index is 1.0 ,witch is the first item show in swiper.
    _startIndex = -3;
    scales = [0.7, 0.8, 0.9, 1.0, 1.0];
    opacity = [0.0, 0.5, 1.0, 1.0, 1.0];

    _updateValues();
  }

  @override
  Widget _buildItem(int i, int realIndex, double animationValue) {
    double s = _getValue(scales, animationValue, i);
    double f = _getValue(offsets, animationValue, i);
    double o = _getValue(opacity, animationValue, i);

    Offset offset = widget.scrollDirection == Axis.horizontal ?
      new Offset(f, 0.0) : new Offset(0.0, f);

    Alignment alignment = widget.scrollDirection == Axis.horizontal ?
      Alignment.centerLeft :Alignment.topCenter;

    return new Opacity(
      opacity: o,
      child: new Transform.translate(
        key: new ValueKey<int>(_currentIndex + i),
        offset: offset,
        child: new Transform.scale(
          scale: s,
          alignment: alignment,
          child: new SizedBox(
            width: widget.itemWidth ?? double.infinity,
            height: widget.itemHeight ?? double.infinity,
            child: widget.itemBuilder(context, realIndex),
          ),
        ),
      ),
    );
  }
}


class _NoneloopPageViewState extends State<_PageViewSwiper> {
  PageController _pageController;
  SwiperController _controller;
  int _activeIndex;

  _NoneloopPageViewState({int activeIndex: 0}) : _activeIndex = activeIndex;

  ///
  int _calcIndex(int index) {
    return index;
  }

  /// return fixed page of the controller
  double _page() {
    if (_pageController.position.maxScrollExtent == null ||
        _pageController.position.minScrollExtent == null) {
      return 0.0;
    }

    return _pageController.page;
  }

  ///
  int _activePositionPage() {
    return _activeIndex;
  }

  int _indexToPositionPage(int index) {
    return index;
  }

  //
  int _indexToActiveIndex(int index) {
    return index;
  }

  ///
  int _itemCount() {
    return widget.itemCount;
  }

  int _nextIndex() {
    return _ensureIndex(_activeIndex + 1);
  }

  int _prevIndex() {
    return _ensureIndex(_activeIndex - 1);
  }

  int _ensureIndex(int index) {
    if (index < 0) {
      return 0;
    }
    if (index >= widget.itemCount - 1) {
      return widget.itemCount - 1;
    }

    return index;
  }

  Widget _buildAnimationItem(BuildContext context, int index) {
    return new AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget w) {
        int newIndex = _calcIndex(index);
        double page = _page();
        double fade = 1.0 -
            widget.curve.transform((page - newIndex).abs().clamp(0.0, 1.0)) *
                (1.0 - widget.fade);
        double scale = 1.0 -
            widget.curve.transform((page - newIndex).abs().clamp(0.0, 1.0)) *
                (1.0 - widget.scale);

        int renderIndex = newIndex % widget.itemCount;
        if (renderIndex < 0) {
          renderIndex += widget.itemCount;
        }

        return new Opacity(
          opacity: fade,
          child: new Transform.scale(
            scale: scale,
            child: widget.itemBuilder(
              context,
              renderIndex,
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    if (widget.index != null) {
      _activeIndex = widget.index;
    }
    _pageController = new PageController(
      initialPage: _activePositionPage(),
      viewportFraction: widget.viewportFraction,
    );

    widget.controller.addListener(_onController);

    super.initState();
  }

  void _move(int nextIndex, bool animation) {
    if (animation) {
      _pageController.animateToPage(_indexToPositionPage(nextIndex),
          duration: new Duration(milliseconds: widget.duration),
          curve: widget.curve);
    } else {
      _pageController
          .jumpToPage(_indexToPositionPage(nextIndex) + kMiddleValue);
    }
  }

  void _onController() {
    switch (widget.controller.event) {
      case SwiperControllerEvent.NEXT_INDEX:
        _move(_nextIndex(), widget.controller.animation);
        break;
      case SwiperControllerEvent.PREV_INDEX:
        _move(_prevIndex(), widget.controller.animation);
        break;
      case SwiperControllerEvent.MOVE_INDEX:
        _move(
            _ensureIndex(widget.controller.index), widget.controller.animation);
        break;
      case SwiperControllerEvent.STOP_AUTOPLAY:
      case SwiperControllerEvent.START_AUTOPLAY:
        break;
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onController);
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_PageViewSwiper oldWidget) {
    if (widget.index != null && widget.index != _activeIndex) {
      if (widget.getCorrectIndex(_activeIndex) != widget.index) {
        _activeIndex = widget.index;
      }
    }

    if (widget.viewportFraction != oldWidget.viewportFraction ||
        (widget.index != null && widget.index != _activeIndex)) {
      _pageController = new PageController(
        initialPage: _activePositionPage(),
        viewportFraction: widget.viewportFraction,
      );
    }

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onController);
      widget.controller.addListener(_onController);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0) {
      return new Container();
    }

    IndexedWidgetBuilder itemBuilder;
    if (widget.scale != null || widget.fade != null) {
      itemBuilder = _buildAnimationItem;
    } else {
      itemBuilder = widget.itemBuilder;
    }

    int itemCount = _itemCount();
    PageView pageView = new PageView.builder(
      scrollDirection: widget.scrollDirection,
      physics: widget.physics,
      onPageChanged: _onPageChange,
      controller: _pageController,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );

    if (widget.containerWidth != null || widget.containerHeight != null) {
      return new SizedBox(
        width: widget.containerWidth ?? double.infinity,
        height: widget.containerHeight ?? double.infinity,
        child: pageView,
      );
    }

    return pageView;
  }

  void _onPageChange(int index) {
    _activeIndex = _indexToActiveIndex(index);
    widget.onIndexChanged(widget.getCorrectIndex(_activeIndex));
  }
}

class _PageViewState extends _NoneloopPageViewState {
  ///
  @override
  int _calcIndex(int index) {
    return index - kMiddleValue;
  }

  @override
  int _nextIndex() {
    return _activeIndex + 1;
  }

  @override
  int _prevIndex() {
    return _activeIndex - 1;
  }

  @override
  int _indexToActiveIndex(int index) {
    return index - kMiddleValue;
  }

  /// return fixed page of the controller
  @override
  double _page() {
    if (_pageController.position.maxScrollExtent == null ||
        _pageController.position.minScrollExtent == null) {
      return 0.0;
    }

    return _pageController.page - kMiddleValue;
  }

  ///
  @override
  int _activePositionPage() {
    return _activeIndex + kMiddleValue;
  }

  @override
  int _indexToPositionPage(int index) {
    return index + kMiddleValue;
  }

  ///
  @override
  int _itemCount() {
    return kMaxValue;
  }
}
