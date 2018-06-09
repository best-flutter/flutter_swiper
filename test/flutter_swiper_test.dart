import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:infinity_page_view/infinity_page_view.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    SwiperController controller = new SwiperController(1);
    await tester.pumpWidget(new MaterialApp(
        home: new Swiper(
            controller: controller,
            itemBuilder: (context, index) {
              return new Text("0");
            },
            itemCount: 1)));

//    // Verify that our counter starts at 0.
    expect(find.text("0", skipOffstage: false), findsOneWidget);
  });
}
