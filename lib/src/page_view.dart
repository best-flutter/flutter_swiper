part of 'swiper.dart';

class _NoneLoopPageViewSwiper extends _PageViewSwiper {
  _NoneLoopPageViewSwiper(
      {double scale,
      bool reverseRendering,
      double fade,
      TransformItemBuilder transformItemBuilder,
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
            reverseRendering: reverseRendering,
            physics: physics,
            transformItemBuilder: transformItemBuilder,
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
    return widget.reverseRendering
        ? widget.itemCount - _activeIndex
        : _activeIndex;
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

  ScrollMetrics _pageMetrics;

  double _calculatePagePosition(int index) {
    final double viewportFraction = widget.viewportFraction ?? 1.0;
    final double pageViewWidth =
        (_pageMetrics?.viewportDimension ?? 1.0) * viewportFraction;
    final double pageX = pageViewWidth *
        (_pageMetrics == null ? 0.0 : _indexToPositionPage(index));
    final double scrollX = (_pageMetrics?.pixels ?? 0.0);
    print("pixels:${_pageMetrics?.pixels} index:$index");
    final double pagePosition = (pageX - scrollX) / pageViewWidth;
    final double safePagePosition = !pagePosition.isNaN ? pagePosition : 0.0;

    return widget.reverseRendering ? -safePagePosition : safePagePosition;
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
            child: _itemBuilder(
              context,
              renderIndex,
            ),
          ),
        );
      },
    );
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

  Widget _buildItemWithPosition(BuildContext context, int index) {
    double position = _calculatePagePosition(index);
    if (widget.reverseRendering) {
      index = widget.itemCount - index;
    }
    index = index % widget.itemCount;
    Widget child = widget.itemBuilder(context, index);

    return widget.transformItemBuilder(child, index, position);
  }

  IndexedWidgetBuilder _calcItemBuilder() {
    IndexedWidgetBuilder itemBuilder;
    if (widget.scale != null || widget.fade != null) {
      if (widget.transformItemBuilder == null) {
        _itemBuilder = widget.itemBuilder;
      } else {
        _itemBuilder = _buildItemWithPosition;
      }
      itemBuilder = _buildAnimationItem;
    } else {
      if (widget.transformItemBuilder == null) {
        itemBuilder = widget.itemBuilder;
      } else {
        itemBuilder = _buildItemWithPosition;
      }
    }

    return itemBuilder;
  }

  IndexedWidgetBuilder _itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0) {
      return new Container();
    }

    IndexedWidgetBuilder itemBuilder = _calcItemBuilder();

    int itemCount = _itemCount();
    Widget pageView = new PageView.builder(
      scrollDirection: widget.scrollDirection,
      physics: widget.physics,
      onPageChanged: _onPageChange,
      reverse: widget.reverseRendering,
      controller: _pageController,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );

    //if we have to listen scroll notification
    pageView = new NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: pageView,
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

  bool _handleScrollNotification(ScrollNotification notification) {
    _pageMetrics = notification.metrics;

    return false;
  }
}

///======================================================

class _PageViewSwiper extends _SubSwiper {
  final double fade;
  final double scale;
  final double viewportFraction;
  final ScrollPhysics physics;
  final double containerWidth;
  final double containerHeight;
  final Axis scrollDirection;
  final TransformItemBuilder transformItemBuilder;
  final bool reverseRendering;

  _PageViewSwiper(
      {this.scale,
      this.fade,
      this.transformItemBuilder,
      bool loop,
      this.physics,
      this.reverseRendering,
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
    return (widget.reverseRendering
            ? widget.itemCount - _activeIndex
            : _activeIndex) +
        kMiddleValue;
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
