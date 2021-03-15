library transformer_page_view;

import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/src/transformer_page_view/index_controller.dart';

///
/// NOTICE::
///
/// In order to make package smaller,currently we're not supporting any build-in page transformers
/// You can find build in transforms here:
///
///
///

const int kMaxValue = 2000000000;
const int kMiddleValue = 1000000000;

///  Default auto play transition duration (in millisecond)
const int kDefaultTransactionDuration = 300;

class TransformInfo {
  /// The `width` of the `TransformerPageView`
  final double? width;

  /// The `height` of the `TransformerPageView`
  final double? height;

  /// The `position` of the widget pass to [PageTransformer.transform]
  ///  A `position` describes how visible the widget is.
  ///  The widget in the center of the screen' which is  full visible, position is 0.0.
  ///  The widge in the left ,may be hidden, of the screen's position is less than 0.0, -1.0 when out of the screen.
  ///  The widge in the right ,may be hidden, of the screen's position is greater than 0.0,  1.0 when out of the screen
  ///
  ///
  final double? position;

  /// The `index` of the widget pass to [PageTransformer.transform]
  final int? index;

  /// The `activeIndex` of the PageView
  final int? activeIndex;

  /// The `activeIndex` of the PageView, from user start to swipe
  /// It will change when user end drag
  final int? fromIndex;

  /// Next `index` is greater than this `index`
  final bool? forward;

  /// User drag is done.
  final bool? done;

  /// Same as [TransformerPageView.viewportFraction]
  final double? viewportFraction;

  /// Copy from [TransformerPageView.scrollDirection]
  final Axis? scrollDirection;

  TransformInfo({
    this.index,
    this.position,
    this.width,
    this.height,
    this.activeIndex,
    this.fromIndex,
    this.forward,
    this.done,
    this.viewportFraction,
    this.scrollDirection,
  });
}

abstract class PageTransformer {
  ///
  final bool reverse;

  PageTransformer({this.reverse = false});

  /// Return a transformed widget, based on child and TransformInfo
  Widget transform(Widget child, TransformInfo info);
}

typedef PageTransformerBuilderCallback = Function(
    Widget child, TransformInfo info);

class PageTransformerBuilder extends PageTransformer {
  final PageTransformerBuilderCallback builder;

  PageTransformerBuilder({bool reverse = false, required this.builder})
      : super(reverse: reverse);

  @override
  Widget transform(Widget child, TransformInfo info) {
    return builder(child, info);
  }
}

class TransformerPageController extends PageController {
  final bool loop;
  final int itemCount;
  final bool reverse;

  TransformerPageController({
    int initialPage = 0,
    bool keepPage = true,
    double viewportFraction = 1.0,
    this.loop = false,
    this.itemCount = 0,
    this.reverse = false,
  }) : super(
            initialPage: TransformerPageController._getRealIndexFromRenderIndex(
                initialPage, loop, itemCount, reverse),
            keepPage: keepPage,
            viewportFraction: viewportFraction);

  int? getRenderIndexFromRealIndex(num index) {
    return _getRenderIndexFromRealIndex(index, loop, itemCount, reverse);
  }

  int? getRealItemCount() {
    if (itemCount == 0) return 0;
    return loop ? itemCount + kMaxValue : itemCount;
  }

  static int? _getRenderIndexFromRealIndex(
      num? index, bool loop, int? itemCount, bool reverse) {
    if (itemCount == 0) return 0;
    int? renderIndex;
    if (loop) {
      renderIndex = index! - kMiddleValue as int?;
      renderIndex = renderIndex! % itemCount!;
      if (renderIndex < 0) {
        renderIndex += itemCount;
      }
    } else {
      renderIndex = index as int?;
    }
    if (reverse) {
      renderIndex = itemCount! - renderIndex! - 1;
    }

    return renderIndex;
  }

  double get realPage => super.page ?? 0.0;

  static double? _getRenderPageFromRealPage(
      double? page, bool loop, int? itemCount, bool reverse) {
    double? renderPage;
    if (loop) {
      renderPage = page! - kMiddleValue;
      renderPage = renderPage % itemCount!;
      if (renderPage < 0) {
        renderPage += itemCount;
      }
    } else {
      renderPage = page;
    }
    if (reverse) {
      renderPage = itemCount! - renderPage! - 1;
    }

    return renderPage;
  }

  @override
  double? get page {
    return loop
        ? _getRenderPageFromRealPage(realPage, loop, itemCount, reverse)
        : realPage;
  }

  int? getRealIndexFromRenderIndex(num index) {
    return _getRealIndexFromRenderIndex(index, loop, itemCount, reverse);
  }

  static int _getRealIndexFromRenderIndex(
      num index, bool loop, int itemCount, bool reverse) {
    var result = reverse ? itemCount - index - 1 as int : index as int;
    if (loop) {
      result += kMiddleValue;
    }
    return result;
  }
}

class TransformerPageView extends StatefulWidget {
  /// Create a `transformed` widget base on the widget that has been passed to  the [PageTransformer.transform].
  /// See [TransformInfo]
  ///
  final PageTransformer? transformer;

  /// Same as [PageView.scrollDirection]
  ///
  /// Defaults to [Axis.horizontal].
  final Axis scrollDirection;

  /// Same as [PageView.physics]
  final ScrollPhysics? physics;

  /// Set to false to disable page snapping, useful for custom scroll behavior.
  /// Same as [PageView.pageSnapping]
  final bool pageSnapping;

  /// Called whenever the page in the center of the viewport changes.
  /// Same as [PageView.onPageChanged]
  final ValueChanged<int?>? onPageChanged;

  final IndexedWidgetBuilder? itemBuilder;

  // See [IndexController.mode],[IndexController.next],[IndexController.previous]
  final IndexController? controller;

  /// Animation duration
  final Duration duration;

  /// Animation curve
  final Curve curve;

  final TransformerPageController? pageController;

  /// Set true to open infinity loop mode.
  final bool loop;

  /// This value is only valid when `pageController` is not set,
  final int itemCount;

  /// This value is only valid when `pageController` is not set,
  final double viewportFraction;

  /// If not set, it is controlled by this widget.
  final int? index;

  /// Creates a scrollable list that works page by page using widgets that are
  /// created on demand.
  ///
  /// This constructor is appropriate for page views with a large (or infinite)
  /// number of children because the builder is called only for those children
  /// that are actually visible.
  ///
  /// Providing a non-null [itemCount] lets the [PageView] compute the maximum
  /// scroll extent.
  ///
  /// [itemBuilder] will be called only with indices greater than or equal to
  /// zero and less than [itemCount].
  TransformerPageView({
    Key? key,
    this.index,
    Duration? duration,
    this.curve = Curves.ease,
    this.viewportFraction = 1.0,
    this.loop = false,
    this.scrollDirection = Axis.horizontal,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    this.controller,
    this.transformer,
    this.itemBuilder,
    this.pageController,
    required this.itemCount,
  })   : assert(itemCount == 0 || itemBuilder != null || transformer != null),
        duration =
            duration ?? Duration(milliseconds: kDefaultTransactionDuration),
        super(key: key);

  factory TransformerPageView.children(
      {Key? key,
      int? index,
      Duration? duration,
      Curve curve = Curves.ease,
      double viewportFraction = 1.0,
      bool loop = false,
      Axis scrollDirection = Axis.horizontal,
      ScrollPhysics? physics,
      bool pageSnapping = true,
      ValueChanged<int?>? onPageChanged,
      IndexController? controller,
      PageTransformer? transformer,
      required List<Widget> children,
      TransformerPageController? pageController}) {
    return TransformerPageView(
      itemCount: children.length,
      itemBuilder: (BuildContext context, int index) {
        return children[index];
      },
      pageController: pageController,
      transformer: transformer,
      pageSnapping: pageSnapping,
      key: key,
      index: index,
      duration: duration,
      curve: curve,
      viewportFraction: viewportFraction,
      scrollDirection: scrollDirection,
      physics: physics,
      onPageChanged: onPageChanged,
      controller: controller,
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _TransformerPageViewState();
  }

  static int? getRealIndexFromRenderIndex({
    required bool reverse,
    int index = 0,
    int itemCount = 0,
    required bool loop,
  }) {
    var initPage = reverse ? (itemCount - index - 1) : index;
    if (loop) {
      initPage += kMiddleValue;
    }
    return initPage;
  }

  static PageController createPageController(
      {required bool reverse,
      int index = 0,
      int itemCount = 0,
      required bool loop,
      required double viewportFraction}) {
    return PageController(
        initialPage: getRealIndexFromRenderIndex(
            reverse: reverse, index: index, itemCount: itemCount, loop: loop)!,
        viewportFraction: viewportFraction);
  }
}

class _TransformerPageViewState extends State<TransformerPageView> {
  Size? _size;
  int _activeIndex = 0;
  double? _currentPixels;
  bool _done = false;

  ///This value will not change until user end drag.
  int? _fromIndex;

  PageTransformer? _transformer;

  TransformerPageController? _pageController;

  Widget _buildItemNormal(BuildContext context, int index) {
    final renderIndex = _pageController!.getRenderIndexFromRealIndex(index)!;
    return widget.itemBuilder!(context, renderIndex);
  }

  Widget _buildItem(BuildContext context, int index) {
    return AnimatedBuilder(
        animation: _pageController!,
        builder: (BuildContext c, Widget? w) {
          var renderIndex = _pageController!.getRenderIndexFromRealIndex(index);
          Widget? child;
          if (widget.itemBuilder != null) {
            child = widget.itemBuilder!(context, renderIndex!);
          }

          child ??= Container();

          if (_size == null) {
            return child;
          }

          double position;

          double? page = _pageController!.realPage;

          if (_transformer!.reverse) {
            position = page - index;
          } else {
            position = index - page;
          }
          position *= widget.viewportFraction;

          final info = TransformInfo(
            index: renderIndex,
            width: _size!.width,
            height: _size!.height,
            position: position.clamp(-1.0, 1.0),
            activeIndex:
                _pageController!.getRenderIndexFromRealIndex(_activeIndex),
            fromIndex: _fromIndex,
            forward: _pageController!.position.pixels - _currentPixels! >= 0,
            done: _done,
            scrollDirection: widget.scrollDirection,
            viewportFraction: widget.viewportFraction,
          );

          return _transformer!.transform(child, info);
        });
  }

  double? _calcCurrentPixels() {
    _currentPixels =
        _pageController!.getRenderIndexFromRealIndex(_activeIndex)! *
            _pageController!.position.viewportDimension *
            widget.viewportFraction;

    //  print("activeIndex:$_activeIndex , pix:$_currentPixels");

    return _currentPixels;
  }

  @override
  Widget build(BuildContext context) {
    final builder = _transformer == null ? _buildItemNormal : _buildItem;
    var child = PageView.builder(
      itemBuilder: builder,
      itemCount: _pageController!.getRealItemCount(),
      onPageChanged: _onIndexChanged,
      controller: _pageController,
      scrollDirection: widget.scrollDirection,
      physics: widget.physics,
      pageSnapping: widget.pageSnapping,
      reverse: _pageController!.reverse,
    );
    if (_transformer == null) {
      return child;
    }
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          _calcCurrentPixels();
          _done = false;
          _fromIndex = _activeIndex;
        } else if (notification is ScrollEndNotification) {
          _calcCurrentPixels();
          _fromIndex = _activeIndex;
          _done = true;
        }

        return false;
      },
      child: child,
    );
  }

  void _onIndexChanged(int index) {
    _activeIndex = index;
    if (widget.onPageChanged != null) {
      widget
          .onPageChanged!(_pageController!.getRenderIndexFromRealIndex(index));
    }
  }

  void _onGetSize(_) {
    Size? size;

    // if (context == null) {
    //   onGetSize(size);
    //   return;
    // }
    final renderObject = context.findRenderObject();
    if (renderObject != null) {
      final bounds = renderObject.paintBounds;
      size = bounds.size;
    }
    _calcCurrentPixels();
    onGetSize(size);
  }

  void onGetSize(Size? size) {
    if (mounted) {
      setState(() {
        _size = size;
      });
    }
  }

  @override
  void initState() {
    _transformer = widget.transformer;
    // int index = widget.index ?? 0;
    _pageController = widget.pageController;
    _pageController ??= TransformerPageController(
        initialPage: widget.index ?? 0,
        itemCount: widget.itemCount,
        loop: widget.loop,
        reverse:
            widget.transformer == null ? false : widget.transformer!.reverse);
    // int initPage = _getRealIndexFromRenderIndex(index);
    // _pageController =  PageController(initialPage: initPage,viewportFraction: widget.viewportFraction);
    _fromIndex = _activeIndex = _pageController!.initialPage;

    _controller = getNotifier();
    if (_controller != null) {
      _controller!.addListener(onChangeNotifier);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(TransformerPageView oldWidget) {
    _transformer = widget.transformer;
    final index = widget.index ?? 0;
    var created = false;
    if (_pageController != widget.pageController) {
      if (widget.pageController != null) {
        _pageController = widget.pageController;
      } else {
        created = true;
        _pageController = TransformerPageController(
            initialPage: widget.index ?? 0,
            itemCount: widget.itemCount,
            loop: widget.loop,
            reverse: widget.transformer == null
                ? false
                : widget.transformer!.reverse);
      }
    }

    if (_pageController!.getRenderIndexFromRealIndex(_activeIndex) != index) {
      _fromIndex = _activeIndex = _pageController!.initialPage;
      if (!created) {
        final initPage = _pageController!.getRealIndexFromRenderIndex(index)!;
        _pageController!.animateToPage(initPage,
            duration: widget.duration, curve: widget.curve);
      }
    }
    if (_transformer != null) {
      WidgetsBinding.instance!.addPostFrameCallback(_onGetSize);
    }

    if (_controller != getNotifier()) {
      if (_controller != null) {
        _controller!.removeListener(onChangeNotifier);
      }
      _controller = getNotifier();
      if (_controller != null) {
        _controller!.addListener(onChangeNotifier);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    if (_transformer != null) {
      WidgetsBinding.instance!.addPostFrameCallback(_onGetSize);
    }
    super.didChangeDependencies();
  }

  ChangeNotifier? getNotifier() {
    return widget.controller;
  }

  int _calcNextIndex(bool next) {
    var currentIndex = _activeIndex;
    if (_pageController!.reverse) {
      if (next) {
        currentIndex--;
      } else {
        currentIndex++;
      }
    } else {
      if (next) {
        currentIndex++;
      } else {
        currentIndex--;
      }
    }

    if (!_pageController!.loop) {
      if (currentIndex >= _pageController!.itemCount) {
        currentIndex = 0;
      } else if (currentIndex < 0) {
        currentIndex = _pageController!.itemCount - 1;
      }
    }

    return currentIndex;
  }

  void onChangeNotifier() {
    final event = widget.controller!.event;
    var index;
    switch (event) {
      case IndexController.MOVE:
        {
          index = _pageController!
              .getRealIndexFromRenderIndex(widget.controller!.index!);
        }
        break;
      case IndexController.PREVIOUS:
      case IndexController.NEXT:
        {
          index = _calcNextIndex(event == IndexController.NEXT);
        }
        break;
      default:
        //ignore this event
        return;
    }
    if (widget.controller!.animation!) {
      _pageController!
          .animateToPage(index!, duration: widget.duration, curve: widget.curve)
          .whenComplete(widget.controller!.complete);
    } else {
      _pageController!.jumpToPage(index!);
      widget.controller!.complete();
    }
  }

  ChangeNotifier? _controller;

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.removeListener(onChangeNotifier);
    }
    super.dispose();
  }
}
