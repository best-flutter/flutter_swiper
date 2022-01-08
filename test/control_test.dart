import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Control horizontal', (tester) async {
    final controller = SwiperController();

    final config = SwiperPluginConfig(
      activeIndex: 0,
      controller: controller,
      itemCount: 10,
      loop: true,
      scrollDirection: Axis.horizontal,
    );

    final key = UniqueKey();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: Builder(builder: (context) {
        return SwiperControl(key: key).build(context, config);
      })),
    ));

    expect(find.byKey(key), findsOneWidget);

    var first = true;

    await tester.tap(find.byWidgetPredicate((widget) {
      if (widget is GestureDetector && first) {
        first = false;
        return true;
      }

      return false;
    }));
  });

  testWidgets('Control vertical', (tester) async {
    final controller = SwiperController();

    final config = SwiperPluginConfig(
        activeIndex: 0,
        controller: controller,
        itemCount: 10,
        loop: true,
        scrollDirection: Axis.vertical);

    final Key key = UniqueKey();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: Builder(builder: (context) {
        return SwiperControl(
                key: key, color: Colors.white, disableColor: Colors.black87)
            .build(context, config);
      })),
    ));

    expect(find.byKey(key), findsOneWidget);

    var first = true;

    await tester.tap(find.byWidgetPredicate((widget) {
      if (widget is GestureDetector && first) {
        first = false;
        return true;
      }

      return false;
    }));
  });
}
