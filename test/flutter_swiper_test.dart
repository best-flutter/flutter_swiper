import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:infinity_page_view/infinity_page_view.dart';

void main() {
  testWidgets('Default Swiper', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    SwiperController controller = new SwiperController(0);
    await tester.pumpWidget(new MaterialApp(
        home: new Swiper(
            controller: controller,
            itemBuilder: (context, index) {
              return new Text("0");
            },
            itemCount: 10)));

//    // Verify that our counter starts at 0.
    expect(find.text("0", skipOffstage: false), findsOneWidget);
  });


  testWidgets('Swiper with default plugins', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    SwiperController controller = new SwiperController(0);
    await tester.pumpWidget(new MaterialApp(
        home: new Swiper(
            controller: controller,
            itemBuilder: (context, index) {
              return new Text("0");
            },
            itemCount: 10,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
        )));

//    // Verify that our counter starts at 0.
    expect(find.text("0", skipOffstage: false), findsOneWidget);
  });

  const List<String> titles = [
    "Flutter Swiper is awosome",
    "Really nice",
    "Yeap"
  ];



  testWidgets('Customize pagination', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    SwiperController controller = new SwiperController(0);
    await tester.pumpWidget(new MaterialApp(
        home: new Swiper(
          controller: controller,
          itemBuilder: (context, index) {
            return new Text("0");
          },
          itemCount: 10,
          pagination:new SwiperCustomPagination(builder:  (BuildContext context, SwiperPluginConfig config){

            return new ConstrainedBox(
              child: new Row(
                children: <Widget>[
                  new Text(
                    "${titles[config.activeIndex]} ${config.activeIndex+1}/${config.itemCount}",
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  new Expanded(
                    child: new Align(
                      alignment: Alignment.centerRight,
                      child: new DotSwiperPaginationBuilder(
                          color: Colors.black12,
                          activeColor: Colors.black,
                          size: 10.0,
                          activeSize: 20.0)
                          .build(context, config),
                    ),
                  )
                ],
              ),
              constraints: new BoxConstraints.expand(height: 50.0),
            );

          }),
          control: new SwiperControl(),
        )));

//    // Verify that our counter starts at 0.
    expect(find.text("0", skipOffstage: false), findsOneWidget);
  });



  testWidgets('fraction', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    SwiperController controller = new SwiperController(0);
    await tester.pumpWidget(new MaterialApp(
        home: new Swiper(
          controller: controller,
          itemBuilder: (context, index) {
            return new Text("0");
          },
          itemCount: 10,
          pagination:new SwiperPagination(
            builder: SwiperPagination.fraction
          ),
          control: new SwiperControl(),
        )));

//    // Verify that our counter starts at 0.
    expect(find.text("0", skipOffstage: false), findsOneWidget);
  });

}
