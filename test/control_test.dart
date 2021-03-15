import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() {
  testWidgets('Control horizontal', (WidgetTester tester) async {
    final controller = SwiperController();

    final config = SwiperPluginConfig(
        activeIndex: 0,
        controller: controller,
        itemCount: 10,
        loop: true,
        scrollDirection: Axis.horizontal);

    Key key = UniqueKey();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: Builder(builder: (BuildContext context) {
        return SwiperControl(key: key).build(context, config);
      })),
    ));

    expect(find.byKey(key), findsOneWidget);

    var first = true;

    await tester.tap(find.byWidgetPredicate((Widget widget) {
      if (widget is GestureDetector && first) {
        first = false;
        return true;
      }

      return false;
    }));
  });

  testWidgets('Control vertical', (WidgetTester tester) async {
    final controller = SwiperController();

    final config = SwiperPluginConfig(
        activeIndex: 0,
        controller: controller,
        itemCount: 10,
        loop: true,
        scrollDirection: Axis.vertical);

    Key key = UniqueKey();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: Builder(builder: (BuildContext context) {
        return SwiperControl(
                key: key, color: Colors.white, disableColor: Colors.black87)
            .build(context, config);
      })),
    ));

    expect(find.byKey(key), findsOneWidget);

    var first = true;

    await tester.tap(find.byWidgetPredicate((Widget widget) {
      if (widget is GestureDetector && first) {
        first = false;
        return true;
      }

      return false;
    }));
  });
}
