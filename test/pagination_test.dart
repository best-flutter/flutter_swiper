import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() {
  testWidgets('Pagination', (WidgetTester tester) async {
    SwiperController controller = new SwiperController(0);

    SwiperPluginConfig config = new SwiperPluginConfig(
        activeIndex: 0,
        controller: controller,
        itemCount: 10,
        scrollDirection: Axis.horizontal);

    Key key = new UniqueKey();
    await tester.pumpWidget(new MaterialApp(
      home: new Scaffold(body: new Builder(builder: (BuildContext context) {
        return new DotSwiperPaginationBuilder(
                key: key,
                activeColor: new Color(0xff000000),
                color: new Color(0xffffffff),
                space: 10.0,
                size: 10.0,
                activeSize: 20.0)
            .build(context, config);
      })),
    ));

    for (int i = 0; i < 10; ++i) {
      expect(find.byWidgetPredicate((Widget widget) {
        if (widget.key != null &&
            widget.key is ValueKey &&
            (widget.key as ValueKey).value == 'pagination_$i') return true;

        return false;
      }), findsOneWidget);
    }

    expect(find.byKey(key), findsOneWidget);
  });
}
