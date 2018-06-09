import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:infinity_page_view/infinity_page_view.dart';

void main() {
  testWidgets('Default Swiper', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MaterialApp(
        home: new Swiper(
            itemBuilder: (context, index) {
              return new Text("0");
            },
            itemCount: 10)));

    expect(find.text("0", skipOffstage: false), findsOneWidget);
  });

  testWidgets('Default Swiper loop:false', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MaterialApp(
        home: new Swiper(
      onTap: (int inde) {},
      itemBuilder: (context, index) {
        return new Text("0");
      },
      itemCount: 10,
      loop: false,
    )));

    expect(find.text("0", skipOffstage: true), findsOneWidget);
  });

  testWidgets('Create Swiper with children', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MaterialApp(
        home: new Swiper.children(
      children: <Widget>[new Text("0"), new Text("1")],
    )));

    expect(find.text("0", skipOffstage: false), findsOneWidget);
  });

  testWidgets('Create Swiper with list', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MaterialApp(
        home: new Swiper.list(
      list: ["0", "1"],
      builder: (BuildContext context, dynamic data, int index) {
        return new Text(data);
      },
    )));

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
      pagination: new SwiperCustomPagination(
          builder: (BuildContext context, SwiperPluginConfig config) {
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

    controller.startAutoplay();

    controller.stopAutoplay();

    controller.move(0, animation: true);
    controller.move(0, animation: false);

    controller.next(animation: false);
    controller.previous(animation: true);

    expect(find.text("0", skipOffstage: false), findsOneWidget);
  });

  testWidgets('Swiper fraction', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    SwiperController controller = new SwiperController(0);
    await tester.pumpWidget(new MaterialApp(
        home: new Swiper(
      controller: controller,
      itemBuilder: (context, index) {
        return new Text("0");
      },
      itemCount: 10,
      pagination: new SwiperPagination(builder: SwiperPagination.fraction),
      control: new SwiperControl(),
    )));

    expect(find.text("0", skipOffstage: false), findsOneWidget);
  });
}
