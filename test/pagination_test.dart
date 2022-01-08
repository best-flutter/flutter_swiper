import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Pagination', (tester) async {
    final controller = SwiperController();

    final config = SwiperPluginConfig(
      activeIndex: 0,
      controller: controller,
      itemCount: 10,
      scrollDirection: Axis.horizontal,
    );

    final key = UniqueKey();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: Builder(builder: (context) {
        return DotSwiperPaginationBuilder(
          key: key,
          activeColor: const Color(0xff000000),
          color: const Color(0xffffffff),
          space: 10.0,
          size: 10.0,
          activeSize: 20.0,
        ).build(context, config);
      })),
    ));

    for (var i = 0; i < 10; ++i) {
      expect(find.byWidgetPredicate((widget) {
        final key = widget.key;
        return key != null && key is ValueKey && key.value == 'pagination_$i';
      }), findsOneWidget);
    }

    expect(find.byKey(key), findsOneWidget);
  });

  testWidgets('Pagination vertical', (tester) async {
    final controller = SwiperController();

    final config = SwiperPluginConfig(
      activeIndex: 0,
      controller: controller,
      itemCount: 10,
      scrollDirection: Axis.vertical,
    );

    final key = UniqueKey();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: Builder(builder: (context) {
        return DotSwiperPaginationBuilder(
                key: key,
                activeColor: const Color(0xff000000),
                color: const Color(0xffffffff),
                space: 10.0,
                size: 10.0,
                activeSize: 20.0)
            .build(context, config);
      })),
    ));

    for (var i = 0; i < 10; ++i) {
      expect(find.byWidgetPredicate((widget) {
        final key = widget.key;
        return key != null && key is ValueKey && key.value == 'pagination_$i';
      }), findsOneWidget);
    }

    expect(find.byKey(key), findsOneWidget);
  });

  testWidgets('Pagination fraction', (tester) async {
    final controller = SwiperController();

    final config = SwiperPluginConfig(
        activeIndex: 0,
        controller: controller,
        itemCount: 10,
        scrollDirection: Axis.horizontal);

    final Key key = UniqueKey();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: Builder(builder: (context) {
        return FractionPaginationBuilder(
          key: key,
          activeColor: const Color(0xff000000),
          color: const Color(0xffffffff),
        ).build(context, config);
      })),
    ));

    expect(find.text('1'), findsOneWidget);
    expect(find.text(' / 10'), findsOneWidget);

    expect(find.byKey(key), findsOneWidget);
  });

  testWidgets('Pagination fraction vertical', (tester) async {
    final controller = SwiperController();

    final config = SwiperPluginConfig(
      activeIndex: 0,
      controller: controller,
      itemCount: 10,
      scrollDirection: Axis.vertical,
    );

    final Key key = UniqueKey();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: Builder(builder: (context) {
        return FractionPaginationBuilder(
          key: key,
          activeColor: const Color(0xff000000),
          color: const Color(0xffffffff),
        ).build(context, config);
      })),
    ));

    expect(find.text('1'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);

    expect(find.byKey(key), findsOneWidget);
  });
}
